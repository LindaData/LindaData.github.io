# LindaData Agent Company — Workflows.md

Version: 2026-07-03  
Owner: COO + Chief of Staff  
Purpose: make the agent company repeatable.

## 1. Standard execution loop

```text
CEO request
→ Company_Org.md routing check
→ Chief of Staff intake
→ Work packet
→ Executive owner
→ Specialist agents
→ QA / Trust review
→ Chief of Staff summary
→ Context.md + Decision_Log.md update
→ CEO review link or next action
```

Rule: every meaningful task starts by checking `company/Company_Org.md` and assigning one executive owner.

## 2. Intake workflow

When a request arrives:

1. Identify the goal.
2. Identify the repo/project.
3. Check `Company_Org.md` for executive ownership and specialist routing.
4. Check current context.
5. Decide whether tools are needed.
6. Assign one executive owner.
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

Company Org reference:
- /company/Company_Org.md

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
   - `/company/Company_Org.md` when working in the HQ/company system
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
Read AGENTS.md, README.md, relevant docs, and the LindaData Company Org first:
- company/Company_Org.md
- company/Review_Layer_Standard.md when touching reviews, feedback, screenshots, QA, or UI review flows

Follow LindaData operating rules:
- Route the task through the Company Org.
- Assign one executive owner.
- Preserve existing architecture.
- Preserve Lovable scaffold if present.
- Do not rebuild from scratch.
- Keep changes small, testable, and reviewable.
- Protect private access material.
- Run lint, tests, TypeScript checks, and production build where available.
- Keep iPhone/mobile review first.
- Use the HVAC app-style in-app review layer, not a detached review workspace.
- Report exact files changed, commands run, test/build results, and risks.

Current priority:
HVAC / Field Copilot is priority 1 unless this task says otherwise.

Now inspect the repo and propose the smallest next useful PR.
```

## 5. Review layer workflow

The review layer is the feedback nervous system.

Canonical standard:
- `company/Review_Layer_Standard.md`

Target path:

```text
CEO on iPhone
→ opens the live app/page being reviewed
→ taps the in-app Review button
→ writes a note or attaches a screenshot/snapshot
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

- Use the HVAC app-style in-app overlay as the default for every project.
- Do not send CEO to a detached review workspace as the normal review path.
- Never say `saved` unless webhook returned success.
- Local browser storage can be recovery only, not final state.
- Keep copy fallback.
- Preserve draft text on failure.
- Attach route, page, device, viewport, note kind, priority, and visible context.
- Map every app to a GitHub issue inbox.
- Support screenshot/snapshot paste or upload wherever the project stack can support it.

Glass-layer rule:

```text
Review layer = clean glass over the active product screen
Main page = real product underneath
Annotations = feedback only
Implementation = only after CEO approval
```

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
10. Does the review link open the actual app screen, not a detached review workspace?

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
- Org/routing rule

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
- active / superseded / paused / closed
```
