-- Linda Data model tuning SQL templates.
-- SQL usually prepares data, validation splits, metrics, and audit tables.
-- Fit the model in R, Python, or a database ML extension, then write results back here.
-- Replace DATA_TABLE, TARGET, PREDICTOR, GROUP_COL, ID_COL, TIME_COL, and MODEL_ID.

-- -----------------------------
-- 0. Universal setup in DuckDB
-- -----------------------------
CREATE OR REPLACE VIEW data_table AS
SELECT *
FROM read_csv_auto('statistical-analytics/data/r-builtins/mtcars.csv');

-- -----------------------------
-- 1. Profile the target before modeling
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
-- 2. Create a clean modeling table
-- One row should mean one unit of analysis.
-- -----------------------------
CREATE OR REPLACE VIEW model_features AS
SELECT
  row_number() OVER (ORDER BY mpg, wt, hp, disp) AS row_id,
  mpg AS target,
  wt,
  hp,
  disp,
  qsec,
  am,
  wt * hp AS wt_hp_interaction,
  wt * wt AS wt_squared,
  CASE WHEN am = 1 THEN 1 ELSE 0 END AS is_manual
FROM data_table
WHERE mpg IS NOT NULL
  AND wt IS NOT NULL
  AND hp IS NOT NULL
  AND disp IS NOT NULL
  AND qsec IS NOT NULL;

-- -----------------------------
-- 3. Assign reproducible splits and folds
-- Swap random splits for time or group splits when the design requires it.
-- -----------------------------
CREATE OR REPLACE VIEW model_splits AS
SELECT
  *,
  CASE WHEN row_id % 5 = 0 THEN 'test' ELSE 'train' END AS split,
  1 + (row_id % 5) AS fold_id
FROM model_features;

SELECT split, COUNT(*) AS rows, AVG(target) AS mean_target
FROM model_splits
GROUP BY split
ORDER BY split;

SELECT fold_id, COUNT(*) AS rows, AVG(target) AS mean_target
FROM model_splits
GROUP BY fold_id
ORDER BY fold_id;

-- -----------------------------
-- 4. Collinearity screening
-- Use this before fitting linear, GLM, and regularized baselines.
-- -----------------------------
SELECT
  corr(target, wt) AS corr_target_wt,
  corr(target, hp) AS corr_target_hp,
  corr(target, disp) AS corr_target_disp,
  corr(wt, hp) AS corr_wt_hp,
  corr(wt, disp) AS corr_wt_disp,
  corr(hp, disp) AS corr_hp_disp
FROM model_splits;

-- -----------------------------
-- 5. Modeling export table
-- R and Python can read this view directly from DuckDB or from a CSV export.
-- -----------------------------
CREATE OR REPLACE VIEW model_training_export AS
SELECT
  row_id,
  split,
  fold_id,
  target,
  wt,
  hp,
  disp,
  qsec,
  am,
  wt_hp_interaction,
  wt_squared,
  is_manual
FROM model_splits;

-- Example DuckDB export:
-- COPY model_training_export TO 'model_training_export.csv' (HEADER, DELIMITER ',');

-- -----------------------------
-- 6. Tuning grids to keep searches reproducible
-- R/Python can read these grids and write the results back.
-- -----------------------------
CREATE OR REPLACE TABLE decision_tree_grid AS
SELECT *
FROM (
  VALUES
    (2, 1, 0.000),
    (3, 1, 0.000),
    (4, 3, 0.001),
    (6, 5, 0.010)
) AS t(max_depth, min_samples_leaf, ccp_alpha);

CREATE OR REPLACE TABLE xgboost_grid AS
SELECT *
FROM (
  VALUES
    (0.03, 2, 1, 0.80, 0.80, 1.0),
    (0.03, 3, 5, 0.80, 1.00, 1.0),
    (0.10, 3, 1, 1.00, 0.80, 5.0),
    (0.10, 5, 5, 0.80, 0.80, 5.0)
) AS t(eta, max_depth, min_child_weight, subsample, colsample_bytree, reg_lambda);

CREATE OR REPLACE TABLE regularization_grid AS
SELECT *
FROM (
  VALUES
    ('ridge', 0.0, 0.001),
    ('ridge', 0.0, 0.100),
    ('lasso', 1.0, 0.001),
    ('lasso', 1.0, 0.100),
    ('elastic_net', 0.5, 0.001),
    ('elastic_net', 0.5, 0.100)
) AS t(method, alpha, lambda);

-- -----------------------------
-- 7. Tuning results table
-- Insert one row per model candidate, fold, and metric.
-- -----------------------------
CREATE OR REPLACE TABLE model_tuning_results (
  run_id VARCHAR,
  model_family VARCHAR,
  model_id VARCHAR,
  parameter_json VARCHAR,
  split VARCHAR,
  fold_id INTEGER,
  metric_name VARCHAR,
  metric_value DOUBLE,
  trained_at TIMESTAMP,
  notes VARCHAR
);

-- Example rows after running R or Python:
INSERT INTO model_tuning_results VALUES
  ('run_001', 'baseline', 'linear_regression', '{"terms":"wt+hp+disp+qsec+am"}', 'test', NULL, 'rmse', 3.10, current_timestamp, 'Replace with actual result'),
  ('run_001', 'tree', 'decision_tree', '{"max_depth":3,"min_samples_leaf":3}', 'test', NULL, 'rmse', 3.40, current_timestamp, 'Replace with actual result'),
  ('run_001', 'boosting', 'xgboost', '{"eta":0.03,"max_depth":3,"subsample":0.8}', 'test', NULL, 'rmse', 2.90, current_timestamp, 'Replace with actual result');

SELECT *
FROM model_tuning_results
ORDER BY metric_name, metric_value;

SELECT
  model_family,
  model_id,
  parameter_json,
  AVG(metric_value) AS mean_metric
FROM model_tuning_results
WHERE metric_name = 'rmse'
GROUP BY model_family, model_id, parameter_json
ORDER BY mean_metric;

-- -----------------------------
-- 8. Classification threshold table
-- Load scored probabilities from R/Python, then choose a cutoff by cost or metric.
-- -----------------------------
CREATE OR REPLACE TABLE scored_classification (
  row_id INTEGER,
  actual INTEGER,
  predicted_probability DOUBLE,
  split VARCHAR
);

-- INSERT INTO scored_classification VALUES
--   (1, 1, 0.82, 'test'),
--   (2, 0, 0.35, 'test');

WITH threshold_grid AS (
  SELECT threshold / 100.0 AS threshold
  FROM range(5, 96, 5) AS t(threshold)
),
scored AS (
  SELECT
    g.threshold,
    s.actual,
    CASE WHEN s.predicted_probability >= g.threshold THEN 1 ELSE 0 END AS predicted
  FROM threshold_grid g
  CROSS JOIN scored_classification s
  WHERE s.split = 'test'
)
SELECT
  threshold,
  SUM(CASE WHEN predicted = 1 AND actual = 1 THEN 1 ELSE 0 END) AS true_positive,
  SUM(CASE WHEN predicted = 1 AND actual = 0 THEN 1 ELSE 0 END) AS false_positive,
  SUM(CASE WHEN predicted = 0 AND actual = 1 THEN 1 ELSE 0 END) AS false_negative,
  AVG(CASE WHEN predicted = actual THEN 1.0 ELSE 0.0 END) AS accuracy
FROM scored
GROUP BY threshold
ORDER BY threshold;

-- -----------------------------
-- 9. Class weights for imbalanced targets
-- -----------------------------
SELECT
  am AS class_value,
  COUNT(*) AS class_rows,
  SUM(COUNT(*)) OVER () * 1.0 / (COUNT(*) * COUNT(*) OVER ()) AS balanced_class_weight
FROM data_table
GROUP BY am
ORDER BY am;

-- -----------------------------
-- 10. Time and group split examples
-- -----------------------------
CREATE OR REPLACE VIEW time_ordered_split AS
SELECT
  *,
  CASE
    WHEN percent_rank() OVER (ORDER BY row_id) >= 0.80 THEN 'test'
    ELSE 'train'
  END AS time_split
FROM model_features;

CREATE OR REPLACE VIEW group_split AS
SELECT
  *,
  CASE WHEN cyl IN (8) THEN 'test' ELSE 'train' END AS group_split
FROM data_table;

-- -----------------------------
-- 11. Model card metadata
-- Keep the decision record close to the data and metrics.
-- -----------------------------
CREATE OR REPLACE TABLE model_card (
  model_id VARCHAR,
  target VARCHAR,
  grain VARCHAR,
  predictors VARCHAR,
  validation_design VARCHAR,
  selected_metric VARCHAR,
  selected_metric_value DOUBLE,
  diagnostics_completed VARCHAR,
  limitations VARCHAR,
  owner VARCHAR,
  created_at TIMESTAMP
);

INSERT INTO model_card VALUES (
  'model_001',
  'mpg',
  'One row per car in mtcars. Replace with your project grain.',
  'wt, hp, disp, qsec, am',
  'Holdout plus 5-fold CV. Replace with time or group CV when needed.',
  'rmse',
  2.90,
  'missingness, leakage, collinearity, heteroskedasticity risk, overfit gap',
  'Teaching dataset; predictive validation is not causal identification.',
  'Linda Data',
  current_timestamp
);
