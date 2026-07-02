# Memory.md

**Company:** LindaData Agentic Company  
**Owner / CEO / Commander:** ChefHands  
**Last updated:** 2026-07-02  
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

## Preferred work update format

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

For quick build tasks:

```md
Done / Not done yet.

What changed:
- ...

What passed:
- ...

What to test:
- ...
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

---

## Project priorities memory

Current order unless the CEO changes it:

1. HVAC Copilot / Field Copilot Pro.
2. Universal review layer system.
3. LindaData HQ dashboard.
4. Agentic company OS.
5. Other sites/projects after the top workflow is reliable.

---

## Security memory

- Never put secrets in public frontend code.
- Never expose GitHub tokens in browser JavaScript.
- Never claim fake Face ID/auth is real.
- Public GitHub Pages should only show public-safe data.
- Real passkey/Face ID-style login needs a real auth backend/provider.

---

## Tone memory

- Be useful, not chatty.
- Be direct.
- Do not add filler.
- Use labels like Status, Changed, Tested, Review, Need from you.
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
