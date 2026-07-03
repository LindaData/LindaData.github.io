# LindaData Agent Workload Tracker

Version: 2026-07-03  
Owner: CIO + Chief of Staff + PRO  
Status: Active

## Purpose

Track agent work in a simple way.

The page shows:

- executive owner
- agent
- task
- minutes
- token estimates
- proof links
- source of the log

## Live page

- `/company/agent-workload/`

## Repo-backed ledger

- `usage-log.json`

The page reads `usage-log.json` plus local browser entries.

## Private telemetry API

Backend source is now stored here:

- `telemetry/worker.js`
- `telemetry/README.md`
- `telemetry/event-format.md`
- `telemetry/wrangler.example.toml`

The private worker accepts trusted usage events and appends sanitized rows to `usage-log.json`.

## Token rule

Exact ChatGPT in-app token usage is not available to this static GitHub Pages page.

When using the OpenAI API directly, responses can include a `usage` object with input, output, and total token counts. The telemetry worker can receive those values and store them.

Use this source field:

```text
manual_estimate = estimated by assistant or user
api = future private telemetry/API log
manual_local = entered in browser local storage
assistant_repo_log = committed by assistant to GitHub
private_telemetry_api = sent through the private Worker
```

## Assistant logging rule

For meaningful LindaData GitHub/company work, the assistant should add a usage entry to `usage-log.json` with:

```json
{
  "id": "YYYY-MM-DD-short-task-name",
  "date": "YYYY-MM-DD",
  "source": "assistant_repo_log",
  "executive_owner": "PRO + CTO + CIO",
  "agent": "Frontend Engineer + GitHub / Codex Operator",
  "task": "Short task summary",
  "minutes_estimate": 0,
  "input_tokens_estimate": 0,
  "output_tokens_estimate": 0,
  "total_tokens_estimate": 0,
  "proof": "https://github.com/...",
  "status": "done",
  "telemetry_source": "manual_estimate"
}
```

## Deployment requirement

Final private telemetry deployment requires external Worker environment values set outside this public repo. Do not place private values in the static site or committed files.
