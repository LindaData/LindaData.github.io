# LindaData Agent Company — Workflows.md

Version: 2026-07-02  
Owner: COO + Chief of Staff  
Purpose: make the agent company repeatable.

## 1. Standard execution loop

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

## 2. Intake workflow

When a request arrives:

1. Identify the goal.
2. Identify the repo/project.
3. Check current context.
4. Decide whether tools are needed.
5. Assign one executive owner.
6. Create a small work packet.
7. Avoid clarification unless the wrong assumption would break the work.

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
- protect private access material
- no paid spend without approval
- preserve Lovable scaffold if present

Acceptance criteria:
- ...

Proof required:
- tests/build/link/screenshot/log

Next CEO-facing output:
- review link / decision memo / short status
```

## 3. Routing workflow

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

## 4. Codex / GitHub workflow

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
- Protect private access material.
- Run lint, tests, TypeScript checks, and production build where available.
- Keep iPhone/mobile review first.
- Report exact files changed, commands run, test/build results, and risks.

Current priority:
HVAC / Field Copilot is priority 1 unless this task says otherwise.

Now inspect the repo and propose the smallest next useful PR.
```

## 5. Review layer workflow

The review layer is the feedback nervous system.

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
- Local browser storage can be recovery only, not final state.
- Keep copy fallback.
- Preserve draft text on failure.
- Attach route, page, device, viewport, note kind, priority, and visible context.
- Map every app to a GitHub issue inbox.

## 6. QA / Trust workflow

QA can block any review link.

Before CEO review, QA checks:

1. Does the app load on iPhone?
2. Does the first screen say what to review?
3. Do core buttons work?
4. Does the review layer sync live?
5. Are errors honest?
6. Is CI green?
7. Are known blockers visible?
8. Is private access material protected?
9. Is the report short?

### QA status labels

| Label | Meaning |
|---|---|
| Green | Ready for CEO |
| Yellow | Usable but has visible limitations |
| Red | Do not send for CEO review |
| Blocked | Needs external action, approval, or failing dependency |

## 7. Decision workflow

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

Follow-up:
- ...

Status:
- active / superseded / closed
```

## 8. Context update workflow

Update `Context.md` when:

- Project priority changes.
- A blocker appears or clears.
- A user preference changes.
- A repo/link/status changes.
- A project becomes ready or not ready for review.
- Work is paused, closed, or restarted.

Update format:

```md
| Date | Update | Owner |
|---|---|---|
| YYYY-MM-DD | ... | Chief of Staff |
```

## 9. Incident workflow

Use this when something fails.

```text
Failure found
→ stop claiming success
→ capture exact error
→ identify owner
→ preserve user input/work
→ create blocker note
→ fix or route
→ rerun test
→ report pass/fail honestly
```

Incident report:

```text
Status: red/yellow

What failed:
- ...

Where:
- ...

Likely cause:
- ...

Fix:
- ...

Proof:
- ...

Next:
- ...
```

## 10. Executive standup

Use when the CEO says: “check everything,” “run the brain,” or “what should I do now.”

Order:

1. Check current active priorities.
2. Check open PRs/issues.
3. Check latest review notes.
4. Check blockers.
5. Route work.
6. Return tiny list:

```text
Now:
- ...

Next:
- ...

Waiting/blocker:
- ...
```

## 11. CEO review note

Every review handoff should be short.

```text
Status: yellow

Ready link:
- ...

What changed:
- ...

What to review:
- ...

Known blockers:
- ...

Next after your review:
- ...
```
