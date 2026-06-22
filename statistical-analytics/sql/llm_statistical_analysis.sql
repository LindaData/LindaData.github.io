-- Statistical analysis schema and SQL summaries for LLM evaluations.

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

-- Prompt/model performance summary.
SELECT
  prompt_id,
  model_id,
  model_version,
  COUNT(*) AS outputs_evaluated,
  AVG(score) AS mean_score,
  AVG(factual) AS factuality_rate,
  AVG(confidence) AS mean_confidence,
  AVG(input_tokens + output_tokens) AS mean_total_tokens,
  AVG(latency_ms) AS mean_latency_ms,
  AVG(cost_usd) AS mean_cost_usd
FROM llm_evaluations
GROUP BY prompt_id, model_id, model_version;

-- Paired prompt comparison input: one row per item with baseline and candidate scores.
CREATE OR REPLACE VIEW llm_prompt_pairs AS
SELECT
  b.item_id,
  b.score AS baseline_score,
  c.score AS candidate_score,
  c.score - b.score AS score_delta,
  b.factual AS baseline_factual,
  c.factual AS candidate_factual,
  c.factual - b.factual AS factual_delta
FROM llm_evaluations b
JOIN llm_evaluations c
  ON b.item_id = c.item_id
 AND b.model_id = c.model_id
 AND b.prompt_id = 'baseline'
 AND c.prompt_id = 'candidate';

-- Calibration bins and Brier components.
SELECT
  prompt_id,
  model_id,
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
GROUP BY prompt_id, model_id, confidence_bin
ORDER BY prompt_id, model_id, confidence_bin;

-- Human/LLM evaluator agreement input for kappa or ICC in R/Python.
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

-- Drift table by day, prompt, and model version.
SELECT
  CAST(evaluated_at AS DATE) AS eval_date,
  prompt_id,
  model_id,
  model_version,
  COUNT(*) AS n,
  AVG(score) AS mean_score,
  AVG(factual) AS factuality_rate,
  AVG(confidence) AS mean_confidence,
  AVG(latency_ms) AS mean_latency_ms,
  AVG(cost_usd) AS mean_cost_usd
FROM llm_evaluations
GROUP BY eval_date, prompt_id, model_id, model_version
ORDER BY eval_date, prompt_id, model_id, model_version;
