# LindaData Context.md

**Owner / CEO / Commander:** ChefHands  
**Last updated:** 2026-07-02  
**Purpose:** Public-safe working context for the LindaData HQ. This is the page-level source of truth for current priorities, active projects, blockers, and review links.

---

## 1. Current Command Rule

**HVAC / Field Copilot is priority #1 unless ChefHands explicitly changes priority.**

Everything else should stay visible but secondary until the HVAC layout and review layer are reliable.

---

## 2. Active Work Board

| Priority | Project | Status | Current need |
|---:|---|---|---|
| 1 | HVAC / Field Copilot Pro | Active / hot | Polish field-ops UI, keep review layer reliable, smoke test all pages. |
| 2 | Universal Review Layer System | Active / hot | Make the feedback button work across every UI, route, and page type. |
| 3 | LindaData HQ Dashboard | Active | Make lindadata.github.io the morning command center. |
| 4 | LindaData Agentic Company OS | Active | Keep Agents, Context, Memory, and Skills connected to the HQ. |
| 5 | Southpaw Boxing Gym | Paused | Resume after HVAC review loop is stable. |
| 6 | Game Stat Pulse / Sports Hub / World Cup model | Paused | Keep visible; return after top build priorities. |
| 7 | PawPath Dog Compass | Paused | Use later as a review-layer port target. |
| 8 | Recycle Right Now | Paused | Keep as an available app; not current top focus. |
| 9 | Cloud / Codex / Infra | Paused | Resume when needed for longer-running build work. |

---

## 3. Main Repos and Links

| Area | Link |
|---|---|
| HQ site | https://lindadata.github.io |
| HQ repo | https://github.com/LindaData/LindaData.github.io |
| HVAC repo | https://github.com/LindaData/field-copilot-pro |
| HVAC app | https://lindadata.github.io/field-copilot-pro/app/today |
| Game Stat Pulse repo | https://github.com/LindaData/game-stat-pulse |
| World Cup model repo | https://github.com/LindaData/world-cup-2026-betting-model |
| PawPath preview repo | https://github.com/LindaData/pawpath-dog-compass-preview |
| Recycle app | https://lindadata.github.io/recycle-right-now-82/?overlay=review |

---

## 4. HQ Page Requirements

The HQ page should be:

- Mobile-first and easy to use from iPhone.
- Professional enough to be the front door for LindaData work.
- Clear about current priority, active projects, paused projects, and next actions.
- Built around direct links, status cards, and review actions.
- Public-safe on GitHub Pages.
- Ready for future real auth/passkey/Face ID style login through a backend provider.
- Honest about what is verified versus what is planned.

---

## 5. Review Layer Requirements

Review layer must:

1. Work on all major pages/routes.
2. Use a server-side webhook, not a browser-stored final state.
3. Send feedback into GitHub issue comments or an approved review inbox.
4. Preserve a recovery draft if sync fails.
5. Show clear states: Ready, Syncing, Live sync, Failed, Blocked.
6. Include page context: route, URL, timestamp, viewport, and project.
7. Be smoke-tested from random pages before saying it works.

---

## 6. Daily Morning HQ Flow

When ChefHands opens the HQ each morning, the page should answer:

1. What is the top priority?
2. What is active, blocked, paused, or done?
3. What link should be opened first?
4. What needs review?
5. What can be ignored today?
6. What command needs to be sent into the system?

---

## 7. Update Rules

Update this file when:

- A project changes status.
- A repo/link changes.
- A new project starts.
- A workflow becomes repeatable and should move into Skills.md.
- A communication preference becomes durable and should move into Memory.md.

Do not store secrets, private user data, API keys, passwords, tokens, or sensitive business details here.
