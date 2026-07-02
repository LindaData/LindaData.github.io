# LindaData Memory.md

**Owner / CEO / Commander:** ChefHands  
**Last updated:** 2026-07-02  
**Purpose:** Durable working preferences for how LindaData agents should communicate, build, test, and report.

---

## 1. Communication Preferences

- Be brief.
- Use smart brevity for work/build/Codex tasks.
- Avoid walls of text.
- Prefer direct links over long explanations.
- Use simple sections like Status, Done, Found, Next, Need from you.
- Explain like the CEO is on iPhone and needs the next tap, not a textbook.
- Do not claim something works unless it was checked.
- Give exact review links and exact things to test.
- Keep status honest: Active, Blocked, Ready for Review, Done.

---

## 2. Device / Setup Preferences

- Default to iPhone/mobile-first for build instructions unless another device is stated.
- Make copy-paste steps easy.
- Ask for device only when it changes the answer materially.
- For setup tasks, provide one clear step at a time when possible.

---

## 3. Build Preferences

- Use all appropriate connected tools and resources.
- Inspect the repo/site before changing things.
- Keep existing working architecture when possible.
- Use Lovable or similar visual starts as direction, not as a replacement for production repo work.
- Prefer simple, reliable, maintainable implementations.
- Cheapest viable infrastructure first, but do not sacrifice the quality of the product.
- No fake “saved” or “done” states.
- Smoke test the real deployed link when possible.

---

## 4. GitHub / Codex Preferences

- Work from GitHub repos directly when available.
- Create branches and PRs when appropriate.
- Merge when safe and requested by context.
- Check PRs/issues/comments for actual user feedback.
- For failures, reproduce or inspect evidence first.
- Report what changed, what passed, what failed, and what to test next.

---

## 5. UI / UX Preferences

- Mobile-first.
- Large obvious buttons.
- Clear navigation.
- Professional dashboard look.
- Make the main action impossible to miss.
- Keep project cards scannable.
- Show active/blocked/paused/done clearly.
- Make review buttons user-friendly and reliable.

---

## 6. Security Preferences

- Never expose secrets in public frontend code.
- Do not store API keys in GitHub Pages JavaScript.
- Use server-side secrets for GitHub/webhook work.
- Public HQ may show public-safe project status and links.
- Real Face ID/passkey login requires real auth infrastructure; do not fake it.

---

## 7. Durable Phrases / Operating Style

Preferred output shape for build work:

```text
Status: ...
Changed: ...
Tested: ...
Link: ...
Next: ...
```

Preferred output shape for simple instructions:

```text
1. Tap ...
2. Paste ...
3. Tap ...
4. Tell me what you see.
```

---

## 8. Update Rules

Update this file only for durable preferences. Temporary one-off instructions belong in Context.md or the current task notes.
