# LindaData Operating Context — Context.md

Version: 2026-07-03  
Owner: Chief of Staff  
Purpose: keep the company aligned, short, and easy to resume.

## 1. North star

The CEO’s time is the scarcest resource.

The system must always show:

1. What is active.
2. What is blocked.
3. What needs review.
4. What can be ignored.
5. The single next action.
6. Whether the CLO gate is needed or complete.

Default style:

```text
No wall of text.
Mobile-first.
ChatGPT-first.
Review links over explanations.
Brief but complete.
```

## 2. Global operating mandate

```text
From now on, EVERYTHING runs through the LindaData Company Org.
All work must align to the org structure before execution.
No random execution path.
No specialist-agent work without an executive owner.
No claim of done without QA/proof.
No launch-ready status on legal-sensitive work until the CLO gate is handled.
```

Default routing:

```text
ChefHands / CEO
→ Chief of Staff or correct executive owner
→ specialist agents
→ CLO review when triggered
→ QA / proof
→ CEO-facing summary or review link
```

## 3. Standard LindaData ask form

| Field | Required behavior |
|---|---|
| Ask | State the outcome wanted. |
| LindaData priority | P0/P1/P2/P3 and why now. |
| Executive owner | Assign one lead executive. |
| Supporting agents | Assign specialists/chiefs needed. |
| Target asset | Repo, site, doc, dashboard, workflow, issue, project, or file. |
| Required context | Check Company_Org.md, Context.md, Memory.md, Workflows.md, and relevant agent docs. |
| Execution plan | Smallest useful path. |
| QA / acceptance test | What must pass before saying done. |
| Output | Link, PR, issue, file, checklist, summary, or next action. |
| CLO gate | Not needed / Review required / Approved / Approved with notes / Blocked / Needs outside counsel. |

## 4. Standing communication preferences

| Preference | Rule |
|---|---|
| Brevity | Short, useful, no filler. |
| Device | Assume iPhone/mobile unless told otherwise. |
| Build instructions | Copy-pasteable and device-specific. |
| Work reports | `Status / Done / Found / Next / Need from you / CLO when relevant`. |
| Explanations | Explain simply when needed; avoid walls of text. |
| Links | Give direct review links when possible. |
| Questions | Do not ask unnecessary clarification; make the safest useful assumption. |
| Updates | Give short progress updates only for long or tool-heavy work. |
| Testing | Do not claim success without proof. |
| Context | Context matters; check prior project state before acting. |
| Company Org | Every meaningful task must reference `/company/Company_Org.md` for ownership and routing. |
| Org alignment | Everything runs through the org and must be aligned to an executive owner before execution. |
| CLO gate | Legal-sensitive work routes through CLO before launch-ready status. |
| Logs | Log important work in GitHub/docs, not memory only. |
| Security | Protect private access material. Do not place private values in frontend, commits, logs, screenshots, or chat. |
| Cost | Free/local-first; no paid spend or auto-top-up without explicit approval. |
| Lovable apps | Preserve Lovable scaffold unless CEO says to replace it. |

## 5. Current operating facts

| Area | Current fact |
|---|---|
| Company | LindaData |
| CEO | ChefHands / Sergio |
| Control room | ChatGPT |
| Execution memory | GitHub |
| Main bounded builder | Codex |
| Canonical company org | `company/Company_Org.md` |
| Global mandate | Everything runs through Company Org and is aligned before execution. |
| Default ask format | LindaData ask form with owner, QA, output, and CLO gate. |
| CLO division | Active executive division for legal, privacy, compliance, contracts, IP, AI governance, and launch review. |
| Canonical active app repo | `LindaData/field-copilot-pro` |
| HQ repo | `LindaData/LindaData.github.io` |
| Older repo | `field-copilot-buddy` is history / ignore. |
| Priority 1 | HVAC / Field Copilot unless explicitly changed. |
| Mobile review | CEO is usually reviewing from iPhone. |
| Review architecture | App review box → Cloudflare Worker → GitHub issue comments → ChatGPT/Codex action queue. |
| Security model | Public-safe GitHub Pages shell; private data behind real auth when needed. |
| Passkeys / Face ID | Only through a real backend challenge flow, not fake frontend security. |

## 6. Active project board

As of 2026-07-03.

| Priority | Project | Owner | Status | Next action | Review ready |
|---:|---|---|---|---|---|
| 1 | HVAC Copilot | CTO + PRO + CDO + QA + CLO when triggered | Active P0 | Improve UI, prove review layer reliability, keep AI/user-data/auth claims legally gated. | Not until smoke-tested. |
| 2 | Universal Review Layer System | PRO + CTO + CSO + QA + CLO | Active P0 | Standardize HVAC-style in-app overlay and keep telemetry/public issue content safe. | Not until cross-route tested. |
| 3 | Company Org / Agentic Company | Chief of Staff + CIO + CHRO + CLO | Active P1 | Reference `Company_Org.md` and ask form for every task route. | Yes. |
| 4 | CLO Legal Division | CLO + Legal Ops + CIO | Active P1 | Use legal gates for launch, privacy, AI, IP, contracts, payments, and regulated claims. | Yes. |
| 5 | Central HQ / Work Dashboard | Chief of Staff + CIO + PRO + CTO + CLO | Active P1 | Keep public HQ links, command needs, company docs, and public/private boundary current. | Prototype only. |
| 6 | Southpaw Boxing Site | PRO + CMO + CTO + CLO | Paused | Replace local-only review drawer with shared live-sync layer before review. | No. |
| 7 | Cloud / Codex / Infra Setup | CTO + CSO + CFO + CLO | Paused | Do not spend cycles until restarted. | Paused. |
| 8 | Money Transfer | Personal Assistant / CFO | Closed | Archive from active dashboard. | Closed. |
| 9 | Ghostwriting / Book Engine | Chief of Staff + CIO + CDO + Editorial + CLO | Planning | Choose private storage/source capture rules later. | Planning. |

## 7. Review layer non-negotiables

Build once. Reuse everywhere.

Required behavior:

- Health check runs before and during review startup.
- UI states: `Live sync`, `Syncing`, `Failed`, `Blocked`.
- Capture button is disabled or shows error unless endpoint is live.
- Never show `saved` unless webhook returns success.
- Local browser storage can be temporary recovery only, not the final state.
- If offline or webhook fails, preserve draft text in the input field.
- Old unsynced local notes need manual recovery path.
- CLO/Privacy review is required when notes, screenshots, page context, user identifiers, telemetry, or public issue bodies are captured.

Required payload shape:

```json
{
  "repo": "LindaData/field-copilot-pro",
  "sourceRepo": "LindaData/LindaData.github.io",
  "targetIssue": 45,
  "project": "hvac-copilot",
  "route": "/app/today",
  "pageLabel": "Today",
  "url": "https://...",
  "viewport": {"width": 390, "height": 844},
  "userAgent": "string",
  "timestamp": "ISO-8601",
  "noteKind": "bug|ux|copy|data|idea|approval",
  "priority": "low|medium|high|blocker",
  "visibleContext": {"heading": "...", "selectedItem": "..."},
  "note": "string",
  "attachments": []
}
```

Inbox mapping:

| Area | Target |
|---|---|
| HVAC | `LindaData/field-copilot-pro` issue #45 |
| Recycling | `LindaData/field-copilot-pro` issue #57 |
| Shared review system | `LindaData/field-copilot-pro` issue #58 |
| HQ dashboard | `LindaData/field-copilot-pro` issue #61 |
| Southpaw | Create or map dedicated issue |

## 8. CLO review triggers

CLO review is required for:

- Public website or app launch.
- User data, forms, uploads, logs, review notes, analytics, or telemetry.
- Authentication, passkeys, identity, private dashboards, or permissions.
- AI-generated recommendations, rankings, scoring, predictions, or agent decisions.
- Payments, subscriptions, pricing promises, refunds, invoices, or customer terms.
- Vendor/API terms, third-party data, scraping, marketplace rules, or platform policies.
- Repo licensing, copied code, generated assets, open-source dependencies, trademarks, names, or copyrighted content.
- Finance, health, employment, housing, safety, education, legal, insurance, or other regulated/high-impact claims.

CLO output should be brief:

```text
Approved
Approved with notes
Blocked
Needs outside counsel
```

## 9. Ready-for-review gate

Before giving the CEO a review link:

1. Live link exists.
2. Review layer live-sync works.
3. CI is green, or the limitation is clearly stated.
4. Blockers are resolved or visible.
5. The first screen says what to review.
6. The CLO gate is handled when triggered.
7. The report is short.

## 10. Codex / repo rules

Before changing code:

1. Read repo instructions and docs.
2. Check `company/Company_Org.md` for routing/ownership when inside LindaData HQ/company work.
3. Inspect repo structure.
4. Preserve Lovable scaffold if the app started in Lovable.
5. Do not rebuild from scratch unless instructed.
6. Run available checks.
7. Report changed files, proof, failures, links, and CLO status when triggered.

## 11. Decision update rule

Update a durable source of truth when a decision affects future work:

- `Context.md`
- `company/Decision_Log.md`
- `company/Company_Org.md`
- `company/Workflows.md`
- relevant `agents/` file

Do not store sensitive legal notes, secrets, personal data, or private contracts in public docs.
