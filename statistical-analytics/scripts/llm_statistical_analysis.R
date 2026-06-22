#!/usr/bin/env Rscript

# Statistical analysis templates for LLM outputs.
# This file does not call an LLM API. It assumes outputs have already been
# generated and evaluated, then treats them as experimental/statistical data.

llm_schema <- data.frame(
  column = c(
    "item_id", "prompt_id", "model_id", "model_version", "output_id",
    "evaluator_id", "score", "factual", "confidence", "input_tokens",
    "output_tokens", "latency_ms", "cost_usd", "evaluated_at"
  ),
  meaning = c(
    "Stable test item or task identifier",
    "Prompt or system design assigned to the item",
    "Model family or provider label",
    "Model version string captured at evaluation time",
    "Unique output identifier",
    "Human or model evaluator identifier",
    "Rubric score, usually numeric or ordinal",
    "Binary factuality or correctness label",
    "Stated or evaluator-derived confidence from 0 to 1",
    "Input token count",
    "Output token count",
    "Observed latency in milliseconds",
    "Estimated cost in dollars",
    "Timestamp of evaluation"
  )
)

example_llm_data <- data.frame(
  item_id = rep(sprintf("item_%02d", 1:30), each = 2),
  prompt_id = rep(c("baseline", "candidate"), times = 30),
  model_id = "example_model",
  model_version = "v1",
  output_id = sprintf("out_%03d", 1:60),
  evaluator_id = "human_1",
  score = c(rep(c(3, 4), 15), rep(c(4, 5), 15)),
  factual = rep(c(1, 1, 0, 1, 1), length.out = 60),
  confidence = pmin(0.98, rep(c(0.62, 0.75, 0.58, 0.83, 0.91, 0.69), length.out = 60) + rep(seq_len(30) %% 5, each = 2) * 0.005),
  input_tokens = 380 + rep(seq_len(30), each = 2) + rep(c(0, 12), times = 30),
  output_tokens = 150 + rep(seq_len(30) %% 7, each = 2) + rep(c(0, 15), times = 30),
  latency_ms = seq(900, 1600, length.out = 60),
  cost_usd = seq(0.002, 0.006, length.out = 60),
  evaluated_at = Sys.time(),
  stringsAsFactors = FALSE
)

prompt_score_model <- function(data) {
  stats::lm(score ~ prompt_id + input_tokens + output_tokens, data = data)
}

factuality_model <- function(data) {
  stats::glm(factual ~ prompt_id + confidence + input_tokens + output_tokens, data = data, family = binomial())
}

prompt_ab_test <- function(data) {
  stats::prop.test(
    x = with(data, tapply(factual, prompt_id, sum)),
    n = table(data$prompt_id)
  )
}

brier_score <- function(correct, probability) {
  mean((correct - probability)^2, na.rm = TRUE)
}

calibration_table <- function(data, bins = 5) {
  breaks <- unique(quantile(data$confidence, probs = seq(0, 1, length.out = bins + 1), na.rm = TRUE))
  data$confidence_bin <- cut(data$confidence, breaks = breaks, include.lowest = TRUE)
  aggregate(
    cbind(mean_confidence = confidence, observed_accuracy = factual) ~ confidence_bin,
    data = data,
    FUN = mean
  )
}

cost_quality_frontier <- function(data) {
  aggregate(
    cbind(score, factual, latency_ms, cost_usd) ~ prompt_id + model_id,
    data = data,
    FUN = mean
  )
}

cohen_kappa_2_raters <- function(labels_a, labels_b) {
  tab <- table(labels_a, labels_b)
  observed <- sum(diag(tab)) / sum(tab)
  expected <- sum(rowSums(tab) * colSums(tab)) / sum(tab)^2
  (observed - expected) / (1 - expected)
}

embedding_cluster_template <- function(embedding_matrix, centers = 5) {
  stats::kmeans(scale(embedding_matrix), centers = centers, nstart = 20)
}

drift_table <- function(data) {
  data$eval_date <- as.Date(data$evaluated_at)
  aggregate(
    cbind(score, factual, confidence, latency_ms, cost_usd) ~ eval_date + prompt_id + model_version,
    data = data,
    FUN = mean
  )
}

if (identical(environment(), globalenv())) {
  print(llm_schema)
  print(summary(prompt_score_model(example_llm_data)))
  print(summary(factuality_model(example_llm_data)))
  print(prompt_ab_test(example_llm_data))
  print(calibration_table(example_llm_data))
  print(brier_score(example_llm_data$factual, example_llm_data$confidence))
  print(cost_quality_frontier(example_llm_data))
}
