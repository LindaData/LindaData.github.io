# Context.md

**Company:** LindaData Agentic Company  
**Owner / CEO / Commander:** ChefHands  
**Last updated:** 2026-07-02  
**Purpose:** Track what the company is working on, what matters now, current project status, blockers, and links the CEO needs for daily review.

---

## Current operating priority

**Priority #1: HVAC Copilot / Field Copilot Pro.**

Everything else is secondary until the HVAC product has:

1. A professional field-operations UI.
2. A reliable review layer that works on every major route.
3. GitHub-backed review note sync, not local-only success.
4. Smoke-tested links and user flows.
5. Clear CEO review path from iPhone.

---

## Daily HQ behavior

The HQ page at `lindadata.github.io` should be the morning command center.

It should show:

- Current top priority.
- All active, blocked, paused, and closed projects.
- Direct links to apps, repos, issues, PRs, and review surfaces.
- The executive company structure.
- The four company OS files: Agents.md, Context.md, Memory.md, Skills.md.
- A command box to send work into the review/HQ inbox.
- Public-safe information only until real auth exists.

---

## Active projects

| Project | Status | Priority | Main repo/site | Notes |
|---|---|---:|---|---|
| HVAC Copilot / Field Copilot Pro | Active | P0 | `LindaData/field-copilot-pro` | Main product lane. Needs professional UI, review layer reliability, CI, and smoke tests. |
| Universal Review Layer OS | Active | P0 | Field Copilot review worker/issues | Shared feedback overlay and GitHub sync pattern for every UI project. |
| LindaData HQ Dashboard | Active | P1 | `LindaData/LindaData.github.io` | Public-safe command center and morning dashboard. |
| Agentic Company OS | Active | P1 | `Agents.md`, `Context.md`, `Memory.md`, `Skills.md` | Defines executives, roles, memory, and reusable workflows. |
| Southpaw Boxing | Paused | P2 | `lindadata.github.io/southpaw-boxing` | Boxing gym concept; resume after HVAC loop is stable. |
| Game Stat Pulse | Paused | P2 | `LindaData/game-stat-pulse` | Sports modeling/data app; return after HVAC. |
| LindaData Sports Hub | Paused | P2 | `LindaData/lindadata-sports-hub` | Lovable-built sports hub; NBA/MLB focus noted. |
| PawPath Dog Compass | Paused | P3 | `LindaData/pawpath-dog-compass` | Future review-layer port target. |
| Recycle Right Now | Paused | P3 | `lindadata.github.io/recycle-right-now-82` | Existing app remains available. |
| World Cup 2026 Betting Model | Paused | P3 | `LindaData/world-cup-2026-betting-model` | Modeling repo; not current top focus. |
| Ghostwriting / Note Taker | Backlog | P3 | Future Notion/doc workflow | Capture long-term notes for book/audio-book workflow. |
| Cloud VM / Codex Infra | Paused | P3 | Oracle VM / code-server plan | Resume when needed for heavier persistent dev. |

---

## Current known links

### HQ

- Live HQ: `https://lindadata.github.io/`
- Repo: `https://github.com/LindaData/LindaData.github.io`

### HVAC

- App: `https://lindadata.github.io/field-copilot-pro/app/today`
- Repo: `https://github.com/LindaData/field-copilot-pro`
- Lovable concept: `https://lovable.dev/projects/af718ecb-d533-4a9e-ae14-4de6e0f4d831`
- Review worker endpoint: `https://soft-unit-ba5d.sergio-mora.workers.dev/review-note`

### Other projects

- Southpaw: `https://lindadata.github.io/southpaw-boxing/`
- Recycle: `https://lindadata.github.io/recycle-right-now-82/?overlay=review`
- Game Stat Pulse repo: `https://github.com/LindaData/game-stat-pulse`
- Sports Hub repo: `https://github.com/LindaData/lindadata-sports-hub`
- PawPath repo: `https://github.com/LindaData/pawpath-dog-compass`
- World Cup repo: `https://github.com/LindaData/world-cup-2026-betting-model`

---

## Project status definitions

| Status | Meaning |
|---|---|
| Active | Work is moving now. |
| Blocked | Something must be fixed or provided before progress continues. |
| Paused | Valid project, but not today’s focus. |
| Backlog | Captured for later. |
| Closed | Done or intentionally stopped. |

---

## Review layer rule

The review layer must never show a final success state unless the webhook confirms the note reached GitHub.

Required states:

- Ready.
- Syncing.
- Live sync / submitted.
- Failed.
- Blocked.

Failure behavior:

- Preserve draft.
- Keep local recovery backup.
- Make the error understandable.
- Do not silently lose the note.

---

## Public/private boundary

The current HQ is public because GitHub Pages is public.

Allowed on public HQ:

- Public project names.
- Public repo links.
- Public app links.
- Status summaries.
- Public-safe workflow notes.

Not allowed on public HQ:

- Private personal notes.
- API keys or tokens.
- Private business data.
- Real financial details.
- Private emails/calendar content.
- Fake authentication that claims to be real.

Future private HQ can include real login/passkeys/Face ID-style unlock only after a backend/auth provider is configured.

---

## CEO review format

Use this format when reporting work:

```md
Status: Active / Blocked / Ready for Review / Done

Changed:
- ...

Tested:
- ...

Review:
- Link: ...
- Check: ...
```

---

## Decision log

### 2026-07-02 — LindaData HQ becomes the front door

Decision: `lindadata.github.io` is the public-safe command center for all active projects and the company OS.

Why: The CEO needs one page to check every morning with links, priorities, roles, and workflows.

### 2026-07-02 — HVAC stays priority #1

Decision: HVAC Copilot remains top priority until the layout and review layer are reliable.

Why: It is the highest-impact active build and has an existing repo, app surface, and review infrastructure.

### 2026-07-02 — Four Markdown files are the company OS

Decision: Agents.md, Context.md, Memory.md, and Skills.md are the source-of-truth docs for the agentic company.

Why: They make roles, context, preferences, and workflows reusable instead of recreated in every chat.
