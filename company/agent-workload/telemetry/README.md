# Private Agent Telemetry API

Version: 2026-07-03  
Owner lane: CIO + CSO + CTO + Chief of Staff  
Status: deployment triggered after secrets added

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

## Deployment trigger

A telemetry README update was committed after the required GitHub Actions secrets were added. This change is inside `company/agent-workload/telemetry/`, so it should trigger the deploy workflow through the configured path filter.

## Deployment steps

1. GitHub Actions starts the deploy workflow.
2. Workflow installs Wrangler.
3. Workflow deploys Worker source.
4. Workflow pushes Worker runtime secrets.
5. Test `GET /health`.
6. Send one trusted `POST /v1/agent-usage` event.
7. Confirm `usage-log.json` receives a new row.
8. Confirm the tracker page shows the row.

## Security rules

- Do not put private write credentials in the static page.
- Do not commit private values.
- Do not log raw prompts unless explicitly approved.
- Store only sanitized work metadata in the public usage ledger.

## Current limitation

The source, deployment pipeline, and trigger commit are now in the repo. Final proof depends on the GitHub Actions run completing and the Cloudflare Worker returning a healthy response.
