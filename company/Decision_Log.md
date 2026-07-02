# LindaData Decision Log — Decision_Log.md

Version: 2026-07-02  
Owner: Chief of Staff + CIO  
Purpose: durable record of decisions that affect future work.

## How to use this file

Add a decision when it changes future behavior, priority, architecture, security, cost, repo structure, or user workflow.

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
- Keeps the system clear and prevents chaotic multi-agent chatter.

Owner:
- Chief of Staff

Impact:
- Worker agents do not speak directly to CEO unless routed.

Status:
- active

---

### 2026-07-02 — Executive acronyms

Decision:
- Use these default meanings:
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
- The user specified the acronyms but not every expansion. These are practical defaults for LindaData’s current work.

Owner:
- Chief of Staff

Impact:
- `PRO` owns product and review readiness.
- `CSO` owns security, secrets, auth, and safe deployment.
- Strategy is currently split across CEO, COO, CFO, CMO, and Chief of Staff unless a separate Chief Strategy Officer is created.

Status:
- needs confirmation

---

### 2026-07-02 — HVAC / Field Copilot remains priority 1

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

### 2026-07-02 — Root site becomes the morning HQ

Decision:
- `https://lindadata.github.io/` is the root Founder HQ page.
- It should show the morning scan, command console, all projects, company files, workflow engines, and public-safe security posture.

Reason:
- The CEO needs one page to check every morning.

Owner:
- Chief of Staff + CIO + CTO + PRO

Impact:
- The old root page is replaced by the full morning dashboard.
- `LindaData/LindaData.github.io` now stores the company files under `/company/`.
- `data/projects.json` stores the portfolio index.

Status:
- active

---

### 2026-07-02 — All known LindaData projects remain visible

Decision:
- The HQ should list active, hot, hold, paused, closed, legacy, and planning projects.

Reason:
- The CEO should not have to remember which repo or lane exists.

Owner:
- Chief of Staff + CIO

Impact:
- Paused/closed work stays visible but should not steal attention.
- HVAC and review-layer reliability stay pinned first.

Status:
- active

---

### 2026-07-02 — Review layer architecture

Decision:
- Review flow should be:

```text
Review box in app
→ Cloudflare Worker webhook
→ GitHub issue comments
→ ChatGPT/Codex action queue
```

Reason:
- It is cheap/free-first, repo-native, secure, and usable from iPhone.

Owner:
- PRO + CTO + CSO

Impact:
- No direct GitHub token in browser.
- Notes land in durable GitHub inboxes.
- Review layer can be reused across projects.

Status:
- active

---

### 2026-07-02 — No localStorage as final review state

Decision:
- `localStorage` can be a temporary draft/cache only.
- It cannot be the final state for review notes.

Reason:
- The CEO needs notes to land somewhere ChatGPT/Codex can read and act on.

Owner:
- PRO + CSO + QA

Impact:
- Southpaw, Recycling, PawPath, and any other local-only review drawer are not fully review-ready until live sync is proven.

Status:
- active

---

### 2026-07-02 — Public-safe HQ until real auth exists

Decision:
- The root GitHub Pages HQ must stay public-safe.
- Private data waits for a real auth-backed HQ.
- Do not create fake Face ID/passkey security in static JavaScript.

Reason:
- GitHub Pages is public static hosting. Any sensitive data committed to the public Pages repo is public.

Owner:
- CSO + CTO

Impact:
- The current dashboard can show project metadata and links.
- Private details require the auth project tracked in issue #66.

Status:
- active

---

### 2026-07-02 — Security and cost guardrails

Decision:
- Never expose secrets, tokens, API keys, credentials, `.env` contents, or secret screenshots in chat, frontend code, logs, commits, or browser requests.
- No paid cloud/API spend or auto-top-up without explicit approval.
- Prefer free/local-first proof of concept work before paid infrastructure.

Reason:
- Protect LindaData and keep costs controlled.

Owner:
- CSO + CFO

Impact:
- Any secret/cost work escalates before action.

Status:
- active

---

### 2026-07-02 — Preserve Lovable scaffolds

Decision:
- For apps that began in Lovable, preserve the initial Lovable architecture/scaffold unless CEO explicitly replaces it.

Reason:
- Lovable output is treated as an approved baseline when it exists.

Owner:
- CTO + PRO

Impact:
- Do not rebuild Lovable projects from scratch unless explicitly told.

Status:
- active
