# Reusable base R diagnostics helpers for Linda Data teaching projects.
# These functions intentionally avoid non-base dependencies so they work in a clean R/RStudio setup.

profile_data <- function(data) {
  stopifnot(is.data.frame(data))
  data.frame(
    variable = names(data),
    class = vapply(data, function(x) paste(class(x), collapse = "/"), character(1)),
    rows = nrow(data),
    missing = vapply(data, function(x) sum(is.na(x)), integer(1)),
    missing_rate = vapply(data, function(x) mean(is.na(x)), numeric(1)),
    unique_values = vapply(data, function(x) length(unique(x)), integer(1)),
    stringsAsFactors = FALSE
  )
}

numeric_profile <- function(data) {
  stopifnot(is.data.frame(data))
  nums <- data[vapply(data, is.numeric, logical(1))]
  if (!length(nums)) {
    return(data.frame())
  }
  do.call(rbind, lapply(names(nums), function(name) {
    x <- nums[[name]]
    data.frame(
      variable = name,
      mean = mean(x, na.rm = TRUE),
      sd = stats::sd(x, na.rm = TRUE),
      min = min(x, na.rm = TRUE),
      q25 = stats::quantile(x, 0.25, na.rm = TRUE, names = FALSE),
      median = stats::median(x, na.rm = TRUE),
      q75 = stats::quantile(x, 0.75, na.rm = TRUE, names = FALSE),
      max = max(x, na.rm = TRUE),
      stringsAsFactors = FALSE
    )
  }))
}

vif_base <- function(model) {
  mm <- stats::model.matrix(model)
  mm <- mm[, colnames(mm) != "(Intercept)", drop = FALSE]
  if (ncol(mm) == 0) {
    return(data.frame(term = character(), vif = numeric()))
  }
  out <- lapply(seq_len(ncol(mm)), function(j) {
    target <- mm[, j]
    others <- mm[, -j, drop = FALSE]
    if (ncol(others) == 0 || stats::var(target) == 0) {
      r2 <- 0
    } else {
      r2 <- summary(stats::lm(target ~ others))$r.squared
    }
    data.frame(term = colnames(mm)[[j]], vif = 1 / (1 - r2))
  })
  do.call(rbind, out)
}

condition_number <- function(model) {
  mm <- stats::model.matrix(model)
  data.frame(condition_number = kappa(mm, exact = TRUE))
}

breusch_pagan_screen <- function(model) {
  fitted_values <- stats::fitted(model)
  squared_resid <- stats::residuals(model)^2
  aux <- stats::lm(squared_resid ~ fitted_values)
  statistic <- length(squared_resid) * summary(aux)$r.squared
  data.frame(
    test = "Breusch-Pagan style screen",
    statistic = statistic,
    df = 1,
    p_value = stats::pchisq(statistic, df = 1, lower.tail = FALSE),
    stringsAsFactors = FALSE
  )
}

influence_summary <- function(model) {
  data.frame(
    row_id = seq_along(stats::residuals(model)),
    fitted = stats::fitted(model),
    residual = stats::residuals(model),
    standardized_residual = stats::rstandard(model),
    leverage = stats::hatvalues(model),
    cooks_distance = stats::cooks.distance(model),
    stringsAsFactors = FALSE
  )
}

run_lm_diagnostics <- function(model, data = NULL) {
  output <- list(
    model_summary = summary(model),
    vif = vif_base(model),
    condition_number = condition_number(model),
    heteroskedasticity_screen = breusch_pagan_screen(model),
    influence = influence_summary(model)
  )
  if (!is.null(data)) {
    output$data_profile <- profile_data(data)
    output$numeric_profile <- numeric_profile(data)
  }
  output
}

plot_lm_diagnostics <- function(model) {
  old_par <- par(no.readonly = TRUE)
  on.exit(par(old_par), add = TRUE)
  par(mfrow = c(2, 2))
  plot(model)
}

# Example:
# data(mtcars)
# fit <- lm(mpg ~ wt + hp + disp, data = mtcars)
# diagnostics <- run_lm_diagnostics(fit, mtcars)
# diagnostics$vif
