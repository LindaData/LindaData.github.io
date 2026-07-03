# Private Agent Telemetry API

Version: 2026-07-03  
Owner lane: CIO + CSO + CTO + Chief of Staff  
Status: deployment workflow added

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
| .github/workflows/deploy-agent-telemetry.yml | GitHub Actions deploy pipeline |

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

## Deployment workflow

The repository now includes:

```text
.github/workflows/deploy-agent-telemetry.yml
```

The workflow deploys the Worker when telemetry source files change or when run manually. It requires Cloudflare credentials in GitHub Actions repository settings.

## Deployment steps

1. Configure Cloudflare credentials in GitHub Actions settings.
2. Run the deploy workflow or push a telemetry source change.
3. Test `GET /health`.
4. Send one trusted `POST /v1/agent-usage` event.
5. Confirm `usage-log.json` receives a new row.
6. Confirm the tracker page shows the row.

## Security rules

- Do not put private write credentials in the static page.
- Do not commit private values.
- Do not log raw prompts unless explicitly approved.
- Store only sanitized work metadata in the public usage ledger.

## Current limitation

The source and deployment pipeline are now in the repo. Final deployment depends on private Cloudflare/GitHub values being present in external settings; those values are not available to this chat and must not be committed.
