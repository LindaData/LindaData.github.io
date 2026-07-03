# Skills.md

**Company:** LindaData Agentic Company  
**Owner / CEO / Commander:** ChefHands  
**Last updated:** 2026-07-03  
**Purpose:** Store repeatable workflows, programming practices, review checklists, and reusable operating procedures so hard work does not need to be recreated from scratch.

---

## Skill format

Each skill should follow this structure:

```md
## Skill: Name

**Use when:** ...  
**Lead executive:** ...  
**Specialists:** ...  
**Inputs needed:** ...  
**Steps:**
1. ...
2. ...
3. ...

**Definition of done:** ...  
**CEO output:** ...
```

---

## Skill: LindaData ask form routing

**Use when:** The CEO asks for any task, build, research, review, setup, decision, repo change, workflow, file, or project action.  
**Lead executive:** Chief of Staff  
**Specialists:** Intake Triage Agent, Executive Coordinator, Source-of-Truth Agent, relevant chief officer

**Default form:**

| Field | Required behavior |
|---|---|
| Ask | State the actual desired outcome. |
| LindaData priority | P0/P1/P2/P3 and why it matters now. |
| Executive owner | Assign one lead chief officer. |
| Supporting agents | Assign specialists needed to execute. |
| Target asset | Name repo, site, doc, dashboard, workflow, issue, or file. |
| Required context | Check Context.md, Memory.md, Skills.md, Agents.md, and relevant `agents/` files. |
| Execution plan | Use the smallest practical path. |
| QA / acceptance test | Define what must be checked before saying done. |
| Output | Provide link, file, summary, PR, issue, checklist, or next action. |
| CLO gate | Mark `Not needed`, `Review required`, `Approved`, `Blocked`, or `Needs outside counsel`. |

**Steps:**
1. Treat the request as a LindaData ask unless it is clearly personal/non-LindaData.
2. Route through the org system: Chief of Staff -> lead executive -> specialist agents.
3. Check current project context before asking the CEO for information that already exists.
4. Identify whether the CLO gate is triggered.
5. Execute directly with available tools when safe.
6. Report in the CEO format: Status, Changed, Tested, Review, and CLO when relevant.
7. Update Context.md, Memory.md, Skills.md, or `agents/` only for durable changes.

**Definition of done:** The task has an owner, context, execution path, QA standard, output, and legal gate status when relevant.  
**CEO output:** Brief status block with links and what to review.

---

## Skill: Universal task intake

**Use when:** The CEO asks for any new task, build, research, review, setup, or decision.  
**Lead executive:** Chief of Staff  
**Specialists:** Intake Triage Agent, Priority Manager, Source-of-Truth Agent

**Steps:**
1. Identify the outcome the CEO wants.
2. Check Context.md and Memory.md before asking questions.
3. Use the LindaData ask form by default.
4. Decide the lead executive.
5. Decide whether tools are needed: GitHub, Codex, web, files, Gmail, Calendar, Python, Notion, Canva, etc.
6. Check whether the CLO division must review the work.
7. If the task is simple, answer directly.
8. If the task is complex, give a short status update and execute.
9. Log durable decisions in Context.md.

**Definition of done:** The task has an owner, status, next action, and legal gate status if needed.  
**CEO output:** Short summary with direct next step.

---

## Skill: GitHub / Codex repo change

**Use when:** Code needs to be inspected, fixed, built, or deployed.  
**Lead executive:** CTO  
**Specialists:** Software Architect, Full-Stack Engineer, QA Automation Engineer, Security Engineer, Release Manager, CLO if legal/privacy risk is triggered

**Steps:**
1. Identify repo, branch, issue, and deploy target.
2. Inspect repo structure.
3. Read README, docs, package files, config files, and agent instructions.
4. Preserve existing architecture and Lovable scaffold if present.
5. Make the smallest useful fix.
6. Use a branch/PR when appropriate; direct commit only when it is clearly safe or explicitly expected.
7. Run available checks: install, lint, typecheck, tests, build, smoke test.
8. Confirm no secrets are exposed.
9. Check whether the change adds data collection, auth, telemetry, AI claims, payments, contracts, IP/licensing, or regulated claims; if yes, route to CLO.
10. Summarize exact changes and exact test results.
11. Give the CEO the review link and the specific item to test.

**Definition of done:** Build passes or failures are clearly reported, changed path is smoke-tested, and CLO gate is handled when triggered.  
**CEO output:** Link + what changed + what passed + what to review.

---

## Skill: Review layer implementation

**Use when:** A website/app needs CEO feedback directly on the page.  
**Lead executive:** CTO  
**Specialists:** Review Layer Engineer, Backend Engineer, Security Engineer, QA Automation Engineer, Privacy & Data Protection Counsel Agent

**Preferred architecture:**

```text
Floating Review Button
-> Review Overlay / Form
-> Server-side webhook endpoint
-> GitHub issue comment or review inbox
-> Agent reads note and fixes
```

**Steps:**
1. Add an obvious review button that works on all routes.
2. Include page context in each submission: URL, route, title, timestamp, note, app/project, viewport.
3. Submit to a server-side webhook.
4. Keep GitHub token and secrets server-side.
5. Show states: Ready, Syncing, Live sync, Failed, Blocked.
6. Do not show saved/success unless the webhook succeeds.
7. Preserve the draft on failure.
8. Review what telemetry/log fields are captured and whether public issue bodies are safe.
9. Smoke test homepage and at least one non-home route.
10. Confirm the note appears in GitHub.

**Definition of done:** The CEO can submit feedback from a random page, the note appears in the review inbox/GitHub, and captured data is public-safe or properly private.  
**CEO output:** Test link + pages tested + sample received note summary + CLO/privacy note.

---

## Skill: UI / UX review

**Use when:** A site/app needs to look professional and be easy to use.  
**Lead executive:** CMO + CCO  
**Specialists:** Creative Director, UX Empathy Agent, Accessibility Advocate, Frontend Engineer, Product Legal Review Agent when claims/disclaimers are present

**Steps:**
1. Identify the target user and main job-to-be-done.
2. Check whether the page explains itself within five seconds.
3. Review mobile first.
4. Review desktop second.
5. Check navigation, hierarchy, buttons, spacing, copy, and visual polish.
6. Check accessibility basics: readable text, contrast, focus, labels, tap targets.
7. Compare against best-in-class references without copying protected branding.
8. Review public claims for overpromising, regulated advice, or missing disclaimers.
9. Return ranked fixes: P0 broken, P1 important, P2 polish.

**Definition of done:** The page is easier to understand and use, especially on iPhone, with risky public claims flagged.  
**CEO output:** Short ranked list + review link.

---

## Skill: Deployment smoke test

**Use when:** A site is deployed or a key feature is fixed.  
**Lead executive:** COO  
**Specialists:** Release Manager, QA Automation Engineer, Site Reliability Engineer, Product Legal Review Agent when launch risk is triggered

**Steps:**
1. Open production/staging link.
2. Confirm page loads without a blank screen.
3. Check console/build logs if available.
4. Test the main user flow.
5. Test mobile viewport.
6. Test one non-homepage route.
7. Test refresh on nested route.
8. Test forms/buttons involved in the change.
9. Confirm failure states are understandable.
10. Confirm legal/privacy disclaimers, data notices, and public/private boundaries if triggered.
11. Record pass/fail.

**Definition of done:** Critical user path works on the deployed site or blockers are clearly named.  
**CEO output:** Pass/fail list with direct review link.

---

## Skill: Bug triage and fix

**Use when:** The CEO reports something broken, confusing, or unreliable.  
**Lead executive:** CTO  
**Specialists:** QA Automation Engineer, Software Architect, Relevant Engineer

**Steps:**
1. Restate the bug in one sentence.
2. Identify expected vs actual behavior.
3. Reproduce or inspect evidence.
4. Locate likely owner area: frontend, backend, webhook/API, auth/secrets, deployment, data.
5. Patch the smallest root cause.
6. Add or adjust a test if practical.
7. Smoke test the exact flow the CEO used.
8. Report whether it works now.

**Definition of done:** The original failure path has been tested after the fix.  
**CEO output:** It works now only if verified; otherwise not yet plus what remains.

---

## Skill: Data pipeline build

**Use when:** A project needs ingestion, cleaning, APIs, CSVs, databases, or modeling prep.  
**Lead executive:** CDO  
**Specialists:** Data Architect, Data Engineer, Analytics Engineer, Data Quality Analyst, Statistician, Privacy & Data Protection Counsel Agent when user/private/third-party data is involved

**Steps:**
1. Define the data source and access pattern.
2. Confirm secrets/API keys stay server-side.
3. Define raw, staged, cleaned, and analytics layers.
4. Create schema/data dictionary.
5. Add freshness and quality checks.
6. Create sample export/download if reviewers need it.
7. Document source limitations.
8. Check data rights, retention, consent, and third-party terms when relevant.
9. Keep modeling separate from raw collection until data quality is reliable.

**Definition of done:** Data is visible, validated, documented, legally usable at the current project stage, and ready for analysis/modeling.  
**CEO output:** Data status + sample link/download + known gaps.

---

## Skill: Statistical / modeling review

**Use when:** A question needs statistics, modeling, experiments, prediction, or inference.  
**Lead executive:** CDO  
**Specialists:** Statistician, Data Scientist, ML Engineer, Data Quality Analyst, AI Governance Counsel Agent when model output affects users or public claims

**Steps:**
1. Define the outcome and decision being supported.
2. Separate descriptive analysis, causal inference, and prediction.
3. Check data quality and leakage risks.
4. Establish a baseline model first.
5. Define train/test or validation method.
6. Select metrics based on the decision.
7. Report uncertainty and limits clearly.
8. Check for bias, high-impact decisions, regulated claims, and human-review needs when model output affects people or users.
9. Avoid overbuilding before data is trustworthy.

**Definition of done:** Model or analysis is explainable, tested, aligned to a decision, and legally/governance-aware when public or user-impacting.  
**CEO output:** Recommendation + confidence + next analysis.

---

## Skill: API integration

**Use when:** A project needs third-party data, webhooks, auth, or external services.  
**Lead executive:** CTO + CDO  
**Specialists:** API Integration Engineer, Backend Engineer, Security Engineer, Data Engineer, Contracts Counsel Agent, Privacy & Data Protection Counsel Agent

**Steps:**
1. Read official/current API docs.
2. Confirm auth method and rate limits.
3. Review terms, data rights, storage limits, attribution, and prohibited use when relevant.
4. Keep keys server-side.
5. Build a thin integration layer.
6. Validate response shape.
7. Handle errors, retries, and empty responses.
8. Log safely without leaking secrets or private data.
9. Add sample fixtures/tests when practical.

**Definition of done:** Integration works, handles failure, does not expose secrets, and known API/legal limits are documented.  
**CEO output:** Working endpoint/link + limits + next action.

---

## Skill: HQ dashboard update

**Use when:** The central HQ page needs new projects, links, statuses, or workflow changes.  
**Lead executive:** CIO + COO  
**Specialists:** Source-of-Truth Agent, Frontend Engineer, Project Manager, Documentation QA Agent, Product Legal Review Agent for public/private boundary checks

**Steps:**
1. Check Context.md for current projects.
2. Keep the public HQ public-safe.
3. Update the active project list with status and priority.
4. Add direct links to apps, repos, issues, PRs, docs, and review surfaces.
5. Keep HVAC first unless the CEO changes the priority.
6. Check that private data, fake auth claims, secrets, or sensitive legal notes are not exposed.
7. Test the page loads and the key links are present.
8. Report the live link and exact changes.

**Definition of done:** The CEO can open the HQ page and see the current work map without exposing private data.  
**CEO output:** Live HQ link + what changed.

---

## Skill: Mobile setup guide

**Use when:** The CEO needs to set up a technical tool from iPhone.  
**Lead executive:** Personal Assistant + CTO  
**Specialists:** Setup Guide Assistant, DevOps / Cloud Engineer, Link Assistant

**Steps:**
1. Assume iPhone unless told otherwise.
2. Give the exact link first.
3. Give one step at a time when the setup is complex.
4. Use plain words: tap, paste, copy, save.
5. Include exact values for variable names/secrets when needed.
6. Stop at natural checkpoints and ask what the screen shows only when needed.

**Definition of done:** The CEO can complete the setup without desktop assumptions.  
**CEO output:** Simple numbered steps.

---

## Skill: CLO legal / compliance review

**Use when:** A LindaData task involves public launch, user data, auth, telemetry, payments, contracts, third-party terms, IP/licensing, AI output, or regulated/high-impact claims.  
**Lead executive:** CLO  
**Specialists:** General Counsel Agent, Contracts Counsel Agent, Privacy & Data Protection Counsel Agent, AI Governance Counsel Agent, IP & Open Source Counsel Agent, Product Legal Review Agent, Compliance & Risk Agent, Legal Ops Agent

**Steps:**
1. Identify the product/workflow, target user, public/private surface, and launch stage.
2. Classify risk: Low / Medium / High.
3. Identify the trigger: data/privacy, AI governance, IP/open source, contract/vendor, regulated claim, authentication, telemetry, payment, or product claim.
4. Review whether public copy overpromises or implies professional legal/financial/medical/employment advice.
5. Review whether user data is minimized, disclosed, stored safely, and routed to the correct system.
6. Review whether secrets, sensitive notes, contracts, private data, or legal analysis appear in public repos/pages.
7. Create a concise output: Approved / Approved with notes / Blocked / Needs outside counsel.
8. Add required docs/checklists: disclaimer, privacy notice, terms note, risk register entry, license note, or escalation question.

**Definition of done:** The legal gate has a clear status, risk level, and exact blocker/approval notes.  
**CEO output:** CLO status + risk level + shortest useful next action.

---

## Skill: AI governance review

**Use when:** A project uses AI/agents/models to summarize, advise, rank, predict, triage, diagnose, score, automate, or make recommendations.  
**Lead executive:** CLO + CDO + CTO  
**Specialists:** AI Governance Counsel Agent, Data Scientist, Statistician, ML Engineer, Security Engineer, Product Legal Review Agent

**Steps:**
1. Define what the AI does and what it must not do.
2. Identify whether output affects users, customers, workers, technicians, finances, health, safety, employment, housing, legal rights, or other high-impact decisions.
3. Require human-in-the-loop review for high-impact or uncertain outputs.
4. Add limitations/disclaimers where needed.
5. Track source data quality, model limits, evaluation method, and known failure modes.
6. Avoid pretending the AI is certain when it is not.
7. Keep logs public-safe and avoid storing sensitive prompts/outputs in public systems.
8. Define escalation: when the system says `I do not know`, routes to expert review, or blocks unsafe advice.

**Definition of done:** AI behavior, limits, review gates, and user-facing claims are documented and testable.  
**CEO output:** AI risk status + required product guardrails.

---

## Skill: Contract / vendor / API terms review

**Use when:** LindaData uses a vendor, API, marketplace, SaaS platform, contractor, client agreement, NDA, or partner terms.  
**Lead executive:** CLO + CFO + CTO when technical/vendor access is involved  
**Specialists:** Contracts Counsel Agent, Procurement Agent, API Integration Engineer, Security Engineer, Legal Ops Agent

**Steps:**
1. Identify the vendor/contract and business purpose.
2. Review pricing, renewal, cancellation, data rights, confidentiality, security, indemnity, liability, usage limits, attribution, and termination.
3. Confirm whether data can be stored, transformed, shown publicly, or used for model training.
4. Check whether keys/secrets are handled server-side.
5. Flag unusual obligations or lock-in.
6. Create a short clause/risk summary.

**Definition of done:** Key obligations and blockers are documented before LindaData depends on the vendor or terms.  
**CEO output:** Green/yellow/red summary + what to avoid.

---

## Programming best practices

- Keep functions small and named by intent.
- Use semantic HTML before adding complexity.
- Prefer progressive enhancement for static sites.
- Avoid browser secrets.
- Keep state honest and recoverable.
- Add accessible labels to forms.
- Use responsive layouts and large tap targets.
- Validate user input before submit.
- Handle loading, success, empty, and error states.
- Test homepage plus at least one nested route when possible.
- Prefer boring, stable code over clever code.
- For legal/privacy-sensitive features, do not hide risk in code comments only; document the visible gate in Context.md or the relevant project docs.

---

## How to update this file

When work was hard and reusable, add a new skill here.

A good skill should include:

- Use case.
- Lead executive.
- Specialist agents.
- Required inputs.
- Steps.
- Definition of done.
- CEO output.
