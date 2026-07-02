# LindaData Skills.md

**Owner / CEO / Commander:** ChefHands  
**Last updated:** 2026-07-02  
**Purpose:** Repeatable workflows so LindaData agents do not rebuild process from scratch each time.

---

## Skill Template

```md
## Skill: Name

Use when: ...
Lead executive: ...
Specialists: ...
Inputs needed: ...
Steps:
1. ...
2. ...
3. ...
Definition of done: ...
CEO output: ...
```

---

## Skill: Universal Task Intake

**Use when:** A new task, build, research, review, setup, or decision arrives.  
**Lead executive:** Chief of Staff  
**Specialists:** Intake Triage Agent, Priority Manager, Source-of-Truth Agent

**Steps:**
1. Identify the real outcome wanted.
2. Check Context.md and Memory.md before asking questions.
3. Pick the lead executive.
4. Decide what tools are needed.
5. If simple, answer directly.
6. If complex, give a short status update and begin.
7. Log durable decisions.

**Definition of done:** The task has status, owner, next action, and link if available.  
**CEO output:** Short summary + direct next step.

---

## Skill: GitHub Repo Change

**Use when:** A repo needs code inspection, fixes, deployment, or review.  
**Lead executive:** CTO  
**Specialists:** Software Architect, Full-Stack Engineer, QA Automation Engineer, Security Engineer

**Steps:**
1. Identify repo, branch, issue, and deploy target.
2. Inspect repo structure first.
3. Read README/config/package files when relevant.
4. Make the smallest useful fix.
5. Keep secrets out of frontend code.
6. Run available checks: install, lint, typecheck, tests, build, smoke test.
7. Report exact changes and exact test result.
8. Give the CEO the review link.

**Definition of done:** Build passes or blockers are named clearly.  
**CEO output:** Changed / Tested / Link / Next.

---

## Skill: Review Layer Implementation

**Use when:** A website or app needs on-page CEO feedback.  
**Lead executive:** CTO  
**Specialists:** Review Layer Engineer, Backend Engineer, Security Engineer, QA Automation Engineer

**Preferred architecture:**

```text
Floating review button
→ Review form / overlay
→ Server-side webhook
→ GitHub issue comment / review inbox
→ Agent reads note and fixes
```

**Steps:**
1. Add an obvious review button that works on all major routes.
2. Include page context: project, URL, route, timestamp, viewport, note.
3. Send to a server-side webhook.
4. Keep GitHub token server-side.
5. Show Ready, Syncing, Live sync, Failed, Blocked.
6. Preserve draft when sync fails.
7. Smoke test homepage and random internal pages.
8. Confirm the note appeared in GitHub.

**Definition of done:** Feedback can be submitted from key pages and appears in the inbox.  
**CEO output:** Test link + pages tested + sample note found.

---

## Skill: UI / UX Review

**Use when:** A page/app needs to look professional and be easy to use.  
**Lead executive:** CMO + CCO  
**Specialists:** Creative Director, UX Empathy Agent, Accessibility Advocate, Frontend Engineer

**Steps:**
1. Identify the main user and job-to-be-done.
2. Check whether the page explains itself in 5 seconds.
3. Check mobile first.
4. Check desktop second.
5. Check navigation, hierarchy, buttons, spacing, copy, and accessibility.
6. Rank fixes as P0, P1, P2.
7. Patch the highest-impact issues first.
8. Give only the most important review checks.

**Definition of done:** Page is clearer, easier, and reviewable.  
**CEO output:** Link + top three things to check.

---

## Skill: Deployment Smoke Test

**Use when:** A site deploys or a key feature is fixed.  
**Lead executive:** COO  
**Specialists:** Release Manager, QA Automation Engineer, Site Reliability Engineer

**Steps:**
1. Open the production/staging link.
2. Confirm the page loads.
3. Test main action.
4. Test mobile viewport.
5. Test one nested route.
6. Test refresh on nested route when applicable.
7. Test forms/buttons involved in the change.
8. Record pass/fail.

**Definition of done:** Critical path works or blockers are named.  
**CEO output:** Pass/fail list + review link.

---

## Skill: Bug Triage and Fix

**Use when:** Something is broken, confusing, or unreliable.  
**Lead executive:** CTO  
**Specialists:** QA Automation Engineer, Software Architect, Relevant Engineer

**Steps:**
1. Define expected vs actual behavior.
2. Reproduce or inspect evidence.
3. Identify owner area: frontend, backend, webhook, auth, deploy, data.
4. Patch root cause, not just symptoms.
5. Add or adjust test if practical.
6. Smoke test the exact path the CEO used.
7. Report whether it works now.

**Definition of done:** Original failure path was checked after the fix.  
**CEO output:** Works now / Not yet + what remains.

---

## Skill: Data Pipeline Build

**Use when:** A project needs ingestion, cleaning, APIs, databases, or modeling prep.  
**Lead executive:** CDO  
**Specialists:** Data Architect, Data Engineer, Analytics Engineer, Data Quality Analyst, Statistician

**Steps:**
1. Define source and access pattern.
2. Keep API keys server-side.
3. Define raw, staged, cleaned, and analytics layers.
4. Add validation/freshness checks.
5. Document limitations.
6. Keep modeling separate until data quality is good.

**Definition of done:** Data is visible, validated, documented, and useful.  
**CEO output:** Data status + sample link + known gaps.

---

## Skill: Morning HQ Review

**Use when:** ChefHands opens the HQ page to start work.  
**Lead executive:** Chief of Staff  
**Specialists:** Status Reporter, Project Manager, Decision Log Agent

**Steps:**
1. Show top priority.
2. Show active, blocked, paused, done.
3. Show first link to open.
4. Show review queue.
5. Show what can be ignored today.
6. Let the CEO send a command to the inbox.

**Definition of done:** The CEO knows exactly what to open and what to ignore.  
**CEO output:** One-page dashboard.
