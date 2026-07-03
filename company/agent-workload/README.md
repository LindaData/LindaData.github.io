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

## Token rule

Exact ChatGPT token usage is not available to this static GitHub Pages page.

Until private telemetry is connected, token values are estimates.

Use this source field:

```text
manual_estimate = estimated by assistant or user
api = future private telemetry/API log
manual_local = entered in browser local storage
assistant_repo_log = committed by assistant to GitHub
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

## Future upgrade path

Real telemetry should use a private backend or API logs.

Do not put private tokens, secrets, or privileged API keys in the frontend.
