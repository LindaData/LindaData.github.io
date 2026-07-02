# LindaData Operating Context — Context.md

Version: 2026-07-02  
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

Default style:

```text
No wall of text.
Mobile-first.
ChatGPT-first.
Review links over explanations.
Brief but complete.
```

## 2. Standing communication preferences

| Preference | Rule |
|---|---|
| Brevity | Short, useful, no filler |
| Device | Assume iPhone/mobile unless told otherwise |
| Build instructions | Copy-pasteable and device-specific |
| Work reports | `Status / Done / Found / Next / Need from you` |
| Explanations | Explain simply when needed; avoid walls of text |
| Links | Give direct review links when possible |
| Questions | Do not ask unnecessary clarification; make the safest useful assumption |
| Updates | Give short progress updates only for long or tool-heavy work |
| Testing | Do not claim success without proof |
| Context | Context matters; check prior project state before acting |
| Logs | Log important work in GitHub/docs, not memory only |
| Security | Protect private access material. Do not place private values in the frontend, commits, logs, screenshots, or chat. |
| Cost | Free/local-first; no paid spend or auto-top-up without explicit approval |
| Lovable apps | Preserve Lovable scaffold unless CEO says to replace it |

## 3. Current operating facts

| Area | Current fact |
|---|---|
| Company | LindaData |
| CEO | ChefHands / Sergio |
| Control room | ChatGPT |
| Execution memory | GitHub |
| Main bounded builder | Codex |
| Canonical active app repo | `LindaData/field-copilot-pro` |
| HQ repo | `LindaData/LindaData.github.io` |
| Older repo | `field-copilot-buddy` is history / ignore |
| Priority 1 | HVAC / Field Copilot unless explicitly changed |
| Mobile review | CEO is usually reviewing from iPhone |
| Review architecture | App review box → Cloudflare Worker → GitHub issue comments → ChatGPT/Codex action queue |
| Security model | Public-safe GitHub Pages shell; private data behind real auth when needed |
| Passkeys / Face ID | Only through a real backend challenge flow, not fake frontend security |

## 4. Active project board

As of 2026-07-02.

| Priority | Project | Owner | Status | Next action | Review ready |
|---:|---|---|---|---|---|
| 1 | Review Layer System | CTO + PRO + CSO + QA | Reliability work active | Prove notes land as GitHub comments; implement shared client + Worker contract | No |
| 2 | HVAC Copilot | CTO + PRO + CDO + QA | PR #59 draft; CI failed at Test. PR #60 desktop lane follows #59 | Fix PR #59 tests, finish attachment UI, then provide clean review link | No |
| 3 | LindaData Agentic Company | Chief of Staff + CTO + QA | PR #47 open; TypeScript CI failed though tests passed | Fix TypeScript and expose HQ command view | No |
| 4 | Central HQ / Work Dashboard | Chief of Staff + CIO + PRO + CTO | Existing root Review Hub, but missing command needs | Add `/hq`, `data/projects.json`, status gates, links, webhook health | Prototype only |
| 5 | Southpaw Boxing Site | PRO + CMO + CTO | Static concept exists | Replace local-only review drawer with shared live-sync layer | No |
| 6 | Cloud / Codex / Infra Setup | CTO | Paused by CEO | Do not spend cycles until restarted | Paused |
| 7 | Money Transfer | Personal Assistant / CFO | Closed by CEO | Archive from active dashboard | Closed |
| 8 | Ghostwriting / Book Engine | Chief of Staff + CIO + CDO + Editorial | Planning | Add HQ lane; choose storage/source capture rules later | Planning |

## 5. Review layer non-negotiables

Build once. Reuse everywhere.

Required behavior:

- Health check runs before and during review startup.
- UI states: `Live sync`, `Syncing`, `Failed`, `Blocked`.
- Capture button is disabled or shows error unless endpoint is live.
- Never show `saved` unless webhook returns success.
- Local browser storage can be temporary recovery only, not the final state.
- If offline or webhook fails, preserve draft text in the input field.
- Old unsynced local notes need manual recovery path.

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

## 6. Ready-for-review gate

Before giving the CEO a review link:

1. Live link exists.
2. Review layer live-sync works.
3. CI is green, or the limitation is clearly stated.
4. Blockers are resolved or visible.
5. The first screen says what to review.
6. The report is short.

## 7. Codex / repo rules

Before changing code:

1. Read repo instructions and docs.
2. Inspect repo structure.
3. Preserve Lovable scaffold if the app started in Lovable.
4. Make the smallest useful change.
5. Run lint, tests, TypeScript checks, and build where available.
6. Report files changed, commands run, passed checks, failed checks, risks, and review link if ready.

Codex is bounded execution. ChatGPT owns architecture, QA, research, review, prompt writing, issue writing, and prioritization.

## 8. Tool router

| Need | Use first | Notes |
|---|---|---|
| Strategy / architecture | ChatGPT | Short, clear, context-aware |
| Code changes | Codex + GitHub | Small PRs, tests, logs |
| Repo truth | GitHub | Source of truth for PRs/issues/docs |
| UI scaffold | Lovable / Replit / Canva | Use when it improves speed or demo quality |
| Current facts | Web | Required for facts that may have changed |
| Uploaded docs/images | File Library / Drive | Cite source when answering from files |
| Data / artifacts | Python / artifact tools | Create files, checks, tables, charts |
| Calendar / email / contacts | Connected assistant tools | Read or act only when requested |

## 9. Standard CEO report

```text
Status: green / yellow / red

Done:
- ...

Found:
- ...

Next:
- ...

Need from you:
- ...
```

## 10. Assumptions to confirm later

| Acronym | Current meaning |
|---|---|
| PRO | Product & Review Officer |
| CHO | Chief Health & Happiness Officer |
| CCO | Chief Customer Officer |
| CSO | Chief Security Officer |
| CIO | Chief Information Officer |
| CDO | Chief Data Officer |

## 11. Update log

| Date | Update | Owner |
|---|---|---|
| 2026-07-02 | Created first-pass company operating context from current LindaData HQ, review layer, HVAC, agent company, and master brain docs | Chief of Staff |
