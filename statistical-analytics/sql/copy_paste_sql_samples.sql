-- Linda Data copy-paste SQL samples.
-- Replace table names and columns: DATA_TABLE, TARGET, PREDICTOR, GROUP_COL,
-- ID_COL, TIME_COL, EVENT_COL, PROMPT_ID, SCORE, FACTUAL.

-- -----------------------------
-- 0. Universal setup in DuckDB
-- -----------------------------
CREATE OR REPLACE VIEW data_table AS
SELECT *
FROM read_csv_auto('statistical-analytics/data/r-builtins/mtcars.csv');

-- -----------------------------
-- 1. Profile a dataset
-- -----------------------------
SELECT
  COUNT(*) AS rows,
  COUNT(*) - COUNT(mpg) AS missing_target,
  AVG(mpg) AS mean_target,
  STDDEV_SAMP(mpg) AS sd_target,
  MIN(mpg) AS min_target,
  MEDIAN(mpg) AS median_target,
  MAX(mpg) AS max_target
FROM data_table;

-- -----------------------------
-- 2. Frequency table and cross-tab
-- -----------------------------
SELECT cyl, COUNT(*) AS n
FROM data_table
GROUP BY cyl
ORDER BY cyl;

SELECT cyl, am, COUNT(*) AS n
FROM data_table
GROUP BY cyl, am
ORDER BY cyl, am;

-- -----------------------------
-- 3. Correlation and simple regression aggregates
-- -----------------------------
SELECT
  corr(mpg, wt) AS corr_target_predictor,
  regr_slope(mpg, wt) AS simple_slope,
  regr_intercept(mpg, wt) AS simple_intercept,
  regr_r2(mpg, wt) AS simple_r2
FROM data_table;

-- -----------------------------
-- 4. Regression-ready feature table
-- -----------------------------
CREATE OR REPLACE VIEW model_features AS
SELECT
  mpg AS target,
  wt,
  hp,
  disp,
  wt * hp AS wt_hp_interaction,
  wt * wt AS wt_squared,
  CASE WHEN am = 1 THEN 1 ELSE 0 END AS is_manual,
  CASE WHEN row_number() OVER (ORDER BY mpg, wt, hp) % 5 = 0 THEN 'test' ELSE 'train' END AS split
FROM data_table
WHERE mpg IS NOT NULL
  AND wt IS NOT NULL
  AND hp IS NOT NULL
  AND disp IS NOT NULL;

SELECT split, COUNT(*) AS rows, AVG(target) AS mean_target
FROM model_features
GROUP BY split;

-- -----------------------------
-- 5. A/B test summary table
-- -----------------------------
CREATE OR REPLACE VIEW experiment AS
SELECT 'baseline' AS variant, 0 AS converted UNION ALL
SELECT 'baseline', 1 UNION ALL
SELECT 'candidate', 1 UNION ALL
SELECT 'candidate', 1;

SELECT
  variant,
  COUNT(*) AS n,
  SUM(converted) AS conversions,
  AVG(converted) AS conversion_rate
FROM experiment
GROUP BY variant;

-- -----------------------------
-- 6. Time-series lag features
-- -----------------------------
CREATE OR REPLACE VIEW time_features AS
SELECT
  *,
  lag(target) OVER (ORDER BY target, wt, hp) AS lag_target,
  avg(target) OVER (ORDER BY target, wt, hp ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING) AS rolling_avg_target
FROM model_features;

-- -----------------------------
-- 7. LLM evaluation schema and summaries
-- -----------------------------
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

SELECT
  prompt_id,
  model_id,
  COUNT(*) AS outputs_evaluated,
  AVG(score) AS mean_score,
  AVG(factual) AS factuality_rate,
  AVG(confidence) AS mean_confidence,
  AVG(input_tokens + output_tokens) AS mean_total_tokens,
  AVG(latency_ms) AS mean_latency_ms,
  AVG(cost_usd) AS mean_cost_usd
FROM llm_evaluations
GROUP BY prompt_id, model_id;

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
