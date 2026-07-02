# LindaData Operating Context — Context.md

Version: 2026-07-02  
Owner: Chief of Staff  
Purpose: keep the company aligned, short, and easy to resume.

## North star

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

## Standing communication preferences

| Preference | Rule |
|---|---|
| Brevity | Short, useful, no filler |
| Device | Assume iPhone/mobile unless told otherwise |
| Build instructions | Copy-pasteable and device-specific |
| Work reports | Status / Done / Found / Next / Need from you |
| Explanations | Explain simply when needed; avoid walls of text |
| Links | Give direct review links when possible |
| Questions | Avoid unnecessary clarification; make the safest useful assumption |
| Updates | Give short progress updates for long or tool-heavy work |
| Testing | Do not claim success without proof |
| Context | Context matters; check current project state before acting |
| Logs | Log important work in GitHub/docs, not memory only |
| Security | Never expose tokens, API keys, `.env`, credentials, screenshots of secrets, or browser-request secrets |
| Cost | Free/local-first; no paid spend or auto-top-up without explicit approval |
| Lovable apps | Preserve Lovable scaffold unless CEO says to replace it |

## Current operating facts

| Area | Current fact |
|---|---|
| Company | LindaData |
| CEO | ChefHands / Sergio |
| Control room | ChatGPT |
| Execution memory | GitHub |
| Main bounded builder | Codex |
| Canonical active app repo | `LindaData/field-copilot-pro` |
| HQ repo | `LindaData/LindaData.github.io` |
| Older HVAC repo | `field-copilot-buddy` is history / ignore |
| Priority 1 | HVAC / Field Copilot unless explicitly changed |
| Mobile review | CEO usually reviews from iPhone |
| Review architecture | App review box → Cloudflare Worker → GitHub issue comments → ChatGPT/Codex action queue |
| Security model | Public-safe GitHub Pages shell; private data behind real auth when needed |
| Passkeys / Face ID | Only through a real backend challenge flow; never fake frontend security |

## Active project board

As of 2026-07-02.

| Priority | Project | Owner | Status | Morning check |
|---:|---|---|---|---|
| 1 | HVAC Copilot / Field Copilot Pro | CTO + PRO + CDO + QA | Hot | Open `/app/today`; check review button, PR #59/#60, issue #68 |
| 2 | Universal Review Layer OS | PRO + CTO + CSO + QA | Hot | Check issues #58/#62/#67; no local-only saved states |
| 3 | LindaData HQ / Founder Dashboard | Chief of Staff + CIO + CTO | Live root | Open `lindadata.github.io`; send commands to inbox #61 |
| 4 | LindaData Agentic Company OS | Chief of Staff + CIO + CHRO + CTO | Active | Use `Agents.md`, `Context.md`, `Workflows.md`, `Decision_Log.md` |
| 5 | World Cup 2026 Forecasting Model | CDO + CTO | Active / secondary | Keep visible; do not outrank HVAC |
| 6 | Game Stat Pulse | CDO + PRO + CTO | Active / secondary | Data approval before models |
| 7 | Game Stat Lab | CDO + CTO | Hold | Document before active work |
| 8 | LindaData Sports Hub | CDO + CMO + CTO | Hold | Resume only after sports lane restarts |
| 9 | PawPath Dog Compass | PRO + CTO + CCO | Hold | Later review-layer port target |
| 10 | PawPath Preview | PRO + CTO | Hold | Keep as public preview |
| 11 | Recycle Right Now | PRO + CTO + CCO | Hold | Return after HVAC review reliability |
| 12 | Southpaw / Boxing Gym Site | CMO + PRO + CTO | Hold | Resume after HVAC / review layer |
| 13 | Ghostwriting / Book Engine | Chief of Staff + CIO + CDO | Planning | Capture ideas only; choose durable storage later |
| 14 | Cloud / Codex / Infra Setup | CTO + CFO + CSO | Paused | Ignore unless infrastructure blocks active work |
| 15 | Field Copilot Buddy | CTO | Legacy / closed | Do not use except for history |
| 16 | Basics Analysis with COVID Data | CDO | Archive | Ignore |
| 17 | Closed Personal Finance Helper | Personal Assistant + CFO | Closed | Ignore unless restarted |
| 18 | Passkey / Face ID Private HQ Gate | CSO + CTO | Security backlog | Do not add private data before real auth |

## Review layer non-negotiables

Build once. Reuse everywhere.

Required behavior:

- Health check runs before and during review startup.
- UI states: `Live sync`, `Syncing`, `Failed`, `Blocked`.
- Capture button is disabled or shows an error unless endpoint is live.
- Never show `saved` unless webhook returns success.
- Never use `localStorage` as final state.
- If offline or webhook fails, preserve draft text in the input field.
- Old unsynced local notes need a manual recovery path.

Required payload shape:

```json
{
  "repo": "LindaData/field-copilot-pro",
  "sourceRepo": "LindaData/LindaData.github.io",
  "targetIssue": 61,
  "project": "hvac-copilot",
  "route": "/app/today",
  "pageLabel": "Today",
  "url": "https://...",
  "viewport": "390x844",
  "userAgent": "string",
  "timestamp": "ISO-8601",
  "noteKind": "bug|ux|copy|data|idea|approval",
  "priority": "low|medium|high|blocker",
  "note": "string"
}
```

## Morning dashboard rules

The root `lindadata.github.io` page should help the CEO answer:

1. What do I open first?
2. What needs review?
3. What failed?
4. What is paused/closed?
5. What is the one next action?

Dashboard sections:

- Morning scan
- Quick actions
- HQ command console
- Live review feed
- All projects
- One-screen project table
- Executive/company map
- Workflow engines
- Public-safe security posture

## Known security constraint

GitHub Pages is static public hosting. Static frontend gates do not protect private data.

Do:
- Show public-safe metadata and links.
- Link to private repos/issues only as navigation.
- Keep secrets out of code, screenshots, logs, and committed files.

Do not:
- Commit tokens or credentials.
- Add fake Face ID / passkey security.
- Put private notes into the public page.
