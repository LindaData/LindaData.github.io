# Statistical Analytics Hub

This folder powers the Linda Data Statistical Analytics Hub at `/statistical-analytics/`.

The hub is designed as an educational one-stop shop for statistical techniques, regression modeling, diagnostics, LLM evaluation, and starter project assets. It uses R built-in datasets as the default teaching source and separates no-key public APIs from key-required sources.

## Folder Map

- `index.html`: static GitHub Pages hub page.
- `assets/`: generated visuals used by the hub.
- `data/`: catalogs, checklists, exported R built-in datasets, and generated examples.
- `scripts/`: reusable R and Python starter scripts.
- `sql/`: DuckDB-style SQL examples for profiling and feature preparation.

## Suggested Team Workflow

1. Start with `data/statistical_techniques_catalog.csv` to choose a statistical technique.
2. Use `data/regression_catalog.csv` when the project is specifically model-family selection.
3. Use `data/diagnostics_checklist.csv` during pre-model review.
4. Use `data/llm_statistical_analysis_checklist.csv` when the project evaluates LLM outputs, prompts, factuality, calibration, or drift.
5. Use `scripts/export_r_builtin_datasets.R` in RStudio to refresh sample CSVs.
6. Use `scripts/statistical_methods_cookbook.R`, `scripts/statistical_methods_cookbook.py`, and `sql/statistical_methods_cookbook.sql` as the cross-language technique codebooks.
7. Use `scripts/diagnostics_helpers.R` inside project notebooks and Quarto reports.
8. Use `scripts/download_open_data.R` or `scripts/download_open_data.py` when a lesson needs current public API data.
9. Use `sql/analytics_examples.sql` when building a DuckDB or database-backed workflow.

## Local Preview

If Ruby/Jekyll is not installed, preview the static hub with R:

```r
Rscript statistical-analytics/scripts/local_static_server.R 8123
```

Then open `http://127.0.0.1:8123/statistical-analytics/` from the repository root.

No API keys, credentials, raw private data, or local databases should be committed to this public site.
