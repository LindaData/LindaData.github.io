# Private Agent Telemetry API

Version: 2026-07-03  
Owner lane: CIO + CSO + CTO + Chief of Staff  
Status: source ready, deployment tracked

## Purpose

This folder contains the backend source for private agent usage ingestion.

The tracker page remains public-safe. The backend accepts trusted usage events and writes sanitized rows into:

```text
company/agent-workload/usage-log.json
```

## Files

| File | Purpose |
|---|---|
| worker.js | Cloudflare Worker source for private ingestion |
| wrangler.example.toml | Example Worker config without private values |
| event-format.md | Accepted event fields |
| sample-event.json | Example API-backed usage event |

## Endpoints

```text
GET  /health
POST /v1/agent-usage
```

`POST /v1/agent-usage` requires a private write credential configured in the Worker environment.

## Source of exact token counts

When using the OpenAI API directly, model responses can include usage information such as input, output, and total tokens. The telemetry worker accepts those fields and stores them in the usage ledger.

## Deployment tracker

- https://github.com/LindaData/field-copilot-pro/issues/72

The HQ repo has issues disabled, so the deployment tracker lives in the active LindaData work repo.

## Deployment steps

1. Create a Cloudflare Worker named `lindadata-agent-telemetry`.
2. Use `worker.js` as the Worker source.
3. Set public config values from `wrangler.example.toml`.
4. Set private Worker values in Cloudflare settings.
5. Give the GitHub credential contents-write access to `LindaData/LindaData.github.io` only.
6. Test `GET /health`.
7. Send one trusted `POST /v1/agent-usage` event.
8. Confirm `usage-log.json` receives a new row.
9. Confirm the tracker page shows the row.

## Security rules

- Do not put private write credentials in the static page.
- Do not commit private values.
- Do not log raw prompts unless explicitly approved.
- Store only sanitized work metadata in the public usage ledger.

## Current limitation

This repository now has the backend source and tracker integration. Final deployment still requires Cloudflare environment values and a GitHub credential configured outside the public repo.
