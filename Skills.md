# Skills.md

**Company:** LindaData Agentic Company  
**Owner / CEO / Commander:** ChefHands  
**Last updated:** 2026-07-02  
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

## Skill: Universal task intake

**Use when:** The CEO asks for any new task, build, research, review, setup, or decision.  
**Lead executive:** Chief of Staff  
**Specialists:** Intake Triage Agent, Priority Manager, Source-of-Truth Agent

**Steps:**
1. Identify the outcome the CEO wants.
2. Check Context.md and Memory.md before asking questions.
3. Decide the lead executive.
4. Decide whether tools are needed: GitHub, Codex, web, files, Gmail, Calendar, Python, Notion, Canva, etc.
5. If the task is simple, answer directly.
6. If the task is complex, give a short status update and execute.
7. Log durable decisions in Context.md.

**Definition of done:** The task has an owner, status, and next action.  
**CEO output:** Short summary with direct next step.

---

## Skill: GitHub / Codex repo change

**Use when:** Code needs to be inspected, fixed, built, or deployed.  
**Lead executive:** CTO  
**Specialists:** Software Architect, Full-Stack Engineer, QA Automation Engineer, Security Engineer, Release Manager

**Steps:**
1. Identify repo, branch, issue, and deploy target.
2. Inspect repo structure.
3. Read README, docs, package files, config files, and agent instructions.
4. Preserve existing architecture and Lovable scaffold if present.
5. Make the smallest useful fix.
6. Use a branch/PR when appropriate; direct commit only when it is clearly safe or explicitly expected.
7. Run available checks: install, lint, typecheck, tests, build, smoke test.
8. Confirm no secrets are exposed.
9. Summarize exact changes and exact test results.
10. Give the CEO the review link and the specific item to test.

**Definition of done:** Build passes or failures are clearly reported and the changed path is smoke-tested.  
**CEO output:** Link + what changed + what passed + what to review.

---

## Skill: Review layer implementation

**Use when:** A website/app needs CEO feedback directly on the page.  
**Lead executive:** CTO  
**Specialists:** Review Layer Engineer, Backend Engineer, Security Engineer, QA Automation Engineer

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
8. Smoke test homepage and at least one non-home route.
9. Confirm the note appears in GitHub.

**Definition of done:** The CEO can submit feedback from a random page and the note appears in the review inbox/GitHub.  
**CEO output:** Test link + pages tested + sample received note summary.

---

## Skill: UI / UX review

**Use when:** A site/app needs to look professional and be easy to use.  
**Lead executive:** CMO + CCO  
**Specialists:** Creative Director, UX Empathy Agent, Accessibility Advocate, Frontend Engineer

**Steps:**
1. Identify the target user and main job-to-be-done.
2. Check whether the page explains itself within five seconds.
3. Review mobile first.
4. Review desktop second.
5. Check navigation, hierarchy, buttons, spacing, copy, and visual polish.
6. Check accessibility basics: readable text, contrast, focus, labels, tap targets.
7. Compare against best-in-class references without copying protected branding.
8. Return ranked fixes: P0 broken, P1 important, P2 polish.

**Definition of done:** The page is easier to understand and use, especially on iPhone.  
**CEO output:** Short ranked list + review link.

---

## Skill: Deployment smoke test

**Use when:** A site is deployed or a key feature is fixed.  
**Lead executive:** COO  
**Specialists:** Release Manager, QA Automation Engineer, Site Reliability Engineer

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
10. Record pass/fail.

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
**Specialists:** Data Architect, Data Engineer, Analytics Engineer, Data Quality Analyst, Statistician

**Steps:**
1. Define the data source and access pattern.
2. Confirm secrets/API keys stay server-side.
3. Define raw, staged, cleaned, and analytics layers.
4. Create schema/data dictionary.
5. Add freshness and quality checks.
6. Create sample export/download if reviewers need it.
7. Document source limitations.
8. Keep modeling separate from raw collection until data quality is reliable.

**Definition of done:** Data is visible, validated, documented, and ready for analysis/modeling.  
**CEO output:** Data status + sample link/download + known gaps.

---

## Skill: Statistical / modeling review

**Use when:** A question needs statistics, modeling, experiments, prediction, or inference.  
**Lead executive:** CDO  
**Specialists:** Statistician, Data Scientist, ML Engineer, Data Quality Analyst

**Steps:**
1. Define the outcome and decision being supported.
2. Separate descriptive analysis, causal inference, and prediction.
3. Check data quality and leakage risks.
4. Establish a baseline model first.
5. Define train/test or validation method.
6. Select metrics based on the decision.
7. Report uncertainty and limits clearly.
8. Avoid overbuilding before data is trustworthy.

**Definition of done:** Model or analysis is explainable, tested, and aligned to a decision.  
**CEO output:** Recommendation + confidence + next analysis.

---

## Skill: API integration

**Use when:** A project needs third-party data, webhooks, auth, or external services.  
**Lead executive:** CTO + CDO  
**Specialists:** API Integration Engineer, Backend Engineer, Security Engineer, Data Engineer

**Steps:**
1. Read official/current API docs.
2. Confirm auth method and rate limits.
3. Keep keys server-side.
4. Build a thin integration layer.
5. Validate response shape.
6. Handle errors, retries, and empty responses.
7. Log safely without leaking secrets or private data.
8. Add sample fixtures/tests when practical.

**Definition of done:** Integration works, handles failure, and does not expose secrets.  
**CEO output:** Working endpoint/link + limits + next action.

---

## Skill: HQ dashboard update

**Use when:** The central HQ page needs new projects, links, statuses, or workflow changes.  
**Lead executive:** CIO + COO  
**Specialists:** Source-of-Truth Agent, Frontend Engineer, Project Manager, Documentation QA Agent

**Steps:**
1. Check Context.md for current projects.
2. Keep the public HQ public-safe.
3. Update the active project list with status and priority.
4. Add direct links to apps, repos, issues, PRs, docs, and review surfaces.
5. Keep HVAC first unless the CEO changes the priority.
6. Test the page loads and the key links are present.
7. Report the live link and exact changes.

**Definition of done:** The CEO can open the HQ page and see the current work map.  
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
