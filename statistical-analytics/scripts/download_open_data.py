#!/usr/bin/env python3
"""Download no-key public API starter datasets using only the Python standard library.

Run from the repository root:
    python statistical-analytics/scripts/download_open_data.py
"""

from __future__ import annotations

import csv
import json
import os
import urllib.parse
import urllib.request
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
OUT_DIR = ROOT / "data" / "open-api"
OUT_DIR.mkdir(parents=True, exist_ok=True)


def fetch_json(url: str) -> object:
    request = urllib.request.Request(url, headers={"User-Agent": "LindaData-Analytics-Hub/1.0"})
    with urllib.request.urlopen(request, timeout=30) as response:
        return json.loads(response.read().decode("utf-8"))


def write_json(name: str, payload: object) -> Path:
    path = OUT_DIR / f"{name}.json"
    path.write_text(json.dumps(payload, indent=2), encoding="utf-8")
    return path


def write_csv(name: str, rows: list[dict[str, object]]) -> Path:
    path = OUT_DIR / f"{name}.csv"
    if not rows:
        path.write_text("", encoding="utf-8")
        return path

    fieldnames = sorted({field for row in rows for field in row.keys()})
    with path.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)
    return path


def download_world_bank() -> tuple[Path, Path]:
    url = "https://api.worldbank.org/v2/country/USA/indicator/NY.GDP.PCAP.CD?format=json&per_page=100"
    payload = fetch_json(url)
    raw_path = write_json("world_bank_usa_gdp_per_capita", payload)
    rows = []
    if isinstance(payload, list) and len(payload) > 1:
        for row in payload[1]:
            rows.append(
                {
                    "country": row.get("country", {}).get("value"),
                    "countryiso3code": row.get("countryiso3code"),
                    "date": row.get("date"),
                    "indicator": row.get("indicator", {}).get("value"),
                    "value": row.get("value"),
                }
            )
    csv_path = write_csv("world_bank_usa_gdp_per_capita", rows)
    return raw_path, csv_path


def download_open_meteo() -> tuple[Path, Path]:
    params = {
        "latitude": "35.2271",
        "longitude": "-80.8431",
        "daily": "temperature_2m_max,temperature_2m_min,precipitation_sum",
        "timezone": "America/New_York",
    }
    url = "https://api.open-meteo.com/v1/forecast?" + urllib.parse.urlencode(params)
    payload = fetch_json(url)
    raw_path = write_json("open_meteo_charlotte_daily", payload)
    daily = payload.get("daily", {}) if isinstance(payload, dict) else {}
    rows = []
    for i, day in enumerate(daily.get("time", [])):
        rows.append(
            {
                "date": day,
                "temperature_2m_max": daily.get("temperature_2m_max", [None] * len(daily.get("time", [])))[i],
                "temperature_2m_min": daily.get("temperature_2m_min", [None] * len(daily.get("time", [])))[i],
                "precipitation_sum": daily.get("precipitation_sum", [None] * len(daily.get("time", [])))[i],
            }
        )
    csv_path = write_csv("open_meteo_charlotte_daily", rows)
    return raw_path, csv_path


def download_bls() -> tuple[Path, Path]:
    url = "https://api.bls.gov/publicAPI/v2/timeseries/data/LNS14000000?startyear=2020&endyear=2026"
    payload = fetch_json(url)
    raw_path = write_json("bls_unemployment_rate", payload)
    rows = []
    series_list = payload.get("Results", {}).get("series", []) if isinstance(payload, dict) else []
    for series in series_list:
        series_id = series.get("seriesID")
        for point in series.get("data", []):
            rows.append(
                {
                    "series_id": series_id,
                    "year": point.get("year"),
                    "period": point.get("period"),
                    "period_name": point.get("periodName"),
                    "value": point.get("value"),
                }
            )
    csv_path = write_csv("bls_unemployment_rate", rows)
    return raw_path, csv_path


def main() -> None:
    outputs = []
    for name, downloader in {
        "world_bank": download_world_bank,
        "open_meteo": download_open_meteo,
        "bls": download_bls,
    }.items():
        try:
            raw_path, csv_path = downloader()
            outputs.append({"source": name, "raw_file": str(raw_path), "csv_file": str(csv_path), "status": "ok"})
        except Exception as exc:  # Keep one failed source from blocking the rest.
            outputs.append({"source": name, "raw_file": "", "csv_file": "", "status": f"error: {exc}"})

    census_key = os.getenv("CENSUS_API_KEY")
    if census_key:
        outputs.append({"source": "census", "raw_file": "", "csv_file": "", "status": "key detected; add project-specific call"})

    write_csv("source_log", outputs)
    print(f"Wrote public API starter files to {OUT_DIR}")


if __name__ == "__main__":
    main()
