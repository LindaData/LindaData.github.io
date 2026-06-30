(function () {
  const recipes = {
    profile: {
      title: "Profile a dataset",
      meta: "Use this before every analysis.",
      tags: ["R", "Python", "SQL", "Diagnostics"],
      checks: "Missingness, data grain, outliers, duplicate rows, target availability.",
      code: `# R
DATA <- read.csv("your_data.csv")
summary(DATA)
colMeans(is.na(DATA))

# SQL
SELECT COUNT(*) AS rows, COUNT(*) - COUNT(target) AS missing_target
FROM data_table;`,
      links: [
        ["R samples", "scripts/copy_paste_r_samples.R"],
        ["SQL samples", "sql/copy_paste_sql_samples.sql"]
      ]
    },
    continuous: {
      title: "Explain or predict a continuous target",
      meta: "Start with OLS, then decide whether tuning is justified.",
      tags: ["OLS", "Ridge", "Lasso", "Trees", "XGBoost"],
      checks: "Linearity, collinearity, heteroskedasticity, leverage, validation split.",
      code: `# R
fit <- lm(TARGET ~ x1 + x2 + x3, data = DATA)
summary(fit)
run_lm_diagnostics(fit, DATA)

# Python
fit = smf.ols("TARGET ~ x1 + x2 + x3", data=DATA).fit()
print(fit.summary())`,
      links: [
        ["Copy samples", "samples.html"],
        ["Tuning guide", "model-tuning.html"]
      ]
    },
    probability: {
      title: "Predict a probability or yes/no outcome",
      meta: "Use logistic regression before tuned classifiers.",
      tags: ["Logistic", "Calibration", "Thresholds", "Class weights"],
      checks: "Class balance, separation, ROC/PR curves, Brier score, threshold cost.",
      code: `# R
fit <- glm(target_binary ~ x1 + x2 + x3, data = DATA, family = binomial())
DATA$predicted_probability <- predict(fit, type = "response")

# Python
model = LogisticRegressionCV(scoring="roc_auc", class_weight="balanced")
model.fit(X_train, y_train)`,
      links: [
        ["Copy samples", "samples.html"],
        ["Tuning guide", "model-tuning.html"]
      ]
    },
    count: {
      title: "Model counts or rates",
      meta: "Poisson first, negative binomial when variance is too large.",
      tags: ["Poisson", "Negative binomial", "Offsets", "Rates"],
      checks: "Overdispersion, zero inflation, exposure/offset, repeated entities.",
      code: `# R
fit <- glm(count_target ~ x1 + x2 + offset(log(exposure)),
           data = DATA,
           family = poisson())
dispersion <- sum(residuals(fit, type = "pearson")^2) / fit$df.residual`,
      links: [
        ["Copy samples", "samples.html"],
        ["Regression catalog", "data/regression_catalog.csv"]
      ]
    },
    time: {
      title: "Forecast or model time-indexed data",
      meta: "Use time-aware validation. Do not random split future prediction.",
      tags: ["Time split", "Lags", "Seasonality", "ARIMA errors"],
      checks: "Temporal leakage, stationarity, autocorrelation, horizon design.",
      code: `# Python
from sklearn.model_selection import TimeSeriesSplit
cv = TimeSeriesSplit(n_splits=5)

# SQL
lag(target) OVER (ORDER BY time_col) AS lag_target`,
      links: [
        ["Copy samples", "samples.html"],
        ["Data sources", "data/open_data_sources.csv"]
      ]
    },
    llm: {
      title: "Evaluate prompts, models, or LLM outputs",
      meta: "Treat model outputs as experimental data.",
      tags: ["Prompt tests", "Rubrics", "Factuality", "Calibration"],
      checks: "Paired item design, rater agreement, factuality, cost, latency, drift.",
      code: `# R
summary(lm(score ~ prompt_id, data = LLM_DATA))
summary(glm(factual ~ prompt_id + confidence,
            data = LLM_DATA,
            family = binomial()))`,
      links: [
        ["LLM checklist", "data/llm_statistical_analysis_checklist.csv"],
        ["LLM R template", "scripts/llm_statistical_analysis.R"]
      ]
    }
  };

  function qs(selector, root) {
    return (root || document).querySelector(selector);
  }

  function qsa(selector, root) {
    return Array.prototype.slice.call((root || document).querySelectorAll(selector));
  }

  function setRecipe(key) {
    const recipe = recipes[key];
    const panel = qs("[data-recipe-panel]");
    if (!recipe || !panel) return;

    panel.innerHTML = `
      <p class="eyebrow">Recommended path</p>
      <h3>${recipe.title}</h3>
      <p class="result-meta">${recipe.meta}</p>
      <div class="pill-row">${recipe.tags.map(tag => `<span class="pill">${tag}</span>`).join("")}</div>
      <p><strong>Check before presenting:</strong> ${recipe.checks}</p>
      <pre><code>${recipe.code.replace(/[&<>]/g, ch => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;" }[ch]))}</code></pre>
      <div class="action-row">${recipe.links.map(link => `<a class="button secondary" href="${link[1]}">${link[0]}</a>`).join("")}</div>
    `;
    wireCopyButtons(panel);

    qsa("[data-recipe]").forEach(button => {
      button.classList.toggle("is-active", button.getAttribute("data-recipe") === key);
    });
  }

  function wireRecipeButtons() {
    qsa("[data-recipe]").forEach(button => {
      button.addEventListener("click", () => setRecipe(button.getAttribute("data-recipe")));
    });
    const first = qs("[data-recipe]");
    if (first) setRecipe(first.getAttribute("data-recipe"));
  }

  function wireTabs() {
    qsa("[data-tab-target]").forEach(button => {
      button.addEventListener("click", () => {
        const group = button.getAttribute("data-tab-group");
        const target = button.getAttribute("data-tab-target");
        qsa(`[data-tab-group="${group}"]`).forEach(item => {
          item.setAttribute("aria-pressed", item === button ? "true" : "false");
        });
        qsa(`[data-tab-panel-group="${group}"]`).forEach(panel => {
          panel.hidden = panel.id !== target;
        });
      });
    });
  }

  function wireFilters() {
    qsa("[data-filter]").forEach(button => {
      button.addEventListener("click", () => {
        const value = button.getAttribute("data-filter");
        qsa("[data-filter]").forEach(item => item.setAttribute("aria-pressed", item === button ? "true" : "false"));
        qsa("[data-sample-kind]").forEach(card => {
          const kind = card.getAttribute("data-sample-kind");
          card.classList.toggle("is-hidden", value !== "all" && kind !== value);
        });
      });
    });
  }

  function activateTabForPanel(panel) {
    if (!panel || !panel.hasAttribute("data-tab-panel-group")) return;
    const group = panel.getAttribute("data-tab-panel-group");
    qsa(`[data-tab-group="${group}"]`).forEach(button => {
      const isActive = button.getAttribute("data-tab-target") === panel.id;
      button.setAttribute("aria-pressed", isActive ? "true" : "false");
    });
    qsa(`[data-tab-panel-group="${group}"]`).forEach(item => {
      item.hidden = item !== panel;
    });
  }

  function slugify(text) {
    return text.toLowerCase()
      .replace(/^\d+\s*/, "")
      .replace(/[^a-z0-9]+/g, "-")
      .replace(/^-|-$/g, "");
  }

  function wireHashTargets() {
    const openHash = () => {
      if (!window.location.hash) return;
      const id = window.location.hash.slice(1);
      const target = document.getElementById(id);
      if (!target) return;
      const tabPanel = target.matches("[data-tab-panel-group]")
        ? target
        : target.closest("[data-tab-panel-group]");
      activateTabForPanel(tabPanel);
      target.scrollIntoView({ block: "start" });
    };

    window.addEventListener("hashchange", openHash);
    openHash();
  }

  function wireVisualCards() {
    const routeMap = {
      "simple-linear-regression": [["Copy R baseline", "samples.html#ols-diagnostics"], ["Tune candidates", "model-tuning.html#r-tuning"], ["Catalog", "data/regression_catalog.csv"]],
      "multiple-linear-regression": [["Copy R baseline", "samples.html#ols-diagnostics"], ["Tune candidates", "model-tuning.html#r-tuning"], ["Catalog", "data/regression_catalog.csv"]],
      "polynomial-regression": [["Copy R baseline", "samples.html#ols-diagnostics"], ["Tune candidates", "model-tuning.html#r-tuning"], ["Catalog", "data/regression_catalog.csv"]],
      "spline-regression": [["Copy R baseline", "samples.html#ols-diagnostics"], ["Tune candidates", "model-tuning.html#r-tuning"], ["Catalog", "data/regression_catalog.csv"]],
      "interaction-regression": [["Copy R baseline", "samples.html#ols-diagnostics"], ["Diagnostics", "data/diagnostics_checklist.csv"], ["Catalog", "data/regression_catalog.csv"]],
      "logistic-regression": [["Copy logistic template", "samples.html#logistic-regression"], ["Tune classifiers", "model-tuning.html#python-tuning"], ["Catalog", "data/regression_catalog.csv"]],
      "probit-regression": [["Copy logistic template", "samples.html#logistic-regression"], ["Diagnostics", "data/diagnostics_checklist.csv"], ["Catalog", "data/regression_catalog.csv"]],
      "poisson-regression": [["Prepare feature table", "samples.html#model-ready-feature-view"], ["Full R cookbook", "scripts/statistical_methods_cookbook.R"], ["Catalog", "data/regression_catalog.csv"]],
      "negative-binomial-regression": [["Prepare feature table", "samples.html#model-ready-feature-view"], ["Full R cookbook", "scripts/statistical_methods_cookbook.R"], ["Catalog", "data/regression_catalog.csv"]],
      "gamma-regression": [["Copy R baseline", "samples.html#ols-diagnostics"], ["Diagnostics", "data/diagnostics_checklist.csv"], ["Catalog", "data/regression_catalog.csv"]],
      "robust-regression": [["Copy R baseline", "samples.html#ols-diagnostics"], ["Diagnostics", "data/diagnostics_checklist.csv"], ["Catalog", "data/regression_catalog.csv"]],
      "ridge-regression": [["Tune regularization", "model-tuning.html#r-tuning"], ["Download R tuning", "scripts/model_tuning_r_templates.R"], ["Catalog", "data/regression_catalog.csv"]],
      "mixed-effects-regression": [["Full R cookbook", "scripts/statistical_methods_cookbook.R"], ["Diagnostics", "data/diagnostics_checklist.csv"], ["Catalog", "data/regression_catalog.csv"]],
      "fixed-effects-regression": [["Full R cookbook", "scripts/statistical_methods_cookbook.R"], ["Diagnostics", "data/diagnostics_checklist.csv"], ["Catalog", "data/regression_catalog.csv"]],
      "cox-proportional-hazards": [["Full R cookbook", "scripts/statistical_methods_cookbook.R"], ["Diagnostics", "data/diagnostics_checklist.csv"], ["Catalog", "data/regression_catalog.csv"]],
      "time-series-regression": [["Copy samples", "samples.html#template-cards"], ["Validation design", "model-tuning.html#validation-design"], ["Catalog", "data/regression_catalog.csv"]],
      "decision-tree-regression": [["Tune trees", "model-tuning.html#python-tuning"], ["Download R tuning", "scripts/model_tuning_r_templates.R"], ["Catalog", "data/model_tuning_catalog.csv"]],
      "multinomial-logistic-regression": [["Copy logistic template", "samples.html#logistic-regression"], ["Tune classifiers", "model-tuning.html#python-tuning"], ["Catalog", "data/regression_catalog.csv"]]
    };

    qsa(".visual-card").forEach(card => {
      const heading = qs("h3", card);
      const facts = qs(".visual-facts", card);
      if (!heading || !facts || qs(".visual-actions", facts)) return;
      const key = slugify(heading.textContent);
      if (!card.id) card.id = key;
      const links = routeMap[key];
      if (!links) return;
      const row = document.createElement("div");
      row.className = "action-row visual-actions";
      row.innerHTML = links.map(([label, href]) => `<a class="button secondary small" href="${href}">${label}</a>`).join("");
      facts.appendChild(row);
    });
  }

  function wireCopyButtons(root) {
    qsa("pre", root).forEach((pre, index) => {
      if (pre.parentElement && pre.parentElement.classList.contains("code-shell")) return;
      const wrapper = document.createElement("div");
      wrapper.className = "code-shell";
      pre.parentNode.insertBefore(wrapper, pre);
      wrapper.appendChild(pre);

      const button = document.createElement("button");
      button.className = "copy-button";
      button.type = "button";
      button.textContent = "Copy";
      button.setAttribute("aria-label", "Copy code block " + (index + 1));
      wrapper.insertBefore(button, pre);

      button.addEventListener("click", async () => {
        try {
          await navigator.clipboard.writeText(pre.textContent);
          button.textContent = "Copied";
          window.setTimeout(() => { button.textContent = "Copy"; }, 1400);
        } catch (error) {
          button.textContent = "Select";
          window.setTimeout(() => { button.textContent = "Copy"; }, 1400);
        }
      });
    });
  }

  document.addEventListener("DOMContentLoaded", () => {
    wireRecipeButtons();
    wireTabs();
    wireFilters();
    wireVisualCards();
    wireCopyButtons(document);
    wireHashTargets();
  });
})();
