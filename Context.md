# Context.md

**Company:** LindaData Agentic Company  
**Owner / CEO / Commander:** ChefHands  
**Last updated:** 2026-07-03  
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

The CLO division is now a standing review gate for any work that adds legal, privacy, compliance, contract, IP, telemetry, payment, authentication, regulated-topic, or AI-governance risk.

---

## Daily HQ behavior

The HQ page at `lindadata.github.io` should be the morning command center.

It should show:

- Current top priority.
- All active, blocked, paused, and closed projects.
- Direct links to apps, repos, issues, PRs, and review surfaces.
- The executive company structure, including the CLO division.
- The four company OS files: Agents.md, Context.md, Memory.md, Skills.md.
- A command box to send work into the review/HQ inbox.
- Public-safe information only until real auth exists.

---

## Active projects

| Project | Status | Priority | Main repo/site | Notes |
|---|---|---:|---|---|
| HVAC Copilot / Field Copilot Pro | Active | P0 | `LindaData/field-copilot-pro` | Main product lane. Needs professional UI, review layer reliability, CI, smoke tests, and CLO review for AI/user-data/auth claims. |
| Universal Review Layer OS | Active | P0 | Field Copilot review worker/issues | Shared feedback overlay and GitHub sync pattern for every UI project. CLO watches telemetry/logging/privacy risk. |
| LindaData HQ Dashboard | Active | P1 | `LindaData/LindaData.github.io` | Public-safe command center and morning dashboard. Keep public/private boundary honest. |
| Agentic Company OS | Active | P1 | `Agents.md`, `Context.md`, `Memory.md`, `Skills.md`, `agents/` | Defines executives, roles, memory, reusable workflows, and legal governance. |
| CLO Legal Division | Active | P1 | `Agents.md`, `Skills.md`, `agents/legal/README.md` | Legal, privacy, compliance, contract, IP, AI governance, and launch review system. |
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

### Company OS

- Root org file: `Agents.md`
- Root context: `Context.md`
- Root memory: `Memory.md`
- Root skills: `Skills.md`
- Agent library: `agents/`
- Legal division handbook: `agents/legal/README.md`

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

CLO check:

- Review what page context, user text, device info, URL, timestamp, logs, or identifiers are captured.
- Keep secrets and private notes out of public frontend code and public issue bodies.
- Use public-safe summaries in public repos unless a private backend/repo is configured.

---

## Public/private boundary

The current HQ is public because GitHub Pages is public.

Allowed on public HQ:

- Public project names.
- Public repo links.
- Public app links.
- Status summaries.
- Public-safe workflow notes.
- Public-safe legal/compliance checklists.

Not allowed on public HQ:

- Private personal notes.
- API keys or tokens.
- Private business data.
- Real financial details.
- Private emails/calendar content.
- Fake authentication that claims to be real.
- Sensitive legal analysis, private contracts, customer data, or confidential risk details.

Future private HQ can include real login/passkeys/Face ID-style unlock only after a backend/auth provider is configured and the CLO + CTO approve the data flow.

---

## Legal review rule

Use the CLO division when work involves any of these triggers:

| Trigger | Lead CLO agent | Output |
|---|---|---|
| Public app/site launch | Product Legal Review Agent | Launch risk notes, disclaimer needs, approval/blocker. |
| User data, telemetry, logs, uploads, auth, identity | Privacy & Data Protection Counsel Agent | Data map, minimization notes, privacy notice needs. |
| AI advice, AI decisions, model outputs, agent autonomy | AI Governance Counsel Agent | Human review gate, AI limitations, claims review. |
| Contracts, vendors, APIs, partnerships | Contracts Counsel Agent | Key obligations, risky clauses, escalation questions. |
| Repo licensing, copied code, generated assets, names/brands | IP & Open Source Counsel Agent | License/attribution notes, brand/IP risk. |
| Regulated topics: legal, finance, health, housing, employment, safety | General Counsel Agent + Compliance & Risk Agent | Risk classification, required disclaimer, outside-counsel flag. |
| Internal policies, agent roles, contractor/HR language | Employment & Org Counsel Agent | Policy notes and CHRO coordination. |

CLO output should be short: `Approved`, `Approved with notes`, `Blocked`, or `Needs outside counsel`.

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

For legal-sensitive work, add:

```md
CLO:
- Status: Approved / Approved with notes / Blocked / Needs outside counsel
- Risk: Low / Medium / High
- Notes: ...
```

---

## Decision log

### 2026-07-03 — CLO division added to LindaData OS

Decision: LindaData now includes a Chief Legal Officer division reporting directly to the CEO.

Why: Every project needs a standing legal, privacy, compliance, contract, IP, and AI-governance gate before risky public launches.

### 2026-07-03 — All LindaData asks route through org form

Decision: Future work should be treated as a LindaData ask and routed through the org system unless clearly personal/non-LindaData.

Why: The CEO wants consistent ownership, execution, QA, and review across tasks.

### 2026-07-02 — LindaData HQ becomes the front door

Decision: `lindadata.github.io` is the public-safe command center for all active projects and the company OS.

Why: The CEO needs one page to check every morning with links, priorities, roles, and workflows.

### 2026-07-02 — HVAC stays priority #1

Decision: HVAC Copilot remains top priority until the layout and review layer are reliable.

Why: It is the highest-impact active build and has an existing repo, app surface, and review infrastructure.

### 2026-07-02 — Four Markdown files are the company OS

Decision: Agents.md, Context.md, Memory.md, and Skills.md are the source-of-truth docs for the agentic company.

Why: They make roles, context, preferences, and workflows reusable instead of recreated in every chat.
