#!/usr/bin/env Rscript

# Starter public-data downloader for analytics projects.
# No-key sources are attempted first. Key-required sources are documented as placeholders.
#
# Run from repository root:
# Rscript statistical-analytics/scripts/download_open_data.R

args <- commandArgs(trailingOnly = TRUE)
out_dir <- if (length(args) >= 1) args[[1]] else file.path("statistical-analytics", "data", "open-api")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

download_text <- function(url, file_name) {
  destination <- file.path(out_dir, file_name)
  utils::download.file(url, destination, quiet = TRUE, mode = "wb")
  data.frame(source_url = url, file = destination, stringsAsFactors = FALSE)
}

source_log <- list()

# World Bank Indicators API: public JSON.
world_bank_url <- "https://api.worldbank.org/v2/country/USA/indicator/NY.GDP.PCAP.CD?format=json&per_page=100"
source_log[["world_bank_gdp_per_capita"]] <- download_text(world_bank_url, "world_bank_usa_gdp_per_capita.json")

# Open-Meteo: Charlotte, NC daily weather forecast. JSON is used because base R has no JSON parser.
open_meteo_url <- "https://api.open-meteo.com/v1/forecast?latitude=35.2271&longitude=-80.8431&daily=temperature_2m_max,temperature_2m_min,precipitation_sum&timezone=America%2FNew_York"
source_log[["open_meteo_charlotte_daily"]] <- download_text(open_meteo_url, "open_meteo_charlotte_daily.json")

# BLS Public Data API: unemployment rate series. Smaller public calls can be made without a key.
bls_url <- "https://api.bls.gov/publicAPI/v2/timeseries/data/LNS14000000?startyear=2020&endyear=2026"
source_log[["bls_unemployment_rate"]] <- download_text(bls_url, "bls_unemployment_rate.json")

# Optional key-based examples. Keep keys in environment variables, not in this repository.
census_key <- Sys.getenv("CENSUS_API_KEY")
if (nzchar(census_key)) {
  census_url <- paste0(
    "https://api.census.gov/data/2023/acs/acs5/profile?get=NAME,DP05_0001E&for=state:*&key=",
    utils::URLencode(census_key, reserved = TRUE)
  )
  source_log[["census_acs_state_population"]] <- download_text(census_url, "census_acs_state_population.json")
}

fred_key <- Sys.getenv("FRED_API_KEY")
if (nzchar(fred_key)) {
  fred_url <- paste0(
    "https://api.stlouisfed.org/fred/series/observations?series_id=UNRATE&api_key=",
    utils::URLencode(fred_key, reserved = TRUE),
    "&file_type=json"
  )
  source_log[["fred_unrate"]] <- download_text(fred_url, "fred_unrate.json")
}

noaa_token <- Sys.getenv("NOAA_TOKEN")
if (nzchar(noaa_token)) {
  message("NOAA_TOKEN is present. NOAA CDO calls require adding token headers; use httr2 or curl for production pulls.")
}

log_df <- do.call(rbind, source_log)
utils::write.csv(log_df, file.path(out_dir, "source_log.csv"), row.names = FALSE)
message("Downloaded public API starter files to ", normalizePath(out_dir, winslash = "/"))
