# LindaData Decision Log — Decision_Log.md

Version: 2026-07-02  
Owner: Chief of Staff + CIO  
Purpose: durable record of decisions that affect future work.

## How to use this file

Add a decision when it changes future behavior, priority, architecture, security posture, cost, repo structure, or user workflow.

Decision statuses:

- `active`
- `superseded`
- `closed`
- `paused`
- `needs confirmation`

## Current decisions

### 2026-07-02 — Create the company operating files

Decision:
- Create four Markdown files:
  - `Agents.md`
  - `Context.md`
  - `Workflows.md`
  - `Decision_Log.md`

Reason:
- The company needs a durable operating system that ChatGPT, Codex, GitHub, and future agents can reference.

Owner:
- Chief of Staff + CIO

Impact:
- These files become the starting source of truth for agent structure, context, execution, and decisions.

Status:
- active

---

### 2026-07-02 — CEO authority model

Decision:
- CEO / ChefHands is final authority.
- Chief officers report to CEO.
- Chief of Staff and Personal Assistant report to CEO.
- All non-executive agents report to a chief officer.

Reason:
- Keeps the company clear and prevents chaotic multi-agent chatter.

Owner:
- Chief of Staff

Impact:
- Worker agents do not speak directly to CEO unless routed.

Status:
- active

---

### 2026-07-02 — Executive acronyms

Decision:
- `CDO` = Chief Data Officer
- `CTO` = Chief Technology Officer
- `CFO` = Chief Financial Officer
- `CMO` = Chief Marketing Officer
- `COO` = Chief Operating Officer
- `PRO` = Product & Review Officer
- `CHRO` = Chief Human Resources Officer
- `CHO` = Chief Health & Happiness Officer
- `CCO` = Chief Customer Officer
- `CSO` = Chief Security Officer
- `CIO` = Chief Information Officer

Reason:
- The user named the officer acronyms; these are practical operating defaults.

Owner:
- Chief of Staff

Impact:
- PRO owns product and review readiness.
- CSO owns safe access boundaries.
- Strategy remains shared unless a separate Chief Strategy Officer is created.

Status:
- needs confirmation

---

### 2026-07-02 — Current priority stack

Decision:
- Priority order:
  1. Review Layer System
  2. HVAC Copilot
  3. LindaData Agentic Company
  4. Central HQ / Work Dashboard
  5. Southpaw Boxing Site
  6. Cloud / Codex / Infra Setup — paused
  7. Money Transfer — closed
  8. Ghostwriting / Book Engine — planning

Reason:
- Matches the current LindaData HQ and work-packet direction.

Owner:
- Chief of Staff

Impact:
- Paused or closed work should not take cycles unless restarted.

Status:
- active

---

### 2026-07-02 — HVAC / Field Copilot remains priority 1 by default

Decision:
- HVAC / Field Copilot is priority 1 unless the CEO explicitly changes priority.

Reason:
- It is the main active product and current execution focus.

Owner:
- CTO + PRO

Impact:
- New work should not distract from HVAC unless explicitly reprioritized.

Status:
- active

---

### 2026-07-02 — Review layer architecture

Decision:
- Review flow should be: review box in app → Cloudflare Worker webhook → GitHub issue comments → ChatGPT/Codex action queue.

Reason:
- It is cheap/free-first, repo-native, and usable from iPhone.

Owner:
- PRO + CTO + CSO

Impact:
- Browser code must not hold privileged access material.
- Notes land in durable GitHub inboxes.
- Review layer can be reused across projects.

Status:
- active

---

### 2026-07-02 — Local browser storage is not final review state

Decision:
- Browser local storage can be temporary recovery only.
- It cannot be the final state for review notes.

Reason:
- CEO needs notes to land somewhere ChatGPT/Codex can read and act on.

Owner:
- PRO + CSO + QA

Impact:
- Any local-only review drawer is not ready for CEO review.

Status:
- active

---

### 2026-07-02 — Security and cost guardrails

Decision:
- Keep privileged access material out of the frontend, logs, commits, screenshots, and chat.
- No paid cloud/API spend or auto-top-up without explicit approval.
- Prefer free/local-first proof-of-concept work before paid infrastructure.

Reason:
- Protect LindaData and keep costs controlled.

Owner:
- CSO + CFO

Impact:
- Any private-access or cost-impacting work escalates first.

Status:
- active

---

### 2026-07-02 — Preserve Lovable scaffolds

Decision:
- For apps that began in Lovable, preserve the initial Lovable architecture/scaffold unless CEO explicitly replaces it.

Reason:
- Lovable output is treated as the approved baseline when it exists.

Owner:
- CTO + PRO

Impact:
- Do not rebuild Lovable apps from scratch without explicit approval.

Status:
- active

---

### 2026-07-02 — Root HQ becomes the morning command center

Decision:
- `https://lindadata.github.io/` is the public-safe LindaData morning HQ.
- `/hq` redirects to the root HQ.
- Project registry lives at `/hq/data/projects.json`.
- Company docs live under `/company/`.

Reason:
- CEO needs one mobile-first dashboard to check every morning.

Owner:
- Chief of Staff + CIO + CTO + PRO

Impact:
- Root HQ must show visible projects, active/paused/closed states, review links, command input, company docs, workflow rules, and security posture.

Status:
- active
