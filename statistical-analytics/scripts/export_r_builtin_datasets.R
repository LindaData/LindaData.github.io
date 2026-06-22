#!/usr/bin/env Rscript

# Exports selected R built-in datasets and lightweight diagnostics examples.
# Run from the repository root:
# Rscript statistical-analytics/scripts/export_r_builtin_datasets.R

args <- commandArgs(trailingOnly = TRUE)
hub_dir <- if (length(args) >= 1) args[[1]] else file.path("statistical-analytics")
data_dir <- file.path(hub_dir, "data")
builtin_dir <- file.path(data_dir, "r-builtins")
asset_dir <- file.path(hub_dir, "assets")

dir.create(data_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(builtin_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(asset_dir, recursive = TRUE, showWarnings = FALSE)

dataset_specs <- data.frame(
  name = c(
    "mtcars", "cars", "iris", "airquality", "ChickWeight", "ToothGrowth",
    "PlantGrowth", "CO2", "Orange", "warpbreaks", "infert", "Titanic",
    "USArrests", "state.x77", "longley", "LifeCycleSavings", "Seatbelts",
    "sleep", "esoph", "VADeaths", "Puromycin", "AirPassengers", "Nile",
    "LakeHuron", "pressure", "stackloss"
  ),
  package = "datasets",
  model_family = c(
    "linear", "linear", "classification", "linear", "mixed effects", "ANOVA/GLM",
    "ANOVA", "mixed effects", "nonlinear/mixed", "count", "logistic", "classification",
    "dimension reduction", "panel/cross-section", "collinearity demo", "linear",
    "time series", "paired test", "count/logistic", "table/count", "nonlinear",
    "time series", "time series", "time series", "nonlinear", "robust regression"
  ),
  suggested_target = c(
    "mpg", "dist", "Species", "Ozone", "weight", "len", "weight",
    "uptake", "circumference", "breaks", "case", "Survived",
    "Murder", "Life Exp", "Employed", "sr", "DriversKilled",
    "extra", "ncases", "Freq", "rate", "passengers", "flow",
    "level", "pressure", "stack.loss"
  ),
  notes = c(
    "Multiple linear regression and VIF demonstration.",
    "Simple linear regression.",
    "Multiclass classification and multivariate analysis.",
    "Missingness, nonlinear effects, and weather regression.",
    "Repeated-measures growth data.",
    "Two-factor design and interactions.",
    "One-way ANOVA and treatment comparisons.",
    "Grouped regression with repeated plants.",
    "Growth curve and nonlinear modeling.",
    "Count model with factors.",
    "Binary outcome and matched case-control context.",
    "Contingency table and classification from counts.",
    "PCA and multivariate examples.",
    "State-level indicators from matrix data.",
    "Classic multicollinearity dataset.",
    "Savings regression example.",
    "Time-series intervention and counts.",
    "Paired comparison example.",
    "Grouped count data.",
    "Table count data.",
    "Nonlinear enzyme kinetics.",
    "Seasonal time series.",
    "Annual flow time series.",
    "Annual lake level time series.",
    "Nonlinear relationship.",
    "Outlier and robust regression example."
  ),
  stringsAsFactors = FALSE
)

safe_name <- function(x) {
  gsub("[^A-Za-z0-9_]+", "_", x)
}

as_export_frame <- function(object_name, object) {
  if (inherits(object, "ts")) {
    values <- as.data.frame(unclass(object), stringsAsFactors = FALSE)
    out <- data.frame(
      index = seq_len(nrow(values)),
      time = as.numeric(time(object)),
      values,
      check.names = FALSE
    )
    if (ncol(values) == 1) {
      names(out)[3] <- object_name
    }
  } else if (inherits(object, "table")) {
    out <- as.data.frame(object)
  } else if (is.matrix(object)) {
    out <- as.data.frame(object, stringsAsFactors = FALSE)
    row_names <- rownames(object)
    if (is.null(row_names)) {
      row_names <- seq_len(nrow(out))
    }
    out$row_name <- row_names
    out <- out[, c("row_name", setdiff(names(out), "row_name"))]
  } else if (is.data.frame(object)) {
    out <- object
  } else {
    out <- as.data.frame(object, stringsAsFactors = FALSE)
  }

  for (col in names(out)) {
    if (is.factor(out[[col]])) {
      out[[col]] <- as.character(out[[col]])
    }
  }
  out
}

manifest <- dataset_specs
manifest$rows <- NA_integer_
manifest$columns <- NA_integer_
manifest$file <- NA_character_

for (i in seq_len(nrow(dataset_specs))) {
  spec <- dataset_specs[i, ]
  env <- new.env(parent = emptyenv())
  suppressWarnings(utils::data(list = spec$name, package = spec$package, envir = env))
  if (exists(spec$name, envir = env, inherits = FALSE)) {
    object <- get(spec$name, envir = env)
  } else if (exists(spec$name, envir = asNamespace(spec$package), inherits = FALSE)) {
    object <- get(spec$name, envir = asNamespace(spec$package))
  } else if (exists(spec$name, inherits = TRUE)) {
    object <- get(spec$name, inherits = TRUE)
  } else {
    stop("Dataset not found: ", spec$name, call. = FALSE)
  }
  out <- as_export_frame(spec$name, object)
  file_name <- paste0(safe_name(spec$name), ".csv")
  rel_file <- file.path("r-builtins", file_name)
  utils::write.csv(out, file.path(data_dir, rel_file), row.names = FALSE, na = "")
  manifest$rows[[i]] <- nrow(out)
  manifest$columns[[i]] <- ncol(out)
  manifest$file[[i]] <- rel_file
}

utils::write.csv(manifest, file.path(data_dir, "r_builtin_manifest.csv"), row.names = FALSE, na = "")

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

bp_screen <- function(model) {
  fitted_values <- stats::fitted(model)
  squared_resid <- stats::residuals(model)^2
  aux <- stats::lm(squared_resid ~ fitted_values)
  n <- length(squared_resid)
  statistic <- n * summary(aux)$r.squared
  p_value <- stats::pchisq(statistic, df = 1, lower.tail = FALSE)
  data.frame(test = "Breusch-Pagan style screen", statistic = statistic, df = 1, p_value = p_value)
}

fit <- stats::lm(mpg ~ wt + hp + disp, data = mtcars)
diagnostics <- data.frame(
  row_name = rownames(mtcars),
  observed_mpg = mtcars$mpg,
  fitted_mpg = stats::fitted(fit),
  residual = stats::residuals(fit),
  leverage = stats::hatvalues(fit),
  cooks_distance = stats::cooks.distance(fit),
  stringsAsFactors = FALSE
)

utils::write.csv(diagnostics, file.path(data_dir, "r_model_diagnostics_example.csv"), row.names = FALSE)
utils::write.csv(vif_base(fit), file.path(data_dir, "r_vif_example.csv"), row.names = FALSE)
utils::write.csv(bp_screen(fit), file.path(data_dir, "r_heteroskedasticity_screen_example.csv"), row.names = FALSE)

family_counts <- sort(table(dataset_specs$model_family), decreasing = TRUE)
png(
  filename = file.path(asset_dir, "model-family-map.png"),
  width = 1100,
  height = 760,
  res = 130
)
op <- par(no.readonly = TRUE)
par(mar = c(5, 12, 5, 2), bg = "#ffffff")
bar_cols <- rep(c("#1769aa", "#16815d", "#a76500", "#b33a3a", "#20304a"), length.out = length(family_counts))
barplot(
  rev(family_counts),
  horiz = TRUE,
  las = 1,
  col = bar_cols,
  border = NA,
  xlab = "R built-in datasets mapped",
  main = "Teaching Data Coverage by Model Family"
)
grid(nx = NULL, ny = NA, col = "#d9e0e8")
par(op)
dev.off()

message("Exported R built-in datasets and diagnostics examples to ", normalizePath(data_dir, winslash = "/"))
