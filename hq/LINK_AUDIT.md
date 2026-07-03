# LindaData HQ Link Audit

Date: 2026-07-03  
Owner lane: Chief of Staff + CIO + CTO + PRO + QA  
Repo: `LindaData/LindaData.github.io`

## Outcome

The HQ registry now prioritizes each project in this order: live app or review surface, review inbox/issue/PR, repo, then reference docs.

## Links checked

| Area | Link / target | Check method | Status |
|---|---|---|---|
| Root HQ | `https://lindadata.github.io/` | Live open | OK |
| HVAC Today | `https://lindadata.github.io/field-copilot-pro/app/today/` | Live click/open | OK |
| HQ review inbox | Worker notes for `field-copilot-pro` issue #61 | Live click/open | OK |
| Project registry | `hq/data/projects.json` | GitHub file fetch + registry check | OK |
| Company Org | `company/Company_Org.md` | GitHub file fetch | OK |
| Company folder | GitHub `company/` folder | Live click/open | OK |
| Boxing review surface | `https://lindadata.github.io/boxing-gym/` | Repo entrypoint + review overlay inspection | OK |
| Southpaw concept | `https://lindadata.github.io/southpaw-boxing/` | Repo entrypoint inspection | OK, local-only review |
| World Cup forecasts | `https://lindadata.github.io/world-cup-2026-betting-model/` | Repo README + `docs/index.html` inspection | OK |
| Game Stat Pulse | `https://lindadata.github.io/game-stat-pulse/` | Repo README + `index.html` inspection | OK |
| PawPath preview | `https://lindadata.github.io/pawpath-dog-compass-preview/` | Repo `index.html` inspection | OK |
| Recycle Right Now | `https://lindadata.github.io/recycle-right-now-82/?overlay=review` | Existing HQ route + source entrypoint inspection | Tracked |
| Private repo links | GitHub access-controlled repo URLs | GitHub connector repo search | OK / owner access required |

## Changes from this audit

- HVAC stays pinned first.
- Added live app links where repo-only links were hiding usable pages.
- Kept the Boxing Fitness Demo as the synced review surface.
- Kept Southpaw as a concept/reference page because its review drawer is local-only.
- Added this audit doc to the HQ company docs list.
- Replaced stale root README content with LindaData HQ operating docs.
- Refreshed `Context.md` so the project board matches the current HQ.

## Known limits

- This root GitHub Pages site is public. Real Face ID or passkey protection requires a backend challenge flow.
- Private repo links are visible as project names but require the owner account to open.
- External safe-open checks can block some deep static routes even when repo entrypoints exist; those were checked through GitHub source files.
