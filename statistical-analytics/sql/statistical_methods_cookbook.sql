-- Linda Data statistical methods cookbook for SQL.
-- SQL is strongest for profiling, feature construction, experiment summaries,
-- metric tables, and simple aggregate statistics. Advanced models should use
-- the SQL feature tables as inputs to R or Python.

-- Example base table from the R built-in export.
CREATE OR REPLACE VIEW mtcars AS
SELECT *
FROM read_csv_auto('statistical-analytics/data/r-builtins/mtcars.csv');

-- Data profiling: counts, missingness, and numeric summaries.
SELECT
  COUNT(*) AS rows,
  COUNT(*) - COUNT(mpg) AS missing_mpg,
  AVG(mpg) AS mean_mpg,
  STDDEV_SAMP(mpg) AS sd_mpg,
  MIN(mpg) AS min_mpg,
  QUANTILE_CONT(mpg, 0.25) AS q25_mpg,
  MEDIAN(mpg) AS median_mpg,
  QUANTILE_CONT(mpg, 0.75) AS q75_mpg,
  MAX(mpg) AS max_mpg
FROM mtcars;

-- Frequency table and cross-tabulation source.
SELECT cyl, COUNT(*) AS n
FROM mtcars
GROUP BY cyl
ORDER BY cyl;

SELECT cyl, am, COUNT(*) AS n
FROM mtcars
GROUP BY cyl, am
ORDER BY cyl, am;

-- Correlation screening.
SELECT
  corr(mpg, wt) AS pearson_mpg_wt,
  corr(mpg, hp) AS pearson_mpg_hp,
  corr(wt, disp) AS pearson_wt_disp
FROM mtcars;

-- SQL ingredients for a two-sample t-test.
SELECT
  am,
  COUNT(*) AS n,
  AVG(mpg) AS mean_mpg,
  VAR_SAMP(mpg) AS var_mpg
FROM mtcars
GROUP BY am;

-- SQL ingredients for an A/B conversion test.
-- Replace this CTE with a real experiment table.
WITH experiment AS (
  SELECT 'baseline' AS variant, 0 AS converted UNION ALL
  SELECT 'baseline', 1 UNION ALL
  SELECT 'candidate', 1 UNION ALL
  SELECT 'candidate', 1
)
SELECT
  variant,
  COUNT(*) AS n,
  SUM(converted) AS conversions,
  AVG(converted) AS conversion_rate
FROM experiment
GROUP BY variant;

-- Bootstrap/permutation workflows are usually driven from R/Python, but SQL can
-- create deterministic folds or random assignment tables.
CREATE OR REPLACE VIEW mtcars_folds AS
SELECT
  *,
  CASE WHEN row_number() OVER (ORDER BY mpg, wt, hp) % 5 = 0 THEN 'test' ELSE 'train' END AS split
FROM mtcars;

-- Regression-ready feature table.
CREATE OR REPLACE VIEW mtcars_features AS
SELECT
  mpg,
  wt,
  hp,
  disp,
  cyl,
  wt * hp AS wt_hp_interaction,
  wt * wt AS wt_squared,
  CASE WHEN am = 1 THEN 1 ELSE 0 END AS is_manual,
  split
FROM mtcars_folds
WHERE mpg IS NOT NULL
  AND wt IS NOT NULL
  AND hp IS NOT NULL
  AND disp IS NOT NULL;

-- Simple linear regression aggregate functions available in DuckDB.
SELECT
  regr_slope(mpg, wt) AS slope_wt,
  regr_intercept(mpg, wt) AS intercept_wt,
  regr_r2(mpg, wt) AS r2_wt
FROM mtcars_features
WHERE split = 'train';

-- Panel/time-series feature pattern.
CREATE OR REPLACE VIEW example_time_features AS
SELECT
  *,
  lag(mpg) OVER (ORDER BY mpg, wt, hp) AS lag_mpg,
  avg(mpg) OVER (ORDER BY mpg, wt, hp ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING) AS rolling_avg_mpg
FROM mtcars_features;

-- LLM analysis schema. Store one row per evaluated output.
CREATE OR REPLACE TABLE llm_evaluations (
  item_id VARCHAR,
  prompt_id VARCHAR,
  model_id VARCHAR,
  model_version VARCHAR,
  output_id VARCHAR,
  evaluator_id VARCHAR,
  score DOUBLE,
  factual INTEGER,
  confidence DOUBLE,
  input_tokens INTEGER,
  output_tokens INTEGER,
  latency_ms DOUBLE,
  cost_usd DOUBLE,
  evaluated_at TIMESTAMP
);

-- LLM prompt A/B metrics.
SELECT
  prompt_id,
  COUNT(*) AS outputs_evaluated,
  AVG(score) AS mean_score,
  AVG(factual) AS factuality_rate,
  AVG(confidence) AS mean_confidence,
  AVG(input_tokens + output_tokens) AS mean_total_tokens,
  AVG(latency_ms) AS mean_latency_ms,
  AVG(cost_usd) AS mean_cost_usd
FROM llm_evaluations
GROUP BY prompt_id;

-- LLM calibration bins.
SELECT
  prompt_id,
  CASE
    WHEN confidence < 0.1 THEN 1
    WHEN confidence < 0.2 THEN 2
    WHEN confidence < 0.3 THEN 3
    WHEN confidence < 0.4 THEN 4
    WHEN confidence < 0.5 THEN 5
    WHEN confidence < 0.6 THEN 6
    WHEN confidence < 0.7 THEN 7
    WHEN confidence < 0.8 THEN 8
    WHEN confidence < 0.9 THEN 9
    ELSE 10
  END AS confidence_bin,
  COUNT(*) AS n,
  AVG(confidence) AS mean_confidence,
  AVG(factual) AS observed_accuracy,
  AVG((factual - confidence) * (factual - confidence)) AS brier_component
FROM llm_evaluations
GROUP BY prompt_id, confidence_bin
ORDER BY prompt_id, confidence_bin;

-- LLM evaluator agreement input table. Export this to R/Python for kappa/ICC.
CREATE OR REPLACE VIEW llm_rater_pairs AS
SELECT
  a.item_id,
  a.output_id,
  a.evaluator_id AS evaluator_a,
  b.evaluator_id AS evaluator_b,
  a.score AS score_a,
  b.score AS score_b,
  a.factual AS factual_a,
  b.factual AS factual_b
FROM llm_evaluations a
JOIN llm_evaluations b
  ON a.item_id = b.item_id
 AND a.output_id = b.output_id
 AND a.evaluator_id < b.evaluator_id;
