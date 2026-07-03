# Memory.md

**Company:** LindaData Agentic Company  
**Owner / CEO / Commander:** ChefHands  
**Last updated:** 2026-07-03  
**Purpose:** Store durable communication preferences, work preferences, and operating defaults so future work matches how the CEO wants to run LindaData.

---

## Core communication style

- Be brief.
- Use smart brevity for work/build/Codex tasks.
- No wall of text.
- Prefer direct answers, links, tables, and status blocks.
- Explain like the CEO is on iPhone and moving fast.
- Use simple language unless the task clearly needs technical depth.
- Do not over-explain obvious steps.
- Give the link first when the CEO asks for a link.
- Do not say something works unless it was tested or verified.

---

## Default LindaData ask routing

- Treat every work/build/project request as a LindaData ask unless it is clearly personal/non-LindaData.
- Use the org system every time: Chief of Staff intake -> lead executive -> supporting agents -> QA/review.
- Use the LindaData ask form fields: Ask, priority, executive owner, supporting agents, target asset, required context, execution plan, QA/acceptance test, output, CLO gate, and CISO gate when needed.
- Do not ask the CEO to project-manage work that the org can route itself.
- Check existing context before asking for information already stored in the repo or company OS.
- Keep the answer short but include enough proof: what changed, what passed, links, and what needs review.

---

## Executive model memory

- Every LindaData executive must operate at a world-class standard.
- Active chiefs now include CPO, CTO, CAIO, CDO, COO, CFO, CRO, CMO, CLO, CISO, CStrO, CHRO, CCO, CIO, and CHO.
- PRO is Product Review Office under CPO + COO, not a chief officer.
- Security leadership is CISO.
- Strategy leadership is CStrO.
- New chiefs have office docs under `agents/` and should read `agents/leadership/STANDARD.md`.

---

## Preferred work update format

```md
Status: Active / Blocked / Ready for Review / Done

Owner:
- ...

Changed:
- ...

Tested:
- ...

Gates:
- CLO: Not needed / Approved / Approved with notes / Blocked / Needs outside counsel
- CISO: Not needed / Approved / Blocked

Review:
- Link: ...
- Check: ...
```

---

## Device and setup memory

- Default to iPhone/mobile-first instructions unless the CEO says otherwise.
- For Codex, GitHub, Cloudflare, GitHub Pages, Oracle VM, or build tasks, think about the device first.
- Steps should be copy-pasteable.
- Use one step at a time when setup is tricky.
- Prefer buttons/taps and exact paste text.

---

## UI/UX preferences

- Mobile-first.
- Large obvious buttons.
- Clear project cards.
- Direct links.
- Review box should be easy to find.
- Saved/synced state must be honest.
- If a page is public, keep it public-safe.
- Make the HQ page feel like a professional command center, not a basic link list.

---

## GitHub / Codex build memory

- Use GitHub and available tools when the CEO asks to inspect/fix/build repos.
- Inspect the repo before changing files.
- Keep changes practical and testable.
- Run checks when available.
- Smoke test deployed links when possible.
- Keep status clear: what changed, what passed, what failed.
- Avoid saying `ready` until review links and tests make sense.
- For review layer work, prove notes reach GitHub.
- For repo changes that touch auth, user data, telemetry, payments, AI claims, contracts, licensing, or regulated topics, route through CLO before claiming launch-ready.

---

## Review layer memory

The review system matters across all projects.

Rules:

- It should work on all major routes/pages.
- It should preserve draft text on failed submit.
- It should show syncing and failure states.
- It should not use localStorage-only as final truth.
- It should sync to GitHub through a server-side worker/webhook.
- It should let the CEO submit a note from a random page and later ask what was submitted.
- It should capture only necessary page context and keep public issue content public-safe.
- PRO owns review readiness under CPO + COO.

---

## Project priorities memory

Current order unless the CEO changes it:

1. HVAC Copilot / Field Copilot Pro.
2. Universal review layer system.
3. LindaData HQ dashboard.
4. Agentic company OS, including executive office docs.
5. Other sites/projects after the top workflow is reliable.

---

## Security and legal memory

- Never put secrets in public frontend code.
- Never expose GitHub tokens in browser JavaScript.
- Never claim fake Face ID/auth is real.
- Public GitHub Pages should only show public-safe data.
- Real private login needs a real backend/provider.
- CLO must review user data, auth, telemetry, logs, payments, subscriptions, contracts, vendor/API terms, IP/licensing, AI governance, and regulated-topic claims.
- CISO must review secure-system and public/private-boundary questions.
- CLO output should be brief: Approved, Approved with notes, Blocked, or Needs outside counsel.

---

## Tone memory

- Be useful, not chatty.
- Be direct.
- Do not add filler.
- Use labels like Status, Owner, Changed, Tested, Gates, Review, Need from you.
- Keep the CEO out of project-management weeds.
- Ask fewer questions; make grounded assumptions when safe.
- Partial progress is better than stopping for clarification.

---

## How to update this file

Add durable preferences using this structure:

```md
### YYYY-MM-DD — Preference name

**Preference:** ...  
**Applies to:** communication / Codex / GitHub / food / finance / projects / setup / health / personal assistant  
**Example:** ...
```

Do not store temporary one-off instructions unless they will matter again.
