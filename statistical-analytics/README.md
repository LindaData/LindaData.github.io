# Statistical Analytics Hub

This folder powers the Linda Data Statistical Workbench at `/statistical-analytics/`.

The workbench is designed as a guided, copy-first analytics product: users start with a question, choose the right statistical path, copy a starter, run diagnostics, and use the exhaustive catalogs only when they need deeper reference material. It uses R built-in datasets as the default teaching source and separates no-key public APIs from key-required sources.

## Folder Map

- `index.html`: static GitHub Pages hub page.
- `samples.html`: copy-paste sample page for R, Python, and SQL.
- `model-tuning.html`: copy-paste model tuning and selection guide.
- `assets/`: shared workbench CSS/JS and generated visuals.
- `data/`: catalogs, checklists, exported R built-in datasets, and generated examples.
- `scripts/`: reusable R and Python starter scripts.
- `sql/`: DuckDB-style SQL examples for profiling and feature preparation.

## Suggested Team Workflow

1. Start with `data/statistical_techniques_catalog.csv` to choose a statistical technique.
2. Use `samples.html`, `scripts/copy_paste_r_samples.R`, `scripts/copy_paste_python_samples.py`, and `sql/copy_paste_sql_samples.sql` when someone needs a copy-paste starting point.
3. Use `data/sample_recipe_index.csv` to map common questions to the matching sample file.
4. Use `model-tuning.html`, `data/model_tuning_catalog.csv`, `scripts/model_tuning_r_templates.R`, `scripts/model_tuning_python_templates.py`, and `sql/model_tuning_sql_templates.sql` when the project needs stepwise selection, decision trees, XGBoost, regularization, validation, calibration, or model cards.
5. Use `data/regression_catalog.csv` when the project is specifically model-family selection.
6. Use `data/diagnostics_checklist.csv` during pre-model review.
7. Use `data/llm_statistical_analysis_checklist.csv` when the project evaluates LLM outputs, prompts, factuality, calibration, or drift.
8. Use `scripts/export_r_builtin_datasets.R` in RStudio to refresh sample CSVs.
9. Use `scripts/statistical_methods_cookbook.R`, `scripts/statistical_methods_cookbook.py`, and `sql/statistical_methods_cookbook.sql` as the cross-language technique codebooks.
10. Use `scripts/diagnostics_helpers.R` inside project notebooks and Quarto reports.
11. Use `scripts/download_open_data.R` or `scripts/download_open_data.py` when a lesson needs current public API data.
12. Use `sql/analytics_examples.sql` when building a DuckDB or database-backed workflow.

## GitHub Review Loop

- Public page: `https://lindadata.github.io/statistical-analytics/index.html`
- Source folder: `https://github.com/lindadata/lindadata.github.io/tree/master/statistical-analytics`
- Review pattern: edit the HTML, CSV, R, Python, and SQL files locally; run the checks below; commit and push to `master` for GitHub Pages publication.
- Pull before new work when possible, and keep HVAC-related work ahead of analytics polish if both appear in the same checkout.

## Local Preview

If Ruby/Jekyll is not installed, preview the static hub with R:

```r
Rscript statistical-analytics/scripts/local_static_server.R 8123
```

Then open `http://127.0.0.1:8123/statistical-analytics/index.html`, `http://127.0.0.1:8123/statistical-analytics/samples.html`, or `http://127.0.0.1:8123/statistical-analytics/model-tuning.html` from the repository root.

No API keys, credentials, raw private data, or local databases should be committed to this public site.
