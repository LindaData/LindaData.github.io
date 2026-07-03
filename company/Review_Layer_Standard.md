# LindaData Review Layer Standard

Version: 2026-07-03  
Owner: PRO + CTO + CSO  
Status: Canonical standard for every project review surface

## Operating decision

Do not use a separate standalone HVAC review workspace as the default review surface.

The standard is the in-app review layer used inside the HVAC app:

```text
Project screen / active app route
→ floating review launcher
→ clean glass overlay on top of the actual page
→ live sync status
→ GitHub-backed note capture
→ optional screenshot/snapshot support
→ proof in review inbox
```

The reviewer should stay on the product screen they are inspecting. The review layer behaves like clean glass over the art: annotations happen on the overlay, while implementation changes happen in the main app only after the CEO asks for them.

## Required pattern for all projects

1. Put review inside the active app/page, not on a separate workspace.
2. Use a compact floating launcher that works on iPhone and desktop.
3. Keep the panel above app bottom navigation and Safari safe areas.
4. Show one of these states before capture: Live sync, Syncing, Failed, or Blocked.
5. Do not show a fake success state. A note only counts as captured after the webhook confirms GitHub receipt.
6. Keep draft text visible when sync fails.
7. Include project, source repo, route/path, page label, URL, viewport, user agent, session id, timestamp, note kind, priority, and visible page context.
8. Support screenshot paste/drop where the project stack can support attachments.
9. Route new review notes to the current universal inbox unless a project-specific inbox is explicitly assigned.
10. Every HQ project link should open the real app/reviewable screen, not a detached review workspace.

## Current reference implementation

Reference project: `LindaData/field-copilot-pro`  
Reference active route: `/app/today/`  
Reference pattern: app-wide `ReviewLayerResolved` plus the snapshot-style in-app overlay from the HVAC app workstream.

The important behavior is not the exact component name. The important behavior is: in-app, live-syncing, mobile-safe, context-rich, and not a separate review page.

## Routing rule

When a project needs review:

```text
CEO opens project app/page
→ taps the in-app Review button
→ writes note or attaches screenshot
→ note syncs to GitHub
→ PRO/CTO route implementation work
```

Do not send the CEO to `field-copilot-pro/review` as the normal path.

## Porting queue

- HVAC Copilot: canonical in-app reference.
- Recycle Right Now: keep the in-app overlay path and align styling/behavior with the HVAC pattern.
- Boxing Fitness Demo: use the in-page review overlay as the review surface, then port toward the HVAC app behavior.
- Southpaw Boxing: old local-only concept review is not the standard; replace with live in-app overlay before calling it review-ready.
- PawPath, Game Stat, World Cup, and future demos: add the same in-app review layer before CEO review.
