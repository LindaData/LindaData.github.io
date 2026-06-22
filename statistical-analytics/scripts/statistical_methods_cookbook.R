#!/usr/bin/env Rscript

# Linda Data statistical methods cookbook for R/RStudio.
# This file is intentionally broad: it gives runnable templates and package
# entry points for the major techniques listed in data/statistical_techniques_catalog.csv.

source_if_exists <- function(path) {
  if (file.exists(path)) source(path)
}

source_if_exists("statistical-analytics/scripts/diagnostics_helpers.R")

data(mtcars)
data(iris)
data(airquality)
data(ChickWeight)
data(ToothGrowth)
data(warpbreaks)
data(USArrests)
data(AirPassengers)

safe_require <- function(pkg) {
  requireNamespace(pkg, quietly = TRUE)
}

# Data audit and descriptive statistics
profile_data(mtcars)
numeric_profile(mtcars)
table(mtcars$cyl)
xtabs(~ cyl + am, data = mtcars)
cor(mtcars[, c("mpg", "wt", "hp", "disp")], use = "complete.obs")
cor(mtcars$mpg, mtcars$wt, method = "spearman")
cov(mtcars[, c("mpg", "wt", "hp")])

# Classical inference
t.test(mtcars$mpg, mu = 20)
t.test(mpg ~ am, data = mtcars)
t.test(ToothGrowth$len[ToothGrowth$dose == 0.5], ToothGrowth$len[ToothGrowth$dose == 1], paired = FALSE)
wilcox.test(mpg ~ am, data = mtcars)
chisq.test(table(mtcars$cyl, mtcars$am), simulate.p.value = TRUE, B = 2000)
fisher.test(table(mtcars$vs, mtcars$am))
ks.test(jitter(as.numeric(scale(mtcars$mpg))), "pnorm")
p.adjust(c(0.04, 0.01, 0.20, 0.003), method = "BH")

# Experimentation and resampling
prop.test(x = c(56, 69), n = c(100, 100))
power.t.test(delta = 2, sd = 5, power = 0.8)
bootstrap_mean <- replicate(1000, mean(sample(mtcars$mpg, replace = TRUE)))
quantile(bootstrap_mean, c(0.025, 0.975))
observed_diff <- with(mtcars, mean(mpg[am == 1]) - mean(mpg[am == 0]))
permuted <- replicate(1000, {
  shuffled <- sample(mtcars$am)
  mean(mtcars$mpg[shuffled == 1]) - mean(mtcars$mpg[shuffled == 0])
})
mean(abs(permuted) >= abs(observed_diff))

# ANOVA and nonparametric design
summary(aov(len ~ factor(dose), data = ToothGrowth))
summary(aov(len ~ supp * factor(dose), data = ToothGrowth))
summary(lm(len ~ supp + dose, data = ToothGrowth))
summary(manova(cbind(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width) ~ Species, data = iris))
kruskal.test(len ~ factor(dose), data = ToothGrowth)
friedman.test(as.matrix(mtcars[, c("mpg", "hp", "wt")]))

# Regression and diagnostics
fit_lm <- lm(mpg ~ wt + hp + disp, data = mtcars)
summary(fit_lm)
run_lm_diagnostics(fit_lm, mtcars)
summary(lm(mpg ~ wt * am + hp, data = mtcars))
summary(lm(mpg ~ poly(wt, 2) + hp, data = mtcars))
summary(glm(am ~ mpg + wt + hp, data = mtcars, family = binomial()))
summary(glm(breaks ~ wool + tension, data = warpbreaks, family = poisson()))

if (safe_require("MASS")) {
  MASS::rlm(mpg ~ wt + hp, data = mtcars)
  MASS::glm.nb(breaks ~ wool + tension, data = warpbreaks)
  MASS::lda(Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, data = iris)
}

if (safe_require("splines")) {
  summary(lm(Ozone ~ splines::ns(Temp, df = 4) + Wind, data = airquality))
}

if (safe_require("quantreg")) {
  quantreg::rq(mpg ~ wt + hp, data = mtcars, tau = 0.5)
}

if (safe_require("glmnet")) {
  x <- model.matrix(mpg ~ wt + hp + disp + drat + qsec, data = mtcars)[, -1]
  y <- mtcars$mpg
  glmnet::cv.glmnet(x, y, alpha = 0)   # ridge
  glmnet::cv.glmnet(x, y, alpha = 1)   # lasso
  glmnet::cv.glmnet(x, y, alpha = 0.5) # elastic net
}

# Grouped, panel, and causal modeling entry points
if (safe_require("nlme")) {
  nlme::lme(weight ~ Time + Diet, random = ~ 1 | Chick, data = ChickWeight)
}

if (safe_require("survival")) {
  survival::survfit(survival::Surv(time, status) ~ 1, data = survival::lung)
  survival::coxph(survival::Surv(time, status) ~ age + sex, data = survival::lung)
  survival::survreg(survival::Surv(time, status) ~ age + sex, data = survival::lung)
}

# Time series
decompose(AirPassengers)
arima(AirPassengers, order = c(1, 1, 1), seasonal = list(order = c(1, 1, 1), period = 12))
HoltWinters(AirPassengers)

# Multivariate, clustering, and measurement
prcomp(USArrests, scale. = TRUE)
factanal(USArrests, factors = 1)
kmeans(scale(USArrests), centers = 3, nstart = 20)
hclust(dist(scale(USArrests)))
cancor(iris[, 1:2], iris[, 3:4])

cronbach_alpha <- function(items) {
  items <- as.data.frame(items)
  k <- ncol(items)
  total <- rowSums(items, na.rm = TRUE)
  k / (k - 1) * (1 - sum(vapply(items, stats::var, numeric(1), na.rm = TRUE)) / stats::var(total, na.rm = TRUE))
}

cohen_kappa_2x2 <- function(rater_a, rater_b) {
  tab <- table(rater_a, rater_b)
  observed <- sum(diag(tab)) / sum(tab)
  expected <- sum(rowSums(tab) * colSums(tab)) / sum(tab)^2
  (observed - expected) / (1 - expected)
}

# LLM statistical analysis templates
llm_scores <- data.frame(
  item_id = rep(1:20, each = 2),
  prompt_id = rep(c("baseline", "candidate"), times = 20),
  model_id = "example_model",
  score = c(rep(c(3, 4), 10), rep(c(4, 5), 10)),
  factual = as.integer((rep(seq_len(20), each = 2) + rep(c(0, 1), times = 20)) %% 5 != 0),
  confidence = seq(0.55, 0.94, length.out = 40)
)

summary(lm(score ~ prompt_id, data = llm_scores))
summary(glm(factual ~ prompt_id + confidence, data = llm_scores, family = binomial()))
prop.test(
  x = with(llm_scores, tapply(factual, prompt_id, sum)),
  n = table(llm_scores$prompt_id)
)

calibration_bins <- function(data, confidence_col = "confidence", correct_col = "factual", bins = 5) {
  cut_points <- quantile(data[[confidence_col]], probs = seq(0, 1, length.out = bins + 1), na.rm = TRUE)
  data$confidence_bin <- cut(data[[confidence_col]], breaks = unique(cut_points), include.lowest = TRUE)
  aggregate(data[[correct_col]], by = list(confidence_bin = data$confidence_bin), FUN = mean)
}

brier_score <- function(correct, probability) {
  mean((correct - probability)^2, na.rm = TRUE)
}

calibration_bins(llm_scores)
brier_score(llm_scores$factual, llm_scores$confidence)
