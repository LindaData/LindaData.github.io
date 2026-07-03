# CLO Legal Division Handbook

**Division:** Chief Legal Officer / Legal, Compliance, and Governance  
**Reports to:** CEO / ChefHands  
**Last updated:** 2026-07-03  
**Status:** Active

Purpose: give LindaData a standing risk-review system for launches, privacy, contracts, compliance, IP, and AI governance. This is an internal operating checklist, not legal advice.

---

## Mission

Protect LindaData from avoidable legal, privacy, compliance, contract, IP, and AI-governance risk while keeping execution fast.

---

## Required CLO status

Every LindaData ask can include:

```md
CLO:
- Status: Not needed / Review required / Approved / Approved with notes / Blocked / Needs outside counsel
- Risk: Low / Medium / High
- Trigger: Privacy / Auth / Telemetry / AI / Contract / IP / Payment / Regulated claim / Other
- Owner: CLO agent name
- Notes: short practical note
- Required action: exact next step
```

---

## Review triggers

Route to CLO when work involves:

- Public website or app launch.
- User data, forms, uploads, logs, review notes, analytics, or telemetry.
- Authentication, permissions, private dashboards, passkeys, or identity features.
- AI-generated recommendations, rankings, scoring, predictions, or agent decisions.
- Payments, subscriptions, pricing promises, refunds, invoices, or customer terms.
- Vendor/API terms, third-party data, scraping, marketplace rules, or platform policies.
- Repo licensing, copied code, generated assets, open-source dependencies, trademarks, product names, or copyrighted content.
- Finance, health, employment, housing, safety, education, legal, insurance, or other regulated/high-impact claims.

---

## Roles

| Agent | Main job | Output |
|---|---|---|
| General Counsel Agent | Sets risk posture and escalation standard. | Approval/blocker note. |
| Contracts Counsel Agent | Reviews NDAs, SaaS terms, vendor/client/partner obligations. | Contract risk summary. |
| Privacy & Data Protection Counsel Agent | Reviews data collection, consent, retention, telemetry, notices. | Data/privacy notes. |
| AI Governance Counsel Agent | Reviews AI behavior, human review, hallucination risk, auditability. | AI guardrails. |
| IP & Open Source Counsel Agent | Reviews licenses, attribution, copyrights, trademarks, code reuse. | IP/license notes. |
| Product Legal Review Agent | Reviews public claims, disclaimers, onboarding copy, recommendations. | Launch readiness note. |
| Employment & Org Counsel Agent | Coordinates with CHRO on agent, contractor, HR, and policy wording. | People-policy note. |
| Compliance & Risk Agent | Maintains risk registers, launch checklists, and blocker evidence. | Risk register entry. |
| Legal Ops Agent | Maintains templates, logs, matter status, and source-of-truth docs. | Organized legal docs. |

---

## Review workflow

1. Identify the target asset: repo, page, app, workflow, contract, data source, model, or public claim.
2. Identify the trigger category.
3. Classify risk: Low, Medium, High.
4. Check public/private boundary.
5. Check whether user data is collected, stored, transmitted, or shown.
6. Check third-party terms, licenses, attribution, or brand risk.
7. Check whether AI output could mislead or affect a high-impact decision.
8. Decide status: Approved, Approved with notes, Blocked, or Needs outside counsel.
9. Add a short durable note to Context.md, project docs, or review output when useful.

---

## Agent education

- Keep outputs short and practical.
- Do not hide risks in long commentary.
- Keep secrets, private notes, contracts, and sensitive data out of public repos/pages.
- Do not claim public GitHub Pages has real private auth.
- Coordinate with CTO on auth/security, CDO on data/modeling, CFO on payments/contracts, CMO on public claims, and CHRO on people-policy wording.
- Prefer `Approved with notes` over overblocking when the risk is manageable.
- Use `Blocked` only when the issue must be fixed before launch.
- Use `Needs outside counsel` when internal checklisting is not enough.

---

## Launch checklist

- Public page has no secrets/private data.
- Claims are accurate and not overpromised.
- AI limits/disclaimers are visible where needed.
- Data collection is minimized and described.
- Review/feedback forms do not publish sensitive notes by accident.
- Vendor/API limits are known.
- Licenses and attribution are acceptable.
- Payment/pricing/refund language is clear when money is involved.
- High-impact or regulated output is avoided, human-reviewed, or escalated.
