# LindaData Agent Company — Workflows.md

Version: 2026-07-02  
Owner: COO + Chief of Staff  
Purpose: make the agent company repeatable.

## Standard execution loop

```text
CEO request
→ Chief of Staff intake
→ Work packet
→ Executive owner
→ Specialist agents
→ QA / Trust review
→ Chief of Staff summary
→ Context.md + Decision_Log.md update
→ CEO review link or next action
```

## Morning review workflow

Use this when the CEO opens the HQ or asks for a morning check.

1. Check current priority: HVAC remains first unless explicitly changed.
2. Check latest review inboxes:
   - HQ inbox: issue #61
   - Universal latest inbox: issue #67
   - Legacy/history inbox: issue #30
3. Check active HVAC PRs:
   - PR #59: current HVAC review notes lane
   - PR #60: desktop views lane
4. Check open blockers:
   - review webhook reliability
   - CI/build/test failures
   - auth/security risks
   - missing review links
5. Scan paused/closed projects only to make sure nothing urgent is hiding.
6. Report one next action.

Output format:

```text
Status:
Done:
Found:
Next:
Need from you:
```

## Intake workflow

When a request arrives:

1. Identify the goal.
2. Identify the repo/project.
3. Check current context.
4. Decide whether tools are needed.
5. Assign one executive owner.
6. Assign supporting chiefs only when needed.
7. Create a small work packet.
8. Avoid clarification unless the wrong assumption would break the work.

### Intake template

```md
## Work Packet

Goal:
- ...

Project / repo:
- ...

Executive owner:
- ...

Supporting chiefs:
- ...

Specialist agents:
- ...

Constraints:
- mobile-first
- no secrets exposed
- no paid spend without approval
- preserve Lovable scaffold if present

Acceptance criteria:
- ...

Proof required:
- tests/build/link/screenshot/log

Next CEO-facing output:
- review link / decision memo / short status
```

## Routing workflow

| Request type | Executive owner | Specialist agents |
|---|---|---|
| App architecture | CTO | Software Architect, Frontend, Backend, API, DevOps |
| UX / review readiness | PRO | Product Designer, UX Researcher, Mobile UX Reviewer, Review Layer Agent |
| Data / modeling | CDO | Data Engineer, Data Analyst, Data Scientist, ML Engineer |
| Cost / subscriptions | CFO | FP&A, Subscription Audit, Pricing Analyst |
| Marketing / SEO | CMO | SEO, Copywriter, Growth, Brand Designer |
| Operations / SOPs | COO | Program Manager, SOP Designer, Release Coordinator |
| Hiring / role design | CHRO | Recruiter, Training, Agent Eval |
| Founder workload | CHO | Workload Balancer, Focus Coach |
| Customer / support | CCO | Support, Customer Research, Help Docs |
| Security / privacy | CSO | Security Architect, Privacy, Access Control |
| Knowledge / docs | CIO | Knowledge Manager, Tool Registry, Librarian |
| Personal admin | Personal Assistant | Calendar, Gmail, Contacts, Travel, Purchase Research |

## Codex / GitHub workflow

Use this for repo work.

1. Read repo instructions:
   - `AGENTS.md`
   - `README.md`
   - relevant docs
2. Inspect the repo before changing anything.
3. Preserve current architecture.
4. Preserve Lovable scaffold if the app started in Lovable.
5. Create the smallest useful PR.
6. Run available checks:
   - lint
   - tests
   - TypeScript
   - production build
7. Report exact:
   - files changed
   - commands run
   - passed checks
   - failed checks
   - risks
   - review link

### Codex handoff prompt

```text
Read AGENTS.md, README.md, and relevant docs first.

Follow LindaData operating rules:
- Preserve existing architecture.
- Preserve Lovable scaffold if present.
- Do not rebuild from scratch.
- Keep changes small, testable, and reviewable.
- Protect secrets and never expose API keys.
- Run lint, tests, TypeScript checks, and production build where available.
- Keep iPhone/mobile review first.
- Report exact files changed, commands run, test/build results, and risks.

Current priority:
HVAC / Field Copilot is priority 1 unless this task says otherwise.

Now inspect the repo and propose the smallest next useful PR.
```

## Review layer workflow

Target path:

```text
CEO on iPhone
→ opens live app/page
→ writes note in review layer
→ review layer health-checks endpoint
→ note posts to Cloudflare Worker
→ Worker writes GitHub issue comment
→ ChatGPT/Codex can read and act
```

Required states:

| State | Meaning |
|---|---|
| Live sync | Endpoint is healthy |
| Syncing | Note is being sent |
| Failed | Endpoint failed; keep draft text |
| Blocked | Endpoint missing or unsafe |

Rules:

- Never say `saved` unless webhook returned success.
- Never use `localStorage` as final state.
- Keep copy fallback.
- Preserve draft text on failure.
- Attach route, page, device, viewport, note kind, priority, and visible context.
- Map every app to a GitHub issue inbox.

## QA / Trust workflow

QA can block any review link.

Before CEO review, QA checks:

1. Does the app load on iPhone?
2. Does the first screen say what to review?
3. Do core buttons work?
4. Does the review layer sync live?
5. Are errors honest?
6. Is CI green?
7. Are known blockers visible?
8. Are secrets protected?
9. Is the report short?

### QA status labels

| Label | Meaning |
|---|---|
| Green | Ready for CEO |
| Yellow | Usable but has visible limitations |
| Red | Do not send for CEO review |
| Blocked | Needs external action, secret, approval, or failing dependency |

## Decision workflow

A decision is recorded when it affects future work.

Examples:

- Priority changes
- Repo choice
- Architecture choice
- Tool choice
- Spend approval
- Security rule
- Naming rule
- Deprioritization / pause / close

Record decisions in `Decision_Log.md`.

### Decision record template

```md
## YYYY-MM-DD — Decision title

Decision:
- ...

Reason:
- ...

Owner:
- ...

Impact:
- ...

Status:
- active | paused | closed | superseded | needs confirmation
```

## Security workflow

Before any deploy or public page update:

1. Confirm no secrets are committed.
2. Confirm no private data is exposed in public static files.
3. Confirm browser code does not include private tokens.
4. Confirm auth is real if private data is shown.
5. Confirm cost impact is zero or explicitly approved.
6. Log security-relevant decisions.
