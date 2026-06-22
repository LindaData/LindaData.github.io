#!/usr/bin/env python3
"""Linda Data statistical methods cookbook for Python.

This is a broad template library for the techniques listed in
data/statistical_techniques_catalog.csv. It uses common scientific Python
packages where available and keeps each recipe small enough to copy into a
notebook or production analysis.
"""

from __future__ import annotations

import math
from dataclasses import dataclass


def optional_import(name: str):
    try:
        return __import__(name)
    except Exception:
        return None


np = optional_import("numpy")
pd = optional_import("pandas")
scipy = optional_import("scipy")
statsmodels = optional_import("statsmodels")
sklearn = optional_import("sklearn")


def require(module, package_name: str):
    if module is None:
        raise RuntimeError(f"Install {package_name} to run this recipe.")
    return module


def profile_data(df):
    pd_mod = require(pd, "pandas")
    return pd_mod.DataFrame(
        {
            "variable": df.columns,
            "dtype": [str(df[col].dtype) for col in df.columns],
            "rows": len(df),
            "missing": [df[col].isna().sum() for col in df.columns],
            "missing_rate": [df[col].isna().mean() for col in df.columns],
            "unique_values": [df[col].nunique(dropna=False) for col in df.columns],
        }
    )


def describe_numeric(df):
    return df.select_dtypes("number").describe().T


def frequency_table(df, column):
    return df[column].value_counts(dropna=False).rename_axis(column).reset_index(name="n")


def pearson_corr(df, columns):
    return df[columns].corr(method="pearson")


def spearman_corr(df, columns):
    return df[columns].corr(method="spearman")


def t_tests(df, outcome, group):
    scipy_stats = require(optional_import("scipy.stats"), "scipy")
    groups = [x.dropna().to_numpy() for _, x in df.groupby(group)[outcome]]
    if len(groups) != 2:
        raise ValueError("Two-sample t-test requires exactly two groups.")
    return scipy_stats.ttest_ind(groups[0], groups[1], equal_var=False)


def chi_square(df, row, col):
    scipy_stats = require(optional_import("scipy.stats"), "scipy")
    table = pd.crosstab(df[row], df[col])
    return scipy_stats.chi2_contingency(table)


def bootstrap_ci(values, statistic=None, n_boot=2000, alpha=0.05, seed=123):
    np_mod = require(np, "numpy")
    statistic = statistic or np_mod.mean
    rng = np_mod.random.default_rng(seed)
    values = np_mod.asarray(values)
    draws = [statistic(rng.choice(values, size=len(values), replace=True)) for _ in range(n_boot)]
    return np_mod.quantile(draws, [alpha / 2, 1 - alpha / 2])


def ols_regression(df, formula):
    smf = require(optional_import("statsmodels.formula.api"), "statsmodels")
    return smf.ols(formula, data=df).fit()


def logistic_regression(df, formula):
    smf = require(optional_import("statsmodels.formula.api"), "statsmodels")
    return smf.logit(formula, data=df).fit()


def poisson_regression(df, formula):
    smf = require(optional_import("statsmodels.formula.api"), "statsmodels")
    return smf.poisson(formula, data=df).fit()


def negative_binomial_regression(df, formula):
    smf = require(optional_import("statsmodels.formula.api"), "statsmodels")
    return smf.negativebinomial(formula, data=df).fit()


def quantile_regression(df, formula, q=0.5):
    smf = require(optional_import("statsmodels.formula.api"), "statsmodels")
    return smf.quantreg(formula, data=df).fit(q=q)


def regularized_models(X, y):
    require(sklearn, "scikit-learn")
    from sklearn.linear_model import ElasticNetCV, LassoCV, RidgeCV
    from sklearn.preprocessing import StandardScaler
    from sklearn.pipeline import make_pipeline

    return {
        "ridge": make_pipeline(StandardScaler(), RidgeCV()).fit(X, y),
        "lasso": make_pipeline(StandardScaler(), LassoCV()).fit(X, y),
        "elastic_net": make_pipeline(StandardScaler(), ElasticNetCV()).fit(X, y),
    }


def mixed_effects(df, formula, group):
    smf = require(optional_import("statsmodels.formula.api"), "statsmodels")
    return smf.mixedlm(formula, data=df, groups=df[group]).fit()


def time_series_sarimax(series, order=(1, 1, 1), seasonal_order=(0, 0, 0, 0)):
    require(statsmodels, "statsmodels")
    from statsmodels.tsa.statespace.sarimax import SARIMAX

    return SARIMAX(series, order=order, seasonal_order=seasonal_order).fit(disp=False)


def pca_features(X, n_components=2):
    require(sklearn, "scikit-learn")
    from sklearn.decomposition import PCA
    from sklearn.preprocessing import StandardScaler

    return PCA(n_components=n_components).fit_transform(StandardScaler().fit_transform(X))


def kmeans_clusters(X, n_clusters=3):
    require(sklearn, "scikit-learn")
    from sklearn.cluster import KMeans
    from sklearn.preprocessing import StandardScaler

    return KMeans(n_clusters=n_clusters, n_init="auto", random_state=123).fit(StandardScaler().fit_transform(X))


def cohen_kappa(rater_a, rater_b):
    require(sklearn, "scikit-learn")
    from sklearn.metrics import cohen_kappa_score

    return cohen_kappa_score(rater_a, rater_b)


def cronbach_alpha(items_df):
    np_mod = require(np, "numpy")
    scores = items_df.to_numpy(dtype=float)
    item_vars = scores.var(axis=0, ddof=1)
    total_var = scores.sum(axis=1).var(ddof=1)
    k = scores.shape[1]
    return k / (k - 1) * (1 - item_vars.sum() / total_var)


def llm_prompt_ab_test(df, metric="score"):
    """Compare baseline and candidate prompts on the same statistical footing."""
    return ols_regression(df, f"{metric} ~ C(prompt_id)")


def llm_factuality_model(df):
    return logistic_regression(df, "factual ~ C(prompt_id) + confidence")


def brier_score(correct, probability):
    np_mod = require(np, "numpy")
    correct = np_mod.asarray(correct, dtype=float)
    probability = np_mod.asarray(probability, dtype=float)
    return np_mod.mean((correct - probability) ** 2)


def calibration_table(df, confidence="confidence", correct="factual", bins=5):
    pd_mod = require(pd, "pandas")
    out = df.copy()
    out["confidence_bin"] = pd_mod.qcut(out[confidence], q=bins, duplicates="drop")
    return out.groupby("confidence_bin", observed=True).agg(
        mean_confidence=(confidence, "mean"),
        observed_accuracy=(correct, "mean"),
        n=(correct, "size"),
    )


@dataclass
class LLMRecord:
    item_id: str
    prompt_id: str
    model_id: str
    output_text: str
    score: float
    factual: int
    confidence: float


if __name__ == "__main__":
    print("Import this file into a notebook or script and call the recipe functions for your dataset.")
