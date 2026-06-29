#!/usr/bin/env Rscript

# Linda Data model tuning templates for R/RStudio.
# Copy a block, replace DATA, TARGET, PREDICTORS, GROUP, ID, TIME, and METRIC.
# Optional packages are guarded so this file still runs on a base R install.

set.seed(123)

# -----------------------------
# 0. Universal setup
# -----------------------------
DATA <- mtcars
TARGET <- "mpg"
PREDICTORS <- c("wt", "hp", "disp", "qsec", "am")
CLASS_TARGET <- "am"
METRIC <- "rmse"

formula_from_names <- function(target, predictors) {
  stats::as.formula(paste(target, "~", paste(predictors, collapse = " + ")))
}

rmse <- function(actual, predicted) {
  sqrt(mean((actual - predicted)^2, na.rm = TRUE))
}

mae <- function(actual, predicted) {
  mean(abs(actual - predicted), na.rm = TRUE)
}

rsq <- function(actual, predicted) {
  1 - sum((actual - predicted)^2, na.rm = TRUE) /
    sum((actual - mean(actual, na.rm = TRUE))^2, na.rm = TRUE)
}

make_split <- function(data, test_size = 0.25, seed = 123) {
  set.seed(seed)
  test_n <- max(1, floor(nrow(data) * test_size))
  test_id <- sample(seq_len(nrow(data)), test_n)
  split <- rep("train", nrow(data))
  split[test_id] <- "test"
  split
}

make_folds <- function(data, k = 5, seed = 123) {
  set.seed(seed)
  sample(rep(seq_len(k), length.out = nrow(data)))
}

score_regression <- function(actual, predicted) {
  data.frame(
    rmse = rmse(actual, predicted),
    mae = mae(actual, predicted),
    r_squared = rsq(actual, predicted),
    row.names = NULL
  )
}

vif_base <- function(model) {
  mm <- stats::model.matrix(model)
  mm <- mm[, colnames(mm) != "(Intercept)", drop = FALSE]
  if (ncol(mm) == 0) return(data.frame(term = character(0), vif = numeric(0)))
  if (ncol(mm) == 1) return(data.frame(term = colnames(mm), vif = 1))
  out <- lapply(seq_len(ncol(mm)), function(j) {
    target_col <- mm[, j]
    other_cols <- mm[, -j, drop = FALSE]
    r2 <- summary(stats::lm(target_col ~ other_cols))$r.squared
    data.frame(term = colnames(mm)[j], vif = 1 / (1 - r2))
  })
  do.call(rbind, out)
}

quick_diagnostics <- function(data, target, predictors) {
  fit <- stats::lm(formula_from_names(target, predictors), data = data)
  residuals <- stats::residuals(fit)
  fitted <- stats::fitted(fit)
  hetero_fit <- stats::lm(residuals^2 ~ fitted)
  data.frame(
    rows = nrow(data),
    missing_target = sum(is.na(data[[target]])),
    max_vif = max(vif_base(fit)$vif, na.rm = TRUE),
    condition_number = kappa(stats::model.matrix(fit)),
    heteroskedasticity_screen_p = summary(hetero_fit)$coefficients[2, 4],
    max_cooks_distance = max(stats::cooks.distance(fit), na.rm = TRUE),
    row.names = NULL
  )
}

cv_lm <- function(data, target, predictors, k = 5, seed = 123) {
  folds <- make_folds(data, k = k, seed = seed)
  scores <- lapply(seq_len(k), function(fold) {
    train <- data[folds != fold, , drop = FALSE]
    test <- data[folds == fold, , drop = FALSE]
    fit <- stats::lm(formula_from_names(target, predictors), data = train)
    predicted <- stats::predict(fit, newdata = test)
    score_regression(test[[target]], predicted)
  })
  data.frame(model = "linear_regression", fold = seq_len(k), do.call(rbind, scores))
}

tuning_results <- data.frame(
  model = character(),
  parameters = character(),
  split = character(),
  rmse = numeric(),
  mae = numeric(),
  r_squared = numeric(),
  stringsAsFactors = FALSE
)

add_result <- function(results, model, parameters, split, actual, predicted) {
  metrics <- score_regression(actual, predicted)
  rbind(
    results,
    data.frame(
      model = model,
      parameters = parameters,
      split = split,
      rmse = metrics$rmse,
      mae = metrics$mae,
      r_squared = metrics$r_squared,
      stringsAsFactors = FALSE
    )
  )
}

DATA$split <- make_split(DATA)
train <- DATA[DATA$split == "train", , drop = FALSE]
test <- DATA[DATA$split == "test", , drop = FALSE]

print(quick_diagnostics(train, TARGET, PREDICTORS))

# -----------------------------
# 1. Baseline linear model
# Keep this baseline even when a tuned model wins.
# -----------------------------
baseline_fit <- stats::lm(formula_from_names(TARGET, PREDICTORS), data = train)
baseline_pred <- stats::predict(baseline_fit, newdata = test)
tuning_results <- add_result(
  tuning_results,
  "linear_regression",
  paste(PREDICTORS, collapse = "+"),
  "test",
  test[[TARGET]],
  baseline_pred
)

print(summary(baseline_fit))
print(vif_base(baseline_fit))
print(cv_lm(DATA, TARGET, PREDICTORS, k = 5))

# -----------------------------
# 2. Stepwise selection with AIC or BIC
# Swap PREDICTORS and direction. Use BIC by setting k = log(nrow(train)).
# -----------------------------
lower_formula <- stats::as.formula(paste(TARGET, "~ 1"))
upper_formula <- formula_from_names(TARGET, PREDICTORS)
full_fit <- stats::lm(upper_formula, data = train)

step_aic_fit <- stats::step(
  full_fit,
  scope = list(lower = lower_formula, upper = upper_formula),
  direction = "both",
  trace = 0
)
step_aic_pred <- stats::predict(step_aic_fit, newdata = test)
tuning_results <- add_result(
  tuning_results,
  "stepwise_aic",
  paste(names(stats::coef(step_aic_fit))[-1], collapse = "+"),
  "test",
  test[[TARGET]],
  step_aic_pred
)

step_bic_fit <- stats::step(
  full_fit,
  scope = list(lower = lower_formula, upper = upper_formula),
  direction = "both",
  k = log(nrow(train)),
  trace = 0
)
step_bic_pred <- stats::predict(step_bic_fit, newdata = test)
tuning_results <- add_result(
  tuning_results,
  "stepwise_bic",
  paste(names(stats::coef(step_bic_fit))[-1], collapse = "+"),
  "test",
  test[[TARGET]],
  step_bic_pred
)

# -----------------------------
# 3. Decision tree tuning
# Tune cp and tree size. Good for teachable nonlinear rules.
# -----------------------------
if (requireNamespace("rpart", quietly = TRUE)) {
  tree_grid <- expand.grid(cp = c(0.001, 0.01, 0.05), minsplit = c(5, 10))
  tree_scores <- lapply(seq_len(nrow(tree_grid)), function(i) {
    params <- tree_grid[i, ]
    fit <- rpart::rpart(
      formula_from_names(TARGET, PREDICTORS),
      data = train,
      method = "anova",
      control = rpart::rpart.control(cp = params$cp, minsplit = params$minsplit)
    )
    predicted <- stats::predict(fit, newdata = test)
    cbind(params, score_regression(test[[TARGET]], predicted))
  })
  tree_scores <- do.call(rbind, tree_scores)
  best_tree <- tree_scores[which.min(tree_scores$rmse), ]
  tuning_results <- rbind(
    tuning_results,
    data.frame(
      model = "decision_tree",
      parameters = paste("cp=", best_tree$cp, "; minsplit=", best_tree$minsplit, sep = ""),
      split = "test",
      rmse = best_tree$rmse,
      mae = best_tree$mae,
      r_squared = best_tree$r_squared,
      stringsAsFactors = FALSE
    )
  )
  print(tree_scores)
} else {
  message("Install rpart to run decision tree tuning: install.packages('rpart')")
}

# -----------------------------
# 4. Regularized regression with glmnet
# Ridge, lasso, and elastic net need a model matrix.
# -----------------------------
if (requireNamespace("glmnet", quietly = TRUE)) {
  x_train <- stats::model.matrix(formula_from_names(TARGET, PREDICTORS), data = train)[, -1, drop = FALSE]
  y_train <- train[[TARGET]]
  x_test <- stats::model.matrix(formula_from_names(TARGET, PREDICTORS), data = test)[, -1, drop = FALSE]

  for (alpha_value in c(0, 0.5, 1)) {
    fit <- glmnet::cv.glmnet(x_train, y_train, alpha = alpha_value, nfolds = 5)
    predicted <- as.numeric(stats::predict(fit, newx = x_test, s = "lambda.min"))
    tuning_results <- add_result(
      tuning_results,
      "glmnet",
      paste("alpha=", alpha_value, "; lambda=", signif(fit$lambda.min, 4), sep = ""),
      "test",
      test[[TARGET]],
      predicted
    )
  }
} else {
  message("Install glmnet to run ridge, lasso, and elastic net tuning: install.packages('glmnet')")
}

# -----------------------------
# 5. Random forest tuning
# Use ranger when available; randomForest is a fine fallback.
# -----------------------------
if (requireNamespace("ranger", quietly = TRUE)) {
  rf_grid <- expand.grid(
    mtry = pmax(1, c(2, floor(sqrt(length(PREDICTORS))), length(PREDICTORS))),
    min.node.size = c(1, 3, 5)
  )
  rf_scores <- lapply(seq_len(nrow(rf_grid)), function(i) {
    params <- rf_grid[i, ]
    fit <- ranger::ranger(
      formula_from_names(TARGET, PREDICTORS),
      data = train,
      num.trees = 500,
      mtry = params$mtry,
      min.node.size = params$min.node.size,
      seed = 123
    )
    predicted <- stats::predict(fit, data = test)$predictions
    cbind(params, score_regression(test[[TARGET]], predicted))
  })
  print(do.call(rbind, rf_scores))
} else if (requireNamespace("randomForest", quietly = TRUE)) {
  fit <- randomForest::randomForest(
    formula_from_names(TARGET, PREDICTORS),
    data = train,
    ntree = 500,
    mtry = floor(sqrt(length(PREDICTORS)))
  )
  predicted <- stats::predict(fit, newdata = test)
  tuning_results <- add_result(
    tuning_results,
    "random_forest",
    paste("ntree=500; mtry=", floor(sqrt(length(PREDICTORS))), sep = ""),
    "test",
    test[[TARGET]],
    predicted
  )
} else {
  message("Install ranger or randomForest to run random forest tuning.")
}

# -----------------------------
# 6. XGBoost tuning with early stopping
# Install with install.packages('xgboost') before using this block.
# -----------------------------
tune_xgboost_regression <- function(data, target, predictors, nrounds = 300, seed = 123) {
  if (!requireNamespace("xgboost", quietly = TRUE)) {
    stop("Install xgboost first: install.packages('xgboost')")
  }
  set.seed(seed)
  x <- stats::model.matrix(formula_from_names(target, predictors), data = data)[, -1, drop = FALSE]
  y <- data[[target]]
  dtrain <- xgboost::xgb.DMatrix(data = x, label = y)
  grid <- expand.grid(
    eta = c(0.03, 0.1),
    max_depth = c(2, 3, 5),
    min_child_weight = c(1, 5),
    subsample = c(0.8, 1),
    colsample_bytree = c(0.8, 1)
  )
  scores <- lapply(seq_len(nrow(grid)), function(i) {
    params <- as.list(grid[i, ])
    params$objective <- "reg:squarederror"
    params$eval_metric <- "rmse"
    params$lambda <- 1
    cv <- xgboost::xgb.cv(
      params = params,
      data = dtrain,
      nrounds = nrounds,
      nfold = 5,
      early_stopping_rounds = 20,
      verbose = 0,
      seed = seed
    )
    data.frame(
      grid[i, ],
      best_iteration = cv$best_iteration,
      cv_rmse = min(cv$evaluation_log$test_rmse_mean),
      row.names = NULL
    )
  })
  scores <- do.call(rbind, scores)
  scores[order(scores$cv_rmse), ]
}

if (requireNamespace("xgboost", quietly = TRUE)) {
  xgb_scores <- tune_xgboost_regression(DATA, TARGET, PREDICTORS)
  print(head(xgb_scores, 10))
} else {
  message("Install xgboost to run XGBoost tuning: install.packages('xgboost')")
}

# -----------------------------
# 7. Classification tuning pattern
# Swap CLASS_TARGET for a 0/1 or factor target.
# -----------------------------
CLASS_DATA <- mtcars
CLASS_DATA[[CLASS_TARGET]] <- factor(CLASS_DATA[[CLASS_TARGET]])
class_predictors <- c("mpg", "wt", "hp", "disp")
class_split <- make_split(CLASS_DATA)
class_train <- CLASS_DATA[class_split == "train", , drop = FALSE]
class_test <- CLASS_DATA[class_split == "test", , drop = FALSE]

class_fit <- stats::glm(
  stats::as.formula(paste(CLASS_TARGET, "~", paste(class_predictors, collapse = " + "))),
  data = transform(class_train, am_numeric = as.integer(as.character(am))),
  family = binomial()
)
class_prob <- stats::predict(class_fit, newdata = class_test, type = "response")
threshold_grid <- seq(0.2, 0.8, by = 0.05)
threshold_scores <- data.frame(
  threshold = threshold_grid,
  accuracy = vapply(threshold_grid, function(threshold) {
    predicted <- ifelse(class_prob >= threshold, "1", "0")
    mean(predicted == as.character(class_test[[CLASS_TARGET]]))
  }, numeric(1))
)
print(threshold_scores[which.max(threshold_scores$accuracy), ])

# -----------------------------
# 8. Model card skeleton
# Fill this out after choosing the model.
# -----------------------------
model_card <- list(
  target = TARGET,
  grain = "One row per car in mtcars. Replace with your project grain.",
  predictors = PREDICTORS,
  validation = "Holdout split plus 5-fold CV. Replace with time or group CV if needed.",
  diagnostics = quick_diagnostics(train, TARGET, PREDICTORS),
  candidate_results = tuning_results[order(tuning_results$rmse), ],
  selected_model = tuning_results$model[which.min(tuning_results$rmse)],
  known_limits = c(
    "Small sample teaching data.",
    "No causal claim unless the study design supports it.",
    "Retune after changing the target, data grain, or feature set."
  )
)

print(model_card)
