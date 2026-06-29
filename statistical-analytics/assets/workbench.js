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
    wireCopyButtons(document);
  });
})();
