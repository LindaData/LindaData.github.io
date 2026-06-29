#!/usr/bin/env Rscript

# Linda Data copy-paste R samples.
# Replace DATA, TARGET, PREDICTORS, GROUP, ID, TIME, EVENT, and COUNT columns.

# -----------------------------
# 0. Universal setup
# -----------------------------
DATA <- mtcars
TARGET <- "mpg"
PREDICTORS <- c("wt", "hp", "disp")
GROUP <- "am"

formula_from_names <- function(target, predictors) {
  stats::as.formula(paste(target, "~", paste(predictors, collapse = " + ")))
}

profile_data <- function(data) {
  data.frame(
    variable = names(data),
    class = vapply(data, function(x) paste(class(x), collapse = "/"), character(1)),
    rows = nrow(data),
    missing = vapply(data, function(x) sum(is.na(x)), integer(1)),
    missing_rate = vapply(data, function(x) mean(is.na(x)), numeric(1)),
    unique_values = vapply(data, function(x) length(unique(x)), integer(1)),
    row.names = NULL
  )
}

vif_base <- function(model) {
  mm <- stats::model.matrix(model)
  mm <- mm[, colnames(mm) != "(Intercept)", drop = FALSE]
  if (ncol(mm) <= 1) return(data.frame(term = colnames(mm), vif = 1))
  out <- lapply(seq_len(ncol(mm)), function(j) {
    target <- mm[, j]
    others <- mm[, -j, drop = FALSE]
    r2 <- summary(stats::lm(target ~ others))$r.squared
    data.frame(term = colnames(mm)[j], vif = 1 / (1 - r2))
  })
  do.call(rbind, out)
}

print(profile_data(DATA))

# -----------------------------
# 1. Continuous target: OLS
# Swap DATA, TARGET, PREDICTORS.
# -----------------------------
ols_fit <- stats::lm(formula_from_names(TARGET, PREDICTORS), data = DATA)
summary(ols_fit)
vif_base(ols_fit)
if (interactive()) {
  plot(ols_fit)
}

# -----------------------------
# 2. Binary target: logistic regression
# Target must be coded 0/1 or FALSE/TRUE.
# -----------------------------
DATA_LOGIT <- mtcars
DATA_LOGIT$target_binary <- DATA_LOGIT$am
logit_fit <- stats::glm(target_binary ~ mpg + wt + hp, data = DATA_LOGIT, family = binomial())
summary(logit_fit)
predict(logit_fit, type = "response")

# -----------------------------
# 3. Count target: Poisson regression
# Use quasi-Poisson or negative binomial if overdispersed.
# -----------------------------
DATA_COUNT <- warpbreaks
poisson_fit <- stats::glm(breaks ~ wool + tension, data = DATA_COUNT, family = poisson())
summary(poisson_fit)
dispersion_ratio <- sum(stats::residuals(poisson_fit, type = "pearson")^2) / poisson_fit$df.residual
dispersion_ratio

if (dispersion_ratio > 1.5 && requireNamespace("MASS", quietly = TRUE)) {
  MASS::glm.nb(breaks ~ wool + tension, data = DATA_COUNT)
}

# -----------------------------
# 4. Group comparison: t-test, ANOVA, chi-square
# -----------------------------
stats::t.test(mpg ~ am, data = mtcars)
summary(stats::aov(len ~ supp * factor(dose), data = ToothGrowth))
stats::chisq.test(table(mtcars$cyl, mtcars$am), simulate.p.value = TRUE)

# -----------------------------
# 5. Repeated or grouped rows: mixed model
# Requires nlme, which ships with standard R installations.
# -----------------------------
if (requireNamespace("nlme", quietly = TRUE)) {
  mixed_fit <- nlme::lme(weight ~ Time + Diet, random = ~ 1 | Chick, data = ChickWeight)
  summary(mixed_fit)
}

# -----------------------------
# 6. Survival / time-to-event
# Swap time, event, and predictor names.
# -----------------------------
if (requireNamespace("survival", quietly = TRUE)) {
  survival_fit <- survival::coxph(survival::Surv(time, status) ~ age + sex, data = survival::lung)
  summary(survival_fit)
}

# -----------------------------
# 7. Time series
# Swap SERIES with a ts object or numeric vector converted to ts().
# -----------------------------
SERIES <- AirPassengers
stats::decompose(SERIES)
stats::arima(SERIES, order = c(1, 1, 1), seasonal = list(order = c(1, 1, 1), period = 12))
stats::HoltWinters(SERIES)

# -----------------------------
# 8. PCA and clustering
# Swap FEATURE_DATA with numeric columns.
# -----------------------------
FEATURE_DATA <- scale(USArrests)
pca_fit <- stats::prcomp(FEATURE_DATA)
summary(pca_fit)
cluster_fit <- stats::kmeans(FEATURE_DATA, centers = 3, nstart = 20)
cluster_fit$cluster

# -----------------------------
# 9. LLM evaluation as statistics
# One row per evaluated output.
# -----------------------------
LLM_DATA <- data.frame(
  item_id = rep(1:20, each = 2),
  prompt_id = rep(c("baseline", "candidate"), times = 20),
  score = c(rep(c(3, 4), 10), rep(c(4, 5), 10)),
  factual = as.integer((rep(seq_len(20), each = 2) + rep(c(0, 1), times = 20)) %% 5 != 0),
  confidence = seq(0.55, 0.94, length.out = 40)
)

summary(stats::lm(score ~ prompt_id, data = LLM_DATA))
summary(stats::glm(factual ~ prompt_id + confidence, data = LLM_DATA, family = binomial()))
stats::prop.test(
  x = with(LLM_DATA, tapply(factual, prompt_id, sum)),
  n = table(LLM_DATA$prompt_id)
)
mean((LLM_DATA$factual - LLM_DATA$confidence)^2)
