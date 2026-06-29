#!/usr/bin/env python3
"""Linda Data model tuning templates for Python.

Copy a block, replace DATA, TARGET, PREDICTORS, GROUP, ID, TIME, and METRIC.
Common packages: pandas, numpy, statsmodels, scikit-learn, xgboost.
"""

from __future__ import annotations

import json
from typing import Any

import numpy as np
import pandas as pd

from sklearn.base import BaseEstimator
from sklearn.compose import TransformedTargetRegressor
from sklearn.dummy import DummyRegressor, DummyClassifier
from sklearn.ensemble import (
    GradientBoostingRegressor,
    HistGradientBoostingRegressor,
    RandomForestRegressor,
    StackingRegressor,
)
from sklearn.impute import SimpleImputer
from sklearn.linear_model import (
    ElasticNetCV,
    LassoCV,
    LinearRegression,
    LogisticRegression,
    LogisticRegressionCV,
    RidgeCV,
)
from sklearn.metrics import (
    accuracy_score,
    brier_score_loss,
    mean_absolute_error,
    mean_squared_error,
    precision_recall_curve,
    r2_score,
    roc_auc_score,
)
from sklearn.model_selection import (
    GridSearchCV,
    GroupKFold,
    KFold,
    RandomizedSearchCV,
    TimeSeriesSplit,
    cross_validate,
    train_test_split,
)
from sklearn.pipeline import Pipeline, make_pipeline
from sklearn.preprocessing import StandardScaler
from sklearn.tree import DecisionTreeRegressor


# -----------------------------
# 0. Universal setup
# -----------------------------
DATA_PATH = "statistical-analytics/data/r-builtins/mtcars.csv"
DATA = pd.read_csv(DATA_PATH)
TARGET = "mpg"
PREDICTORS = ["wt", "hp", "disp", "qsec", "am"]
CLASS_TARGET = "am"
METRIC = "neg_root_mean_squared_error"
RANDOM_STATE = 123


def score_regression(actual: pd.Series, predicted: np.ndarray) -> dict[str, float]:
    return {
        "rmse": float(np.sqrt(mean_squared_error(actual, predicted))),
        "mae": float(mean_absolute_error(actual, predicted)),
        "r_squared": float(r2_score(actual, predicted)),
    }


def profile_data(df: pd.DataFrame) -> pd.DataFrame:
    return pd.DataFrame(
        {
            "variable": df.columns,
            "dtype": [str(df[col].dtype) for col in df.columns],
            "rows": len(df),
            "missing": [int(df[col].isna().sum()) for col in df.columns],
            "missing_rate": [float(df[col].isna().mean()) for col in df.columns],
            "unique_values": [int(df[col].nunique(dropna=False)) for col in df.columns],
        }
    )


def evaluate_regressor(
    name: str,
    model: BaseEstimator,
    x_train: pd.DataFrame,
    x_test: pd.DataFrame,
    y_train: pd.Series,
    y_test: pd.Series,
    parameters: str = "",
) -> dict[str, Any]:
    model.fit(x_train, y_train)
    predicted = model.predict(x_test)
    metrics = score_regression(y_test, predicted)
    return {"model": name, "parameters": parameters, **metrics}


def print_best(search: GridSearchCV | RandomizedSearchCV, label: str) -> None:
    print(label)
    print("Best parameters:", search.best_params_)
    print("Best CV score:", search.best_score_)


print(profile_data(DATA))

x = DATA[PREDICTORS]
y = DATA[TARGET]
x_train, x_test, y_train, y_test = train_test_split(
    x,
    y,
    test_size=0.25,
    random_state=RANDOM_STATE,
)

candidate_results: list[dict[str, Any]] = []

# -----------------------------
# 1. Baselines
# Every tuned model should beat a simple benchmark and a transparent model.
# -----------------------------
dummy = DummyRegressor(strategy="mean")
candidate_results.append(evaluate_regressor("mean_baseline", dummy, x_train, x_test, y_train, y_test))

linear = make_pipeline(SimpleImputer(strategy="median"), StandardScaler(), LinearRegression())
candidate_results.append(evaluate_regressor("linear_regression", linear, x_train, x_test, y_train, y_test))

cv = KFold(n_splits=5, shuffle=True, random_state=RANDOM_STATE)
linear_cv = cross_validate(
    linear,
    x,
    y,
    cv=cv,
    scoring=["neg_root_mean_squared_error", "r2"],
    return_train_score=True,
)
print("Linear CV:", pd.DataFrame(linear_cv).mean(numeric_only=True))

# -----------------------------
# 2. Stepwise feature selection with AIC
# Use this for interpretable formula search, not as proof of causality.
# -----------------------------
def stepwise_aic(df: pd.DataFrame, target: str, predictors: list[str]) -> dict[str, Any]:
    try:
        import statsmodels.api as sm
    except ImportError as exc:
        raise RuntimeError("Install statsmodels to run stepwise AIC: pip install statsmodels") from exc

    selected: list[str] = []
    remaining = list(predictors)
    best_aic = np.inf
    best_model = None

    while remaining:
        scores = []
        for candidate in remaining:
            terms = selected + [candidate]
            x_design = sm.add_constant(df[terms], has_constant="add")
            fit = sm.OLS(df[target], x_design).fit()
            scores.append((fit.aic, candidate, fit))
        candidate_aic, candidate_name, candidate_fit = min(scores, key=lambda item: item[0])
        if candidate_aic < best_aic - 1e-8:
            selected.append(candidate_name)
            remaining.remove(candidate_name)
            best_aic = candidate_aic
            best_model = candidate_fit
        else:
            break

    return {"selected_features": selected, "aic": best_aic, "model": best_model}


try:
    stepwise = stepwise_aic(DATA, TARGET, PREDICTORS)
    print("Stepwise AIC selected:", stepwise["selected_features"], "AIC:", stepwise["aic"])
except RuntimeError as err:
    print(err)

# -----------------------------
# 3. Decision tree tuning
# Key controls: max_depth, min_samples_leaf, min_samples_split, ccp_alpha.
# -----------------------------
tree_pipe = Pipeline(
    steps=[
        ("impute", SimpleImputer(strategy="median")),
        ("tree", DecisionTreeRegressor(random_state=RANDOM_STATE)),
    ]
)

tree_grid = {
    "tree__max_depth": [2, 3, 4, None],
    "tree__min_samples_leaf": [1, 3, 5],
    "tree__ccp_alpha": [0.0, 0.001, 0.01],
}
tree_search = GridSearchCV(tree_pipe, tree_grid, cv=cv, scoring=METRIC)
tree_search.fit(x_train, y_train)
print_best(tree_search, "Decision tree")
candidate_results.append(
    evaluate_regressor(
        "decision_tree",
        tree_search.best_estimator_,
        x_train,
        x_test,
        y_train,
        y_test,
        json.dumps(tree_search.best_params_),
    )
)

# -----------------------------
# 4. Regularized regression
# Ridge handles collinearity; lasso selects features; elastic net does both.
# -----------------------------
regularized_models = {
    "ridge_cv": make_pipeline(SimpleImputer(strategy="median"), StandardScaler(), RidgeCV(alphas=np.logspace(-3, 3, 25))),
    "lasso_cv": make_pipeline(
        SimpleImputer(strategy="median"),
        StandardScaler(),
        LassoCV(alphas=np.logspace(-3, 1, 25), cv=cv, random_state=RANDOM_STATE, max_iter=20000),
    ),
    "elastic_net_cv": make_pipeline(
        SimpleImputer(strategy="median"),
        StandardScaler(),
        ElasticNetCV(
            l1_ratio=[0.1, 0.5, 0.9, 1.0],
            alphas=np.logspace(-3, 1, 25),
            cv=cv,
            random_state=RANDOM_STATE,
            max_iter=20000,
        ),
    ),
}

for name, model in regularized_models.items():
    candidate_results.append(evaluate_regressor(name, model, x_train, x_test, y_train, y_test))

# -----------------------------
# 5. Random forest and gradient boosting
# Tune enough to learn, then stop before the search becomes the project.
# -----------------------------
rf = RandomForestRegressor(random_state=RANDOM_STATE)
rf_grid = {
    "n_estimators": [300, 600],
    "max_features": ["sqrt", 1.0],
    "min_samples_leaf": [1, 3, 5],
}
rf_search = RandomizedSearchCV(
    rf,
    rf_grid,
    n_iter=6,
    cv=cv,
    scoring=METRIC,
    random_state=RANDOM_STATE,
)
rf_search.fit(x_train, y_train)
print_best(rf_search, "Random forest")
candidate_results.append(
    evaluate_regressor(
        "random_forest",
        rf_search.best_estimator_,
        x_train,
        x_test,
        y_train,
        y_test,
        json.dumps(rf_search.best_params_),
    )
)

hgb = HistGradientBoostingRegressor(random_state=RANDOM_STATE)
hgb_grid = {
    "max_iter": [100, 300],
    "learning_rate": [0.03, 0.1],
    "max_leaf_nodes": [7, 15, 31],
    "l2_regularization": [0.0, 1.0],
}
hgb_search = GridSearchCV(hgb, hgb_grid, cv=cv, scoring=METRIC)
hgb_search.fit(x_train, y_train)
print_best(hgb_search, "Histogram gradient boosting")
candidate_results.append(
    evaluate_regressor(
        "hist_gradient_boosting",
        hgb_search.best_estimator_,
        x_train,
        x_test,
        y_train,
        y_test,
        json.dumps(hgb_search.best_params_),
    )
)

gb = GradientBoostingRegressor(random_state=RANDOM_STATE)
gb_grid = {
    "n_estimators": [100, 300],
    "learning_rate": [0.03, 0.1],
    "max_depth": [2, 3],
    "subsample": [0.8, 1.0],
}
gb_search = GridSearchCV(gb, gb_grid, cv=cv, scoring=METRIC)
gb_search.fit(x_train, y_train)
print_best(gb_search, "Gradient boosting")
candidate_results.append(
    evaluate_regressor(
        "gradient_boosting",
        gb_search.best_estimator_,
        x_train,
        x_test,
        y_train,
        y_test,
        json.dumps(gb_search.best_params_),
    )
)

# -----------------------------
# 6. XGBoost tuning with early stopping
# Install first: pip install xgboost
# -----------------------------
try:
    from xgboost import XGBRegressor

    xgb = XGBRegressor(
        objective="reg:squarederror",
        eval_metric="rmse",
        random_state=RANDOM_STATE,
        n_estimators=1000,
    )
    xgb_grid = {
        "learning_rate": [0.03, 0.1],
        "max_depth": [2, 3, 5],
        "min_child_weight": [1, 5],
        "subsample": [0.8, 1.0],
        "colsample_bytree": [0.8, 1.0],
        "reg_lambda": [1, 5],
    }
    xgb_search = RandomizedSearchCV(
        xgb,
        xgb_grid,
        n_iter=8,
        cv=cv,
        scoring=METRIC,
        random_state=RANDOM_STATE,
    )
    xgb_search.fit(x_train, y_train)
    print_best(xgb_search, "XGBoost")
    xgb_fit_x, xgb_valid_x, xgb_fit_y, xgb_valid_y = train_test_split(
        x_train,
        y_train,
        test_size=0.25,
        random_state=RANDOM_STATE,
    )
    xgb_final = XGBRegressor(
        objective="reg:squarederror",
        eval_metric="rmse",
        random_state=RANDOM_STATE,
        n_estimators=1000,
        **xgb_search.best_params_,
    )
    try:
        xgb_final.fit(
            xgb_fit_x,
            xgb_fit_y,
            eval_set=[(xgb_valid_x, xgb_valid_y)],
            early_stopping_rounds=25,
            verbose=False,
        )
    except TypeError:
        xgb_final.fit(xgb_fit_x, xgb_fit_y, eval_set=[(xgb_valid_x, xgb_valid_y)], verbose=False)
    xgb_predicted = xgb_final.predict(x_test)
    candidate_results.append(
        {
            "model": "xgboost",
            "parameters": json.dumps(xgb_search.best_params_),
            **score_regression(y_test, xgb_predicted),
        }
    )
except ImportError:
    print("Install xgboost to run XGBoost tuning: pip install xgboost")

# -----------------------------
# 7. Target transformation
# Use when the target is positive and skewed.
# -----------------------------
log_target_model = TransformedTargetRegressor(
    regressor=make_pipeline(SimpleImputer(strategy="median"), StandardScaler(), RidgeCV(alphas=np.logspace(-3, 3, 25))),
    func=np.log1p,
    inverse_func=np.expm1,
)
candidate_results.append(evaluate_regressor("log_target_ridge", log_target_model, x_train, x_test, y_train, y_test))

# -----------------------------
# 8. Stacking
# Use out-of-fold base predictions so the meta-model does not leak.
# -----------------------------
stack = StackingRegressor(
    estimators=[
        ("ridge", regularized_models["ridge_cv"]),
        ("tree", tree_search.best_estimator_),
        ("rf", rf_search.best_estimator_),
    ],
    final_estimator=RidgeCV(alphas=np.logspace(-3, 3, 25)),
    cv=cv,
)
candidate_results.append(evaluate_regressor("stacking", stack, x_train, x_test, y_train, y_test))

# -----------------------------
# 9. Classification tuning, threshold tuning, and calibration
# Swap CLASS_TARGET for your binary target.
# -----------------------------
class_x = DATA[["mpg", "wt", "hp", "disp"]]
class_y = DATA[CLASS_TARGET].astype(int)
class_x_train, class_x_test, class_y_train, class_y_test = train_test_split(
    class_x,
    class_y,
    test_size=0.25,
    random_state=RANDOM_STATE,
    stratify=class_y,
)

dummy_classifier = DummyClassifier(strategy="most_frequent")
dummy_classifier.fit(class_x_train, class_y_train)
print("Dummy classifier accuracy:", accuracy_score(class_y_test, dummy_classifier.predict(class_x_test)))

logit = make_pipeline(
    SimpleImputer(strategy="median"),
    StandardScaler(),
    LogisticRegressionCV(
        Cs=np.logspace(-3, 3, 10),
        cv=5,
        class_weight="balanced",
        max_iter=5000,
        scoring="roc_auc",
    ),
)
logit.fit(class_x_train, class_y_train)
class_prob = logit.predict_proba(class_x_test)[:, 1]
precision, recall, thresholds = precision_recall_curve(class_y_test, class_prob)
threshold_table = pd.DataFrame(
    {
        "threshold": np.r_[thresholds, 1.0],
        "precision": precision,
        "recall": recall,
    }
)
threshold_table["f1"] = 2 * threshold_table["precision"] * threshold_table["recall"] / (
    threshold_table["precision"] + threshold_table["recall"]
).replace(0, np.nan)
print("Logistic ROC AUC:", roc_auc_score(class_y_test, class_prob))
print("Logistic Brier score:", brier_score_loss(class_y_test, class_prob))
print("Best threshold by F1:", threshold_table.sort_values("f1", ascending=False).head(1))

# -----------------------------
# 10. Time and group validation patterns
# Use these instead of random CV when the data structure requires it.
# -----------------------------
time_cv = TimeSeriesSplit(n_splits=3)
print("Time CV split sizes:", [(len(train_id), len(test_id)) for train_id, test_id in time_cv.split(x)])

GROUP = "cyl"
group_cv = GroupKFold(n_splits=3)
print(
    "Group CV split sizes:",
    [(len(train_id), len(test_id)) for train_id, test_id in group_cv.split(x, y, groups=DATA[GROUP])],
)

# -----------------------------
# 11. Model card skeleton
# Save this with each project.
# -----------------------------
results = pd.DataFrame(candidate_results).sort_values("rmse")
print(results)

model_card = {
    "target": TARGET,
    "grain": "One row per car in mtcars. Replace with your project grain.",
    "predictors": PREDICTORS,
    "validation": "Holdout split plus 5-fold CV. Use time or group CV when needed.",
    "metric": "RMSE, MAE, R-squared",
    "selected_model": results.iloc[0]["model"],
    "candidate_results": results.to_dict(orient="records"),
    "statistical_checks": [
        "missingness",
        "leakage",
        "collinearity",
        "heteroskedasticity risk",
        "overfit gap",
        "calibration for probabilities",
        "group or time dependence",
    ],
    "known_limits": [
        "Small teaching dataset.",
        "Predictive validation is not a causal identification strategy.",
        "Retune after changing the target, grain, predictors, or deployment population.",
    ],
}

print(json.dumps(model_card, indent=2))
