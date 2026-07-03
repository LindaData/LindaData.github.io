# LindaData Agent Company — Workflows.md

Version: 2026-07-03  
Owner: COO + Chief of Staff  
Purpose: make the agent company repeatable, world-class, and routed through the correct executive owner.

## 1. Standard execution loop

```text
CEO request
→ LindaData ask form
→ Company_Org.md routing check
→ Chief of Staff intake
→ executive owner
→ specialist agents / office
→ CLO or CISO gate when triggered
→ QA / Trust review
→ Chief of Staff summary
→ durable docs update when useful
→ CEO review link or next action
```

Rule: every meaningful task starts by checking `company/Company_Org.md`, assigning one executive owner, defining acceptance criteria, and marking gates.

## 2. World-class exec workflow

Every executive must operate at this bar:

1. Own the outcome.
2. Use specialists instead of doing everything alone.
3. Produce proof, not vibes.
4. Keep CEO updates short and useful.
5. Teach the org by updating durable docs when a pattern matters.
6. Escalate legal/security/data/cost/brand risk early.
7. Do not create bureaucracy unless it improves execution.

## 3. LindaData ask form

```md
Ask:
LindaData priority:
Executive owner:
Supporting agents:
Target asset:
Required context:
Execution plan:
QA / acceptance test:
Output:
CLO gate:
CISO gate:
```

Use this for every work/build/project request unless it is clearly personal/non-LindaData.

## 4. Routing table

| Request type | Executive owner | Supporting agents / offices | Gate |
|---|---|---|---|
| Product roadmap, requirements, portfolio | CPO | Product Manager, Product Designer, Roadmap Manager, PRO, CCO | CLO if public claims/user data; CISO if auth/private data. |
| CEO review surface, acceptance criteria, feedback triage | PRO under CPO + COO | Review Layer Agent, QA Intake, Feedback-to-Task Agent, CTO | CLO/CISO when notes, screenshots, or telemetry are captured. |
| App architecture, repo build, deployment | CTO | Architect, Frontend, Backend, DevOps, QA, SRE | CISO for access/security; CLO for legal/data/vendor/IP. |
| AI agents, model systems, evals, research | CAIO | AI Architect, Eval Agent, Prompt/Agent Systems, CDO, CTO | CLO for AI governance; CISO for sensitive data. |
| Data, analytics, statistics, dashboards | CDO | Data Engineer, Statistician, BI, Data Quality, Governance | CLO for data rights/privacy; CISO for protected data. |
| Release, QA, operating cadence, incidents | COO | PM, Release Coordinator, QA Coordinator, Incident Commander | CISO/CLO for incidents or risky launches. |
| Spend, pricing math, ROI, budget | CFO | Budget, Pricing, Unit Economics, Revenue Analyst | CLO for contracts/payment terms. |
| Sales, partnerships, revenue motion | CRO | Sales Strategy, Partnerships, Revenue Ops, Enterprise Accounts | CLO for terms; CFO for pricing/economics. |
| Marketing, brand, SEO, copy, launch messaging | CMO | Brand, Copy, Growth, SEO, Creative, Comms Agent | CLO for claims/IP; CPO for product accuracy. |
| Legal, privacy, contracts, IP, AI governance | CLO | Legal Ops, Privacy, Contracts, IP, Product Legal, AI Governance | Always CLO owned. |
| Security, access, auth, incidents, appsec | CISO | Security Architect, Access Control, Secrets, Incident Response | CLO if privacy/incident/legal risk. |
| Strategy, corp dev, expansion, market choice | CStrO | Market Research, Moat, Expansion, Corp Dev, Partnerships | CFO/CRO/CLO depending on transaction. |
| Agent design, onboarding, performance | CHRO | Role Designer, Training, Eval, Culture | CLO for employment/policy language. |
| Customer support, onboarding, retention | CCO | Support, Customer Research, Help Docs, Feedback | CLO for risky advice/claims. |
| Source of truth, docs, context, tool registry | CIO | Knowledge Manager, Documentation QA, Archive | CISO/CLO for sensitive docs. |
| Founder energy, simplicity, accessibility | CHO | Focus Coach, Simplicity, Accessibility, Burnout Watcher | Usually not needed. |
| Admin, links, setup, purchases, calendar/email | Personal Assistant | Link, Setup, Calendar, Email, Travel, Shopping | CFO/CLO/CISO when money/contracts/accounts are involved. |

## 5. Exec onboarding workflow

When a new chief or office is created:

1. Add it to `company/Company_Org.md`.
2. Add/update root `Agents.md`.
3. Create an `agents/<department>/README.md` office file.
4. Give the office mission, authority, tools, direct reports, intake rules, output format, and performance bar.
5. Update `agents/README.md` department list.
6. Update Context/Decision Log if future work changes.
7. Verify by reading the file back from `master`.

## 6. Codex / GitHub workflow

1. Read repo instructions and relevant LindaData org docs.
2. Route through the ask form.
3. Assign one executive owner.
4. Preserve existing architecture and Lovable scaffold when present.
5. Make the smallest useful change.
6. Run available checks.
7. Report files changed, commands/checks, limits, gates, and review link.

## 7. Review layer workflow

```text
CEO on iPhone
→ opens live app/page
→ taps in-app Review button
→ writes note or attaches snapshot where supported
→ webhook confirms sync
→ note lands in GitHub issue inbox
→ agents route it into work
```

Rules:

- Use the HVAC app-style in-app overlay as the default.
- Do not send CEO to detached review workspace as the normal path.
- Never say saved unless webhook succeeds.
- Preserve draft text on failure.
- PRO owns readiness; CTO owns implementation; CISO/CLO own security/privacy/legal gates.

## 8. QA / Trust workflow

Before CEO review, QA checks:

1. Live link exists.
2. App loads on iPhone.
3. Core buttons work.
4. Review layer sync is honest.
5. CI/build status is known.
6. Known blockers are visible.
7. CLO/CISO gates are handled when triggered.
8. Report is short.
9. Review link opens the real app screen.

## 9. Decision workflow

Record durable decisions when they affect future work.

Examples:

- Priority changes.
- Org/routing changes.
- Executive role changes.
- Tool choice.
- Security/legal/cost rules.
- Architecture decisions.
- Launch/review standards.

Record in `Context.md`, `company/Decision_Log.md`, `company/Company_Org.md`, `company/Workflows.md`, or relevant `agents/` file.
