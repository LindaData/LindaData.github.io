#!/usr/bin/env Rscript

# Build real R model visuals for the Linda Data visual regression guide.
# The page uses these PNG files; rerun this script after changing the models.

out_dir <- file.path("statistical-analytics", "assets", "regression-visuals")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

png_file <- function(name) file.path(out_dir, paste0(name, ".png"))

save_plot <- function(name, expr, width = 920, height = 560) {
  grDevices::png(png_file(name), width = width, height = height, res = 120)
  old <- graphics::par(no.readonly = TRUE)
  on.exit({
    graphics::par(old)
    grDevices::dev.off()
  }, add = TRUE)
  graphics::par(
    mar = c(4.5, 4.5, 2.2, 1.2),
    bg = "white",
    fg = "#17212b",
    col.axis = "#5a6673",
    col.lab = "#17212b"
  )
  force(expr)
}

points_soft <- function(x, y, ...) {
  graphics::points(x, y, pch = 19, col = grDevices::adjustcolor("#1769aa", 0.72), ...)
}

line_main <- function(x, y, ...) {
  graphics::lines(x, y, col = "#14785a", lwd = 3, ...)
}

guide <- list()

add_row <- function(id, model, data, question, r_model, visual, checks, parameters) {
  guide[[length(guide) + 1]] <<- data.frame(
    id = id,
    model = model,
    data = data,
    question = question,
    r_model = r_model,
    visual = visual,
    checks = checks,
    key_parameters = parameters,
    stringsAsFactors = FALSE
  )
}

# 1. Simple linear regression
save_plot("linear-regression", {
  fit <- stats::lm(mpg ~ wt, data = mtcars)
  graphics::plot(mtcars$wt, mtcars$mpg, xlab = "Weight", ylab = "Miles per gallon", main = "Linear regression")
  points_soft(mtcars$wt, mtcars$mpg)
  graphics::abline(fit, col = "#14785a", lwd = 3)
})
add_row("linear-regression", "Simple linear regression", "mtcars", "How does one numeric predictor relate to a continuous target?", "lm(mpg ~ wt, data = mtcars)", "assets/regression-visuals/linear-regression.png", "Linearity, residual spread, leverage, outliers.", "Slope, intercept, residual standard error, R-squared.")

# 2. Multiple linear regression
save_plot("multiple-regression", {
  fit <- stats::lm(mpg ~ wt + hp + disp, data = mtcars)
  pred <- stats::predict(fit)
  graphics::plot(pred, mtcars$mpg, xlab = "Fitted MPG", ylab = "Observed MPG", main = "Multiple regression")
  points_soft(pred, mtcars$mpg)
  graphics::abline(0, 1, col = "#14785a", lwd = 3)
})
add_row("multiple-regression", "Multiple linear regression", "mtcars", "How do several predictors explain a continuous target?", "lm(mpg ~ wt + hp + disp, data = mtcars)", "assets/regression-visuals/multiple-regression.png", "VIF, condition number, heteroskedasticity, influence.", "Coefficients, adjusted R-squared, RMSE.")

# 3. Polynomial regression
save_plot("polynomial-regression", {
  fit <- stats::lm(dist ~ speed + I(speed^2), data = cars)
  grid <- data.frame(speed = seq(min(cars$speed), max(cars$speed), length.out = 120))
  grid$dist <- stats::predict(fit, newdata = grid)
  graphics::plot(cars$speed, cars$dist, xlab = "Speed", ylab = "Stopping distance", main = "Polynomial regression")
  points_soft(cars$speed, cars$dist)
  line_main(grid$speed, grid$dist)
})
add_row("polynomial-regression", "Polynomial regression", "cars", "Is the relationship curved but still explainable?", "lm(dist ~ speed + I(speed^2), data = cars)", "assets/regression-visuals/polynomial-regression.png", "Residual curvature, extrapolation risk, overfit.", "Polynomial degree, centered predictors.")

# 4. Spline regression
save_plot("spline-regression", {
  fit <- stats::lm(mpg ~ splines::ns(wt, df = 3), data = mtcars)
  grid <- data.frame(wt = seq(min(mtcars$wt), max(mtcars$wt), length.out = 160))
  grid$mpg <- stats::predict(fit, newdata = grid)
  graphics::plot(mtcars$wt, mtcars$mpg, xlab = "Weight", ylab = "Miles per gallon", main = "Spline regression")
  points_soft(mtcars$wt, mtcars$mpg)
  line_main(grid$wt, grid$mpg)
})
add_row("spline-regression", "Spline regression", "mtcars", "Does the effect bend without a simple polynomial shape?", "lm(mpg ~ splines::ns(wt, df = 3), data = mtcars)", "assets/regression-visuals/spline-regression.png", "Boundary behavior, degrees of freedom, residual pattern.", "Knots, basis dimension, smoothness.")

# 5. Interaction model
save_plot("interaction-model", {
  tg <- transform(ToothGrowth, dose = as.numeric(dose))
  fit <- stats::lm(len ~ supp * dose, data = tg)
  graphics::plot(tg$dose, tg$len, xlab = "Dose", ylab = "Tooth length", main = "Interaction model", type = "n")
  cols <- c(OJ = "#1769aa", VC = "#14785a")
  for (supp in levels(tg$supp)) {
    sub <- tg[tg$supp == supp, ]
    graphics::points(sub$dose, sub$len, pch = 19, col = grDevices::adjustcolor(cols[[supp]], 0.7))
    grid <- data.frame(dose = seq(min(tg$dose), max(tg$dose), length.out = 60), supp = supp)
    graphics::lines(grid$dose, stats::predict(fit, newdata = grid), col = cols[[supp]], lwd = 3)
  }
  graphics::legend("topleft", legend = names(cols), col = cols, lwd = 3, bty = "n")
})
add_row("interaction-model", "Interaction regression", "ToothGrowth", "Does one predictor's effect change by group?", "lm(len ~ supp * dose, data = ToothGrowth)", "assets/regression-visuals/interaction-model.png", "Cell counts, centering, hierarchy, simple slopes.", "Main effects, interaction coefficient.")

# 6. Logistic regression
save_plot("logistic-regression", {
  fit <- stats::glm(am ~ mpg + wt, data = mtcars, family = binomial())
  grid <- data.frame(mpg = seq(min(mtcars$mpg), max(mtcars$mpg), length.out = 160), wt = mean(mtcars$wt))
  grid$prob <- stats::predict(fit, newdata = grid, type = "response")
  graphics::plot(mtcars$mpg, mtcars$am, xlab = "Miles per gallon", ylab = "Pr(manual transmission)", main = "Logistic regression", yaxt = "n")
  graphics::axis(2, at = c(0, 1))
  points_soft(mtcars$mpg, mtcars$am)
  line_main(grid$mpg, grid$prob)
})
add_row("logistic-regression", "Logistic regression", "mtcars", "What predicts a yes/no outcome?", "glm(am ~ mpg + wt, data = mtcars, family = binomial())", "assets/regression-visuals/logistic-regression.png", "Class balance, separation, calibration, threshold.", "Odds ratio, logit link, predicted probability.")

# 7. Probit regression
save_plot("probit-regression", {
  fit <- stats::glm(am ~ mpg + wt, data = mtcars, family = binomial(link = "probit"))
  grid <- data.frame(mpg = seq(min(mtcars$mpg), max(mtcars$mpg), length.out = 160), wt = mean(mtcars$wt))
  grid$prob <- stats::predict(fit, newdata = grid, type = "response")
  graphics::plot(mtcars$mpg, mtcars$am, xlab = "Miles per gallon", ylab = "Pr(manual transmission)", main = "Probit regression", yaxt = "n")
  graphics::axis(2, at = c(0, 1))
  points_soft(mtcars$mpg, mtcars$am)
  line_main(grid$mpg, grid$prob)
})
add_row("probit-regression", "Probit regression", "mtcars", "Is a latent normal threshold model preferred?", "glm(am ~ mpg + wt, data = mtcars, family = binomial(link = 'probit'))", "assets/regression-visuals/probit-regression.png", "Separation, calibration, marginal effects.", "Latent z-score scale, normal link.")

# 8. Poisson regression
save_plot("poisson-regression", {
  fit <- stats::glm(breaks ~ wool + tension, data = warpbreaks, family = poisson())
  pred <- aggregate(stats::predict(fit, type = "response"), list(tension = warpbreaks$tension), mean)
  obs <- aggregate(warpbreaks$breaks, list(tension = warpbreaks$tension), mean)
  graphics::barplot(obs$x, names.arg = obs$tension, col = "#dbeaf6", border = "#1769aa", xlab = "Tension", ylab = "Mean breaks", main = "Poisson regression")
  graphics::points(seq_along(pred$x), pred$x, pch = 19, col = "#14785a", cex = 1.6)
})
add_row("poisson-regression", "Poisson regression", "warpbreaks", "What predicts event counts?", "glm(breaks ~ wool + tension, data = warpbreaks, family = poisson())", "assets/regression-visuals/poisson-regression.png", "Overdispersion, exposure, zero inflation, independence.", "Rate, log link, mean equals variance assumption.")

# 9. Negative binomial regression
if (requireNamespace("MASS", quietly = TRUE)) {
  save_plot("negative-binomial-regression", {
    fit <- MASS::glm.nb(breaks ~ wool + tension, data = warpbreaks)
    pred <- aggregate(stats::predict(fit, type = "response"), list(tension = warpbreaks$tension), mean)
    obs <- aggregate(warpbreaks$breaks, list(tension = warpbreaks$tension), mean)
    graphics::barplot(obs$x, names.arg = obs$tension, col = "#e5f3ed", border = "#14785a", xlab = "Tension", ylab = "Mean breaks", main = "Negative binomial regression")
    graphics::points(seq_along(pred$x), pred$x, pch = 19, col = "#9a6400", cex = 1.6)
  })
  add_row("negative-binomial-regression", "Negative binomial regression", "warpbreaks", "What predicts counts when variance is larger than the mean?", "MASS::glm.nb(breaks ~ wool + tension, data = warpbreaks)", "assets/regression-visuals/negative-binomial-regression.png", "Overdispersion, fitted zero rate, residual deviance.", "Mean, dispersion/theta, log link.")
}

# 10. Gamma regression
save_plot("gamma-regression", {
  fit <- stats::glm(mpg ~ wt + hp, data = mtcars, family = Gamma(link = "log"))
  pred <- stats::predict(fit, type = "response")
  graphics::plot(pred, mtcars$mpg, xlab = "Fitted MPG", ylab = "Observed MPG", main = "Gamma regression")
  points_soft(pred, mtcars$mpg)
  graphics::abline(0, 1, col = "#14785a", lwd = 3)
})
add_row("gamma-regression", "Gamma regression", "mtcars", "Is the continuous target positive and right-skewed?", "glm(mpg ~ wt + hp, data = mtcars, family = Gamma(link = 'log'))", "assets/regression-visuals/gamma-regression.png", "Positive target, residual shape, link fit.", "Mean model, scale, log link.")

# 11. Robust regression
if (requireNamespace("MASS", quietly = TRUE)) {
  save_plot("robust-regression", {
    ols <- stats::lm(mpg ~ wt, data = mtcars)
    robust <- MASS::rlm(mpg ~ wt, data = mtcars)
    graphics::plot(mtcars$wt, mtcars$mpg, xlab = "Weight", ylab = "Miles per gallon", main = "Robust regression")
    points_soft(mtcars$wt, mtcars$mpg)
    graphics::abline(ols, col = "#9a6400", lwd = 2, lty = 2)
    graphics::abline(robust, col = "#14785a", lwd = 3)
    graphics::legend("topright", legend = c("OLS", "Robust"), col = c("#9a6400", "#14785a"), lwd = c(2, 3), lty = c(2, 1), bty = "n")
  })
  add_row("robust-regression", "Robust regression", "mtcars", "Should outliers have less influence on the fitted line?", "MASS::rlm(mpg ~ wt, data = mtcars)", "assets/regression-visuals/robust-regression.png", "Outliers, leverage, sensitivity to influential rows.", "Loss function, robustness weights.")
}

# 12. Ridge regression
if (requireNamespace("MASS", quietly = TRUE)) {
  save_plot("ridge-regression", {
    fit <- MASS::lm.ridge(mpg ~ wt + hp + disp + qsec, data = mtcars, lambda = seq(0, 20, length.out = 80))
    graphics::matplot(fit$lambda, t(fit$coef), type = "l", lty = 1, lwd = 2, xlab = "Lambda", ylab = "Standardized coefficient", main = "Ridge regression")
    graphics::abline(h = 0, col = "#d8e0e7")
  })
  add_row("ridge-regression", "Ridge regression", "mtcars", "Are predictors correlated but still useful?", "MASS::lm.ridge(mpg ~ wt + hp + disp + qsec, data = mtcars)", "assets/regression-visuals/ridge-regression.png", "Scaling, collinearity, validation error.", "Lambda shrinkage penalty.")
}

# 13. Mixed-effects regression
if (requireNamespace("nlme", quietly = TRUE)) {
  save_plot("mixed-effects-regression", {
    fit <- nlme::lme(weight ~ Time + Diet, random = ~ 1 | Chick, data = ChickWeight)
    pred <- stats::predict(fit, level = 0)
    graphics::plot(ChickWeight$Time, ChickWeight$weight, xlab = "Time", ylab = "Weight", main = "Mixed-effects regression")
    points_soft(ChickWeight$Time, ChickWeight$weight, cex = 0.7)
    ord <- order(ChickWeight$Time)
    graphics::lines(ChickWeight$Time[ord], pred[ord], col = "#14785a", lwd = 3)
  })
  add_row("mixed-effects-regression", "Mixed-effects regression", "ChickWeight", "Do rows repeat inside subjects, stores, schools, or teams?", "nlme::lme(weight ~ Time + Diet, random = ~ 1 | Chick, data = ChickWeight)", "assets/regression-visuals/mixed-effects-regression.png", "Cluster sizes, random-effect variance, residual dependence.", "Fixed effects, random intercept/slope, group variance.")
}

# 14. Panel fixed-effects regression
save_plot("fixed-effects-regression", {
  fit <- stats::lm(uptake ~ conc + factor(Plant), data = CO2)
  pred <- stats::predict(fit)
  graphics::plot(CO2$conc, CO2$uptake, xlab = "CO2 concentration", ylab = "CO2 uptake", main = "Fixed-effects regression")
  points_soft(CO2$conc, CO2$uptake)
  ord <- order(CO2$conc)
  graphics::lines(CO2$conc[ord], pred[ord], col = "#14785a", lwd = 3)
})
add_row("fixed-effects-regression", "Fixed-effects regression", "CO2", "Do repeated entities need their own baseline level?", "lm(uptake ~ conc + factor(Plant), data = CO2)", "assets/regression-visuals/fixed-effects-regression.png", "Within-entity variation, serial dependence, omitted time effects.", "Entity indicators, within effect.")

# 15. Cox proportional hazards regression
if (requireNamespace("survival", quietly = TRUE)) {
  save_plot("cox-regression", {
    lung <- survival::lung
    fit <- survival::coxph(survival::Surv(time, status) ~ sex + age, data = lung)
    sf <- survival::survfit(fit, newdata = data.frame(sex = c(1, 2), age = mean(lung$age, na.rm = TRUE)))
    graphics::plot(sf, col = c("#1769aa", "#14785a"), lwd = 3, xlab = "Days", ylab = "Survival probability", main = "Cox regression")
    graphics::legend("topright", legend = c("sex = 1", "sex = 2"), col = c("#1769aa", "#14785a"), lwd = 3, bty = "n")
  })
  add_row("cox-regression", "Cox proportional hazards", "survival::lung", "What predicts time until an event with censoring?", "survival::coxph(Surv(time, status) ~ sex + age, data = survival::lung)", "assets/regression-visuals/cox-regression.png", "Censoring, proportional hazards, influential subjects.", "Hazard ratio, baseline hazard.")
}

# 16. Time-series regression
save_plot("time-series-regression", {
  y <- as.numeric(AirPassengers)
  t <- seq_along(y)
  month <- factor(cycle(AirPassengers))
  fit <- stats::lm(log(y) ~ t + month)
  pred <- exp(stats::predict(fit))
  graphics::plot(t, y, type = "l", xlab = "Month index", ylab = "Passengers", main = "Time-series regression", col = "#9a6400", lwd = 2)
  line_main(t, pred)
})
add_row("time-series-regression", "Time-series regression", "AirPassengers", "Does a time-indexed target need trend and seasonality?", "lm(log(AirPassengers) ~ time + month)", "assets/regression-visuals/time-series-regression.png", "Autocorrelation, seasonality, time split, stationarity.", "Trend, seasonal effects, transformed target.")

# 17. Decision tree regression
if (requireNamespace("rpart", quietly = TRUE)) {
  save_plot("tree-regression", {
    fit <- rpart::rpart(mpg ~ wt + hp + disp, data = mtcars, method = "anova", control = rpart::rpart.control(cp = 0.01))
    grid <- data.frame(wt = seq(min(mtcars$wt), max(mtcars$wt), length.out = 160), hp = mean(mtcars$hp), disp = mean(mtcars$disp))
    pred <- stats::predict(fit, newdata = grid)
    graphics::plot(mtcars$wt, mtcars$mpg, xlab = "Weight", ylab = "Miles per gallon", main = "Decision tree regression")
    points_soft(mtcars$wt, mtcars$mpg)
    line_main(grid$wt, pred, type = "s")
  })
  add_row("tree-regression", "Decision tree regression", "mtcars", "Are simple nonlinear rules useful for prediction?", "rpart::rpart(mpg ~ wt + hp + disp, data = mtcars, method = 'anova')", "assets/regression-visuals/tree-regression.png", "Depth, leaf size, pruning, overfit gap.", "Splits, complexity parameter, terminal-node mean.")
}

# 18. Multinomial logistic regression
if (requireNamespace("nnet", quietly = TRUE)) {
  save_plot("multinomial-regression", {
    fit <- nnet::multinom(Species ~ Sepal.Length + Sepal.Width, data = iris, trace = FALSE)
    pred <- stats::predict(fit, type = "class")
    graphics::plot(iris$Sepal.Length, iris$Sepal.Width, xlab = "Sepal length", ylab = "Sepal width", main = "Multinomial logistic regression", col = as.numeric(pred), pch = 19)
    graphics::legend("topright", legend = levels(iris$Species), col = seq_along(levels(iris$Species)), pch = 19, bty = "n")
  })
  add_row("multinomial-regression", "Multinomial logistic regression", "iris", "What predicts a categorical target with more than two unordered classes?", "nnet::multinom(Species ~ Sepal.Length + Sepal.Width, data = iris)", "assets/regression-visuals/multinomial-regression.png", "Class balance, separation, confusion matrix.", "Class logits, reference class, predicted class probability.")
}

# 19. Ordinal logistic regression
if (requireNamespace("MASS", quietly = TRUE) && exists("housing", envir = asNamespace("MASS"))) {
  save_plot("ordinal-regression", {
    data("housing", package = "MASS")
    fit <- MASS::polr(Sat ~ Infl + Type + Cont, weights = Freq, data = MASS::housing, Hess = TRUE)
    probs <- stats::predict(fit, newdata = MASS::housing, type = "probs")
    mean_probs <- colMeans(probs)
    graphics::barplot(mean_probs, col = c("#dbeaf6", "#e5f3ed", "#fff3d8"), border = "#17212b", ylab = "Mean predicted probability", main = "Ordinal logistic regression")
  })
  add_row("ordinal-regression", "Ordinal logistic regression", "MASS::housing", "What predicts ordered categories like low, medium, high?", "MASS::polr(Sat ~ Infl + Type + Cont, weights = Freq, data = MASS::housing)", "assets/regression-visuals/ordinal-regression.png", "Proportional odds, sparse levels, threshold fit.", "Cutpoints, log-odds, ordered class probabilities.")
}

guide_df <- do.call(rbind, guide)
utils::write.csv(guide_df, file.path("statistical-analytics", "data", "visual_regression_guide.csv"), row.names = FALSE)
message("Wrote ", nrow(guide_df), " visual regression guide rows.")
