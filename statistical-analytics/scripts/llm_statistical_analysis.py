#!/usr/bin/env python3
"""Statistical analysis templates for LLM outputs.

This file assumes LLM outputs and evaluations already exist. It treats LLM
quality as measurable data: randomized prompt comparisons, factuality rates,
rubric scores, evaluator agreement, calibration, cost, latency, and drift.
"""

from __future__ import annotations


def optional_import(name: str):
    try:
        return __import__(name)
    except Exception:
        return None


pd = optional_import("pandas")
np = optional_import("numpy")


def require(module, package_name: str):
    if module is None:
        raise RuntimeError(f"Install {package_name} to run this recipe.")
    return module


def prompt_score_model(df):
    smf = require(optional_import("statsmodels.formula.api"), "statsmodels")
    return smf.ols("score ~ C(prompt_id) + input_tokens + output_tokens", data=df).fit()


def factuality_model(df):
    smf = require(optional_import("statsmodels.formula.api"), "statsmodels")
    return smf.logit("factual ~ C(prompt_id) + confidence + input_tokens + output_tokens", data=df).fit()


def brier_score(correct, probability):
    np_mod = require(np, "numpy")
    correct = np_mod.asarray(correct, dtype=float)
    probability = np_mod.asarray(probability, dtype=float)
    return np_mod.mean((correct - probability) ** 2)


def calibration_table(df, bins=5):
    pd_mod = require(pd, "pandas")
    out = df.copy()
    out["confidence_bin"] = pd_mod.qcut(out["confidence"], q=bins, duplicates="drop")
    return out.groupby("confidence_bin", observed=True).agg(
        mean_confidence=("confidence", "mean"),
        observed_accuracy=("factual", "mean"),
        n=("factual", "size"),
    )


def evaluator_agreement(labels_a, labels_b):
    sklearn_metrics = require(optional_import("sklearn.metrics"), "scikit-learn")
    return sklearn_metrics.cohen_kappa_score(labels_a, labels_b)


def cost_quality_frontier(df):
    return df.groupby(["prompt_id", "model_id"], as_index=False).agg(
        mean_score=("score", "mean"),
        factuality_rate=("factual", "mean"),
        mean_latency_ms=("latency_ms", "mean"),
        mean_cost_usd=("cost_usd", "mean"),
    )


def embedding_clusters(embedding_matrix, n_clusters=5):
    require(optional_import("sklearn"), "scikit-learn")
    from sklearn.cluster import KMeans
    from sklearn.preprocessing import StandardScaler

    X = StandardScaler().fit_transform(embedding_matrix)
    return KMeans(n_clusters=n_clusters, n_init="auto", random_state=123).fit(X)


def drift_table(df):
    out = df.copy()
    out["eval_date"] = pd.to_datetime(out["evaluated_at"]).dt.date
    return out.groupby(["eval_date", "prompt_id", "model_version"], as_index=False).agg(
        mean_score=("score", "mean"),
        factuality_rate=("factual", "mean"),
        mean_confidence=("confidence", "mean"),
        mean_latency_ms=("latency_ms", "mean"),
        mean_cost_usd=("cost_usd", "mean"),
    )


if __name__ == "__main__":
    print("Import this file after creating an LLM evaluation table with prompt_id, item_id, score, factual, and confidence.")
