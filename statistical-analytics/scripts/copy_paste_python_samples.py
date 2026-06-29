#!/usr/bin/env python3
"""Linda Data copy-paste Python samples.

Replace DATA, TARGET, PREDICTORS, GROUP, ID, TIME, EVENT, and COUNT columns.
Common packages: pandas, numpy, scipy, statsmodels, scikit-learn.
"""

from __future__ import annotations

import pandas as pd
import numpy as np


# -----------------------------
# 0. Universal setup
# -----------------------------
DATA_PATH = "statistical-analytics/data/r-builtins/mtcars.csv"
DATA = pd.read_csv(DATA_PATH)
TARGET = "mpg"
PREDICTORS = ["wt", "hp", "disp"]
GROUP = "am"


def profile_data(df: pd.DataFrame) -> pd.DataFrame:
    return pd.DataFrame(
        {
            "variable": df.columns,
            "dtype": [str(df[col].dtype) for col in df.columns],
            "rows": len(df),
            "missing": [df[col].isna().sum() for col in df.columns],
            "missing_rate": [df[col].isna().mean() for col in df.columns],
            "unique_values": [df[col].nunique(dropna=False) for col in df.columns],
        }
    )


print(profile_data(DATA))
print(DATA.describe(include="all"))

# -----------------------------
# 1. Continuous target: OLS
# -----------------------------
import statsmodels.formula.api as smf

formula = f"{TARGET} ~ " + " + ".join(PREDICTORS)
ols_fit = smf.ols(formula, data=DATA).fit()
print(ols_fit.summary())

# -----------------------------
# 2. Binary target: logistic regression
# -----------------------------
DATA_LOGIT = DATA.copy()
DATA_LOGIT["target_binary"] = DATA_LOGIT["am"]
logit_fit = smf.logit("target_binary ~ mpg + wt + hp", data=DATA_LOGIT).fit()
print(logit_fit.summary())
DATA_LOGIT["predicted_probability"] = logit_fit.predict(DATA_LOGIT)

# -----------------------------
# 3. Count target: Poisson regression
# -----------------------------
COUNT_DATA = pd.read_csv("statistical-analytics/data/r-builtins/warpbreaks.csv")
poisson_fit = smf.poisson("breaks ~ C(wool) + C(tension)", data=COUNT_DATA).fit()
print(poisson_fit.summary())

# -----------------------------
# 4. Group comparisons
# -----------------------------
from scipy import stats

group_values = [x[TARGET].dropna().to_numpy() for _, x in DATA.groupby(GROUP)]
print(stats.ttest_ind(group_values[0], group_values[1], equal_var=False))
print(pd.crosstab(DATA["cyl"], DATA["am"]))

# -----------------------------
# 5. Train/test split and model validation
# -----------------------------
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.pipeline import make_pipeline
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import LinearRegression, LogisticRegression

X = DATA[PREDICTORS]
y = DATA[TARGET]
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.25, random_state=123)
model = make_pipeline(StandardScaler(), LinearRegression())
model.fit(X_train, y_train)
print("Test R2:", model.score(X_test, y_test))
print("CV R2:", cross_val_score(model, X, y, cv=5).mean())

# -----------------------------
# 6. PCA and clustering
# -----------------------------
from sklearn.decomposition import PCA
from sklearn.cluster import KMeans

FEATURE_DATA = pd.read_csv("statistical-analytics/data/r-builtins/USArrests.csv")
X_features = FEATURE_DATA[["Murder", "Assault", "UrbanPop", "Rape"]]
pca = make_pipeline(StandardScaler(), PCA(n_components=2))
components = pca.fit_transform(X_features)
clusters = KMeans(n_clusters=3, n_init="auto", random_state=123).fit_predict(X_features)
print(components[:5])
print(clusters[:5])

# -----------------------------
# 7. Time series starter
# -----------------------------
from statsmodels.tsa.statespace.sarimax import SARIMAX

SERIES_DATA = pd.read_csv("statistical-analytics/data/r-builtins/AirPassengers.csv")
series = SERIES_DATA["AirPassengers"]
sarimax_fit = SARIMAX(series, order=(1, 1, 1), seasonal_order=(1, 1, 1, 12)).fit(disp=False)
print(sarimax_fit.summary())

# -----------------------------
# 8. LLM evaluation as statistics
# -----------------------------
LLM_DATA = pd.DataFrame(
    {
        "item_id": np.repeat(np.arange(1, 21), 2),
        "prompt_id": ["baseline", "candidate"] * 20,
        "score": [3, 4] * 10 + [4, 5] * 10,
        "factual": ((np.repeat(np.arange(1, 21), 2) + [0, 1] * 20) % 5 != 0).astype(int),
        "confidence": np.linspace(0.55, 0.94, 40),
    }
)

print(smf.ols("score ~ C(prompt_id)", data=LLM_DATA).fit().summary())
print(smf.logit("factual ~ C(prompt_id) + confidence", data=LLM_DATA).fit().summary())
LLM_DATA["confidence_bin"] = pd.qcut(LLM_DATA["confidence"], q=5)
print(
    LLM_DATA.groupby("confidence_bin", observed=True)
    .agg(mean_confidence=("confidence", "mean"), observed_accuracy=("factual", "mean"), n=("factual", "size"))
)
print("Brier score:", np.mean((LLM_DATA["factual"] - LLM_DATA["confidence"]) ** 2))
