# LindaData Operating Context — Context.md

Version: 2026-07-03  
Owner: Chief of Staff  
Purpose: keep LindaData aligned, short, and easy to resume.

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

## 2. Global operating mandate

```text
From now on, EVERYTHING runs through the LindaData Company Org.
All work must align to the org structure before execution.
No random execution path.
No specialist-agent work without an executive owner.
No claim of done without QA/proof.
```

Default routing:

```text
ChefHands / CEO
→ Chief of Staff or correct executive owner
→ specialist agents
→ QA / proof
→ CEO-facing summary or review link
```

## 3. Standing communication preferences

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
| Company Org | Every meaningful task must reference `/company/Company_Org.md` for ownership and routing |
| Logs | Log important work in GitHub/docs, not memory only |
| Security | Protect private access material. Do not place private values in frontend, commits, logs, screenshots, or chat. |
| Cost | Free/local-first; no paid spend or auto-top-up without explicit approval |
| Lovable apps | Preserve Lovable scaffold unless CEO says to replace it |

## 4. Current operating facts

| Area | Current fact |
|---|---|
| Company | LindaData |
| CEO | ChefHands / Sergio |
| Control room | ChatGPT |
| Execution memory | GitHub |
| Main bounded builder | Codex |
| Canonical company org | `company/Company_Org.md` |
| Global mandate | Everything runs through Company Org and aligns to one executive owner |
| Canonical active app repo | `LindaData/field-copilot-pro` |
| HQ repo | `LindaData/LindaData.github.io` |
| HQ page | `https://lindadata.github.io/` |
| HQ registry | `hq/data/projects.json` |
| Link audit | `hq/LINK_AUDIT.md` |
| Older HVAC repo | `field-copilot-buddy` is history / ignore |
| Priority 1 | HVAC / Field Copilot unless explicitly changed |
| Mobile review | CEO is usually reviewing from iPhone |
| Review architecture | App review box → Cloudflare Worker → GitHub issue comments → ChatGPT/Codex action queue |
| Security model | Public-safe GitHub Pages shell; private data behind real auth when needed |
| Passkeys / Face ID | Only through a real backend challenge flow, not fake frontend security |

## 5. Active project board

As of 2026-07-03.

| Priority | Project | Owner | Status | Next action | Review ready |
|---:|---|---|---|---|---|
| 1 | HVAC Copilot | CTO + PRO + CDO + QA | Priority 1 active | Open Today app and review workspace; fix PR/review blockers first | Partial |
| 2 | Review Layer System | PRO + CTO + CSO + QA | Active reliability system | Keep live-sync proof as the release gate; no fake saved states | Partial |
| 3 | LindaData HQ Dashboard | Chief of Staff + CIO + CTO + PRO + QA | Root HQ organized; registry refreshed; link audit added | Use as morning command center and keep project links clean | Yes |
| 4 | Company Org / Agentic Company | Chief of Staff + CIO + CHRO | Canonical org file and agent docs live | Route every meaningful task through `Company_Org.md` | Yes |
| 5 | World Cup 2026 Forecasting Model | CDO + CTO | Live forecast link tracked | Hold unless sports/model lane restarts | Yes |
| 6 | Game Stat Pulse | CDO + CTO | Live app link tracked; work on hold | Hold until HVAC/review layer are stable | Yes |
| 7 | Southpaw / Boxing Site | PRO + CMO + CTO | Review-ready demo link moved to `/boxing-gym/`; older concept kept as reference | Hold unless CEO restarts this lane | Demo only |
| 8 | Recycle Right Now | PRO + CTO | Review link tracked; work on hold | Hold; keep link visible | Tracked |
| 9 | PawPath Preview | PRO + CTO | Preview link tracked | Hold unless review-layer testing restarts | Preview |
| 10 | Ghostwriting / Book Engine | Chief of Staff + CIO + CDO + Editorial | Planning | Choose storage/source capture rules later | No |
| 11 | Cloud / Codex / Infra Setup | CTO + CSO + CFO | Paused by CEO | Do not spend cycles until restarted | Paused |
| 12 | Money Transfer Colombia | Personal Assistant + CFO | Closed / reference | Archive from active work | Closed |

## 6. Review layer non-negotiables

Build once. Reuse everywhere.

Required behavior:

- Health check runs before and during review startup.
- UI states: `Live sync`, `Syncing`, `Failed`, `Blocked`.
- Capture button is disabled or shows error unless endpoint is live.
- Never show `saved` unless webhook returns success.
- Local browser storage can be temporary recovery only, not the final state.
- If offline or webhook fails, preserve draft text in the input field.
- Old unsynced local notes need a manual recovery path.

Inbox mapping:

| Area | Target |
|---|---|
| HVAC | `LindaData/field-copilot-pro` issue #45 |
| Recycling | `LindaData/field-copilot-pro` issue #57 |
| Shared review system | `LindaData/field-copilot-pro` issue #58 |
| HQ dashboard | `LindaData/field-copilot-pro` issue #61 |
| Southpaw / Boxing demo | currently routes to HQ inbox #61 unless dedicated issue is created |

## 7. Review layer mental model

```text
Review page = clean glass layer
Main page = artwork/paper underneath
Annotations = marker on glass
Implementation = only after CEO says to make the changes
```

Review notes become tasks. Tasks become changes only after approval.

## 8. Ready-for-review gate

Before giving the CEO a review link:

1. Live link exists.
2. Review layer live-sync works.
3. CI is green, or the limitation is clearly stated.
4. Blockers are resolved or visible.
5. The first screen says what to review.
6. The report is short.

## 9. Codex / repo rules

Before changing code:

1. Read repo instructions and docs.
2. Check `company/Company_Org.md` for routing/ownership when inside LindaData HQ/company work.
3. Inspect repo structure.
4. Preserve Lovable scaffold if the app started in Lovable.
5. Make the smallest useful change.
6. Test or document what could not be tested.
7. Report with proof links.
