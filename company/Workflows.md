# LindaData Agent Company — Workflows.md

Version: 2026-07-03  
Owner: COO + Chief of Staff  
Purpose: make the agent company repeatable and make every task route through the LindaData org system.

## 1. Standard execution loop

```text
CEO request
→ LindaData ask form
→ Company_Org.md routing check
→ Chief of Staff intake
→ Work packet
→ Executive owner
→ Specialist agents
→ CLO review when triggered
→ QA / Trust review
→ Chief of Staff summary
→ Context.md + Decision_Log.md update when durable
→ CEO review link or next action
```

Rule: every meaningful task starts by checking `company/Company_Org.md`, assigning one executive owner, defining acceptance criteria, and marking the CLO gate.

## 2. LindaData ask form

Use this form for every work/build/project request unless the task is clearly personal or non-LindaData.

| Field | Required behavior |
|---|---|
| Ask | State the actual outcome wanted. |
| LindaData priority | P0/P1/P2/P3 and why now. |
| Executive owner | Assign one lead executive. |
| Supporting agents | Assign specialists/chiefs needed to execute. |
| Target asset | Repo, site, doc, dashboard, workflow, issue, project, or file. |
| Required context | Check Company_Org.md, Context.md, Memory.md, Workflows.md, and relevant agent docs. |
| Execution plan | Smallest useful path. |
| QA / acceptance test | What must be checked before saying done. |
| Output | Link, PR, issue, file, checklist, summary, or next action. |
| CLO gate | Not needed / Review required / Approved / Approved with notes / Blocked / Needs outside counsel. |

## 3. Intake workflow

When a request arrives:

1. Identify the goal.
2. Identify the repo/project/asset.
3. Check `Company_Org.md` for executive ownership and specialist routing.
4. Check current context.
5. Decide whether tools are needed.
6. Assign one executive owner.
7. Identify the CLO gate.
8. Create a small work packet.
9. Avoid clarification unless the wrong assumption would break the work.

### Intake template

```md
## Work Packet

Ask:
- ...

LindaData priority:
- P0 / P1 / P2 / P3

Project / repo / asset:
- ...

Executive owner:
- ...

Supporting chiefs:
- ...

Specialist agents:
- ...

Company Org reference:
- /company/Company_Org.md

Required context:
- ...

Constraints:
- mobile-first
- protect private access material
- no paid spend without approval
- preserve Lovable scaffold if present

CLO gate:
- Not needed / Review required / Approved / Approved with notes / Blocked / Needs outside counsel
- Trigger:
- Risk:

Acceptance criteria:
- ...

Proof required:
- tests/build/link/screenshot/log/citation

Next CEO-facing output:
- review link / decision memo / short status
```

## 4. Routing workflow

| Request type | Executive owner | Specialist agents | CLO gate |
|---|---|---|---|
| App architecture | CTO | Software Architect, Frontend, Backend, API, DevOps | Triggered by auth, telemetry, data, AI, payments, vendor terms, IP, regulated features. |
| UX / review readiness | PRO | Product Designer, UX Researcher, Mobile UX Reviewer, Review Layer Agent | Triggered by screenshots, review notes, telemetry, public claims. |
| Data / modeling | CDO | Data Engineer, Data Analyst, Data Scientist, ML Engineer | Triggered by user/private data, third-party terms, AI impact, regulated claims. |
| Legal / privacy / compliance | CLO | General Counsel, Privacy, Contracts, IP, AI Governance, Product Legal Review | Always owner. |
| Cost / subscriptions | CFO | FP&A, Subscription Audit, Pricing Analyst | Triggered by contracts, pricing claims, refunds, subscriptions, vendor obligations. |
| Marketing / SEO | CMO | SEO, Copywriter, Growth, Brand Designer | Triggered by public claims, testimonials, IP, regulated claims. |
| Operations / SOPs | COO | Program Manager, SOP Designer, Release Coordinator | Triggered by launch readiness or incident process. |
| Hiring / role design | CHRO | Recruiter, Training, Agent Eval | Triggered by employment, contractor, policy, or HR language. |
| Founder workload | CHO | Workload Balancer, Focus Coach | Usually not needed. |
| Customer / support | CCO | Support, Customer Research, Help Docs | Triggered by risky advice, customer terms, data, public claims. |
| Security / privacy | CSO | Security Architect, Privacy, Access Control | Triggered by auth, breach, incident, user data, private/public boundary. |
| Knowledge / docs | CIO | Knowledge Manager, Tool Registry, Librarian | Triggered by sensitive docs, legal notes, private data, public repo exposure. |
| Personal admin | Personal Assistant | Calendar, Gmail, Contacts, Travel, Purchase Research | Triggered by contracts, money, identity, private account data. |

## 5. Codex / GitHub workflow

Use this for repo work.

1. Read repo instructions:
   - `AGENTS.md`
   - `README.md`
   - relevant docs
   - `/company/Company_Org.md` when working in the HQ/company system
   - `/company/Review_Layer_Standard.md` when touching reviews, feedback, screenshots, QA, or UI review flows
2. Inspect the repo before changing anything.
3. Preserve current architecture.
4. Preserve Lovable scaffold if the app started in Lovable.
5. Create the smallest useful change or PR.
6. Run available checks:
   - lint
   - tests
   - TypeScript
   - production build
7. Check the CLO gate before calling the work launch-ready.
8. Report exact:
   - files changed
   - commands run
   - passed checks
   - failed checks
   - CLO status when triggered
   - risks
   - review link

### Codex handoff prompt

```text
Read AGENTS.md, README.md, relevant docs, and the LindaData Company Org first:
- company/Company_Org.md
- company/Review_Layer_Standard.md when touching reviews, feedback, screenshots, QA, or UI review flows

Follow LindaData operating rules:
- Route the task through the Company Org.
- Use the LindaData ask form.
- Assign one executive owner.
- Mark the CLO gate.
- Preserve existing architecture.
- Preserve Lovable scaffold if present.
- Do not rebuild from scratch.
- Keep changes small, testable, and reviewable.
- Protect private access material.
- Run lint, tests, TypeScript checks, and production build where available.
- Keep iPhone/mobile review first.
- Use the HVAC app-style in-app review layer, not a detached review workspace.
- Report exact files changed, commands run, test/build results, CLO status, and risks.

Current priority:
HVAC / Field Copilot is priority 1 unless this task says otherwise.

Now inspect the repo and propose the smallest next useful PR.
```

## 6. Review layer workflow

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
| Live sync | Endpoint is healthy. |
| Syncing | Note is being sent. |
| Failed | Endpoint failed; keep draft text. |
| Blocked | Endpoint missing or unsafe. |

Rules:

- Use the HVAC app-style in-app overlay as the default for every project.
- Do not send CEO to a detached review workspace as the normal review path.
- Never say `saved` unless webhook returned success.
- Local browser storage can be recovery only, not final state.
- Keep copy fallback.
- Preserve draft text on failure.
- Attach only necessary route, page, device, viewport, note kind, priority, and visible context.
- Map every app to a GitHub issue inbox.
- Support screenshot/snapshot paste or upload wherever the project stack can support it.
- CLO/Privacy review is required when review notes, screenshots, telemetry, identifiers, or public issue bodies are captured.

Glass-layer rule:

```text
Review layer = clean glass over the active product screen
Main page = real product underneath
Annotations = feedback only
Implementation = only after CEO approval
```

## 7. QA / Trust workflow

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
9. Is the CLO gate handled when triggered?
10. Is the report short?
11. Does the review link open the actual app screen, not a detached review workspace?

### QA status labels

| Label | Meaning |
|---|---|
| Green | Ready for CEO. |
| Yellow | Usable but has visible limitations. |
| Red | Do not send for CEO review. |
| Blocked | Needs external action, approval, legal review, or failing dependency. |

## 8. CLO workflow

Use this when legal-sensitive work is triggered.

```text
Work packet
→ identify trigger
→ assign CLO subagent
→ classify risk
→ check public/private boundary
→ issue approval/blocker note
→ record durable decision if future work depends on it
```

CLO triggers:

- Public launch.
- User data, forms, uploads, logs, telemetry, screenshots, review notes.
- Authentication, passkeys, identity, permissions, private dashboards.
- AI recommendations, rankings, predictions, scoring, agent autonomy.
- Payments, subscriptions, pricing promises, refunds, customer/vendor terms.
- Third-party APIs, scraping, platform policies, data rights.
- Repo licensing, copied code, generated assets, trademarks, names, copyrighted content.
- Regulated/high-impact claims.

CLO status labels:

| Label | Meaning |
|---|---|
| Not needed | No trigger found. |
| Review required | Trigger exists; CLO must review before launch-ready status. |
| Approved | No blocker at current stage. |
| Approved with notes | Continue, but track the note/disclaimer/checklist item. |
| Blocked | Do not ship until fixed. |
| Needs outside counsel | Internal review is not enough. Prepare questions for licensed counsel. |

## 9. Decision workflow

A decision is recorded when it affects future work.

Examples:

- Priority changes
- Repo choice
- Architecture choice
- Tool choice
- Spend approval
- Security rule
- Legal/risk rule
- Naming rule
- Deprioritization / pause / close
- Org/routing rule

Record durable decisions in the current source of truth: `Context.md`, `company/Decision_Log.md`, project docs, or relevant `agents/` files.

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
