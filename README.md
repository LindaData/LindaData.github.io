# LindaData Morning HQ

Live HQ: https://lindadata.github.io/

LindaData.github.io is the public-safe command center for LindaData work. It is the morning start page for active projects, review links, company routing, and short CEO-facing status.

## Source of truth

- Root HQ page: `index.html`
- Project registry: `hq/data/projects.json`
- Link audit: `hq/LINK_AUDIT.md`
- Company org: `company/Company_Org.md`
- Operating context: `company/Context.md`
- Agent library: `AGENTS.md` and `agents/`

## Operating rule

Every meaningful task routes through:

```text
ChefHands / CEO
→ Chief of Staff or correct executive owner
→ specialist agents
→ QA / proof
→ CEO-facing summary or review link
```

## Current priority order

1. HVAC Copilot / Field Copilot Pro
2. Universal Review Layer System
3. LindaData HQ Dashboard
4. Company Org / Agentic Company
5. All other projects stay visible but do not outrank HVAC unless ChefHands changes priority

## Link policy

The HQ should show links in this order:

1. Live app or review surface
2. Review inbox, issue, or PR
3. Repository
4. Reference docs

Private data must not be placed in this static GitHub Pages site. Private repo links are access-controlled by GitHub and should stay public-safe: name, status, owner lane, and link only.

## Review-layer rule

A review note only counts as complete after the webhook confirms GitHub sync. Local storage is recovery only. Do not present local-only notes as saved work.

## Security note

This is a public GitHub Pages site. Real Face ID, Apple passkeys, or private login requires a backend challenge flow. Static frontend JavaScript cannot be treated as private authentication.
