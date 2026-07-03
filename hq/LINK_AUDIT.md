# LindaData HQ Link Audit

Date: 2026-07-03  
Owner lane: Chief of Staff + CIO + CTO + PRO + QA  
Repo: `LindaData/LindaData.github.io`

## Outcome

The HQ registry was reorganized so each project points first to the right live app or review surface, then inbox/issue/PR, then repo/reference links.

## Links checked

| Area | Link / target | Check method | Status |
|---|---|---|---|
| Root HQ | `https://lindadata.github.io/` | Live web open | OK |
| HVAC Today | `https://lindadata.github.io/field-copilot-pro/app/today/` | Live web click/open | OK |
| HQ review inbox | `https://soft-unit-ba5d.sergio-mora.workers.dev/notes?repo=LindaData%2Ffield-copilot-pro&inboxIssue=61` | Live web click/open | OK |
| Project registry | `hq/data/projects.json` | GitHub file fetch + JSON validation | OK |
| Company Org | `company/Company_Org.md` | GitHub file fetch | OK |
| Company folder | `https://github.com/LindaData/LindaData.github.io/tree/master/company` | Live web click/open | OK |
| World Cup forecasts | `https://lindadata.github.io/world-cup-2026-betting-model/` | Repo README advertises route; `docs/index.html` exists | OK |
| Game Stat Pulse | `https://lindadata.github.io/game-stat-pulse/` | Repo `index.html` exists; README says Pages deploys app | OK |
| PawPath preview | `https://lindadata.github.io/pawpath-dog-compass-preview/` | Repo `index.html` exists | OK |
| Boxing review demo | `https://lindadata.github.io/boxing-gym/` | Repo `boxing-gym/index.html` exists and has webhook review overlay | OK |
| Southpaw concept | `https://lindadata.github.io/southpaw-boxing/` | Repo `southpaw-boxing/index.html` exists | OK |
| Recycle Right Now | `https://lindadata.github.io/recycle-right-now-82/?overlay=review` | Repo source entrypoint exists; prior HQ context tracks this as the public app link | Tracked |
| GitHub repo/issue/PR links | LindaData repo URLs in registry | GitHub connector repo/PR/file checks where available | OK / access-controlled |

## Changes made by this audit

- Added live forecast link for the World Cup model.
- Added live app link for Game Stat Pulse.
- Added live preview link for PawPath Dog Compass Preview.
- Changed Southpaw primary link to the review-ready `/boxing-gym/` demo.
- Kept `/southpaw-boxing/` as an older concept/reference link.
- Added review inbox links where they are operationally useful.
- Replaced stale Jekyll README text with LindaData HQ operating docs.

## Known limits

- This HQ is public. Real Face ID or passkey protection needs a backend challenge flow.
- Private repo links are visible as names but require GitHub permission to open.
- Some deep GitHub Pages routes are validated from repo entrypoints because external safe-open checks may block direct URL fetches.
