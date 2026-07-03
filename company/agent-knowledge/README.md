# LindaData Agent Knowledge Store

Version: 2026-07-03  
Owner: CIO + CHRO  
Status: Active

## Purpose

This folder is where agents store durable knowledge that helps future LindaData work.

The goal is simple:

```text
Future agents should not rediscover lessons already learned.
```

## What belongs here

Store knowledge when it is reusable, safe, and useful for future tasks.

Good examples:

- Role checklists
- Reusable prompts or handoff templates
- Project-specific setup notes
- Build/test commands
- UX review patterns
- Data definitions
- Metric rules
- QA checklists
- Lessons from failures
- Known blockers and fixes
- Safe links to GitHub issues, PRs, or docs

## What does not belong here

Do not store:

- Passwords
- Private keys
- API keys
- Account recovery codes
- Private customer/user data
- Private financial or medical details
- Anything that should not be visible in a public repo

## Storage structure

Use this folder pattern:

```text
company/agent-knowledge/
├── chiefs/
│   ├── chief-of-staff.md
│   ├── cto.md
│   ├── pro.md
│   └── ...
├── specialists/
│   ├── frontend-engineer.md
│   ├── review-layer-agent.md
│   ├── data-analyst.md
│   └── ...
└── projects/
    ├── hvac-copilot.md
    ├── hq-dashboard.md
    └── review-layer.md
```

GitHub folders exist when the first file is created inside them.

## Knowledge entry template

```md
## YYYY-MM-DD — Lesson title

Owner:
- Executive / specialist agent

Source:
- Link to issue, PR, file, review note, or summary

Lesson:
- What was learned

Future rule:
- How future agents should act

Confidence:
- high / medium / low

Status:
- active / superseded / closed
```

## Update rules

Update this store when:

1. A failure creates a durable lesson.
2. A project gains a repeatable setup or build path.
3. A decision changes future behavior.
4. A review pattern repeats.
5. A role needs clearer instructions.
6. A better checklist or workflow is created.

## Ownership

| Area | Owner |
|---|---|
| File structure | CIO |
| Role training | CHRO |
| Project-specific technical notes | CTO |
| Product/review notes | PRO |
| Data/metric notes | CDO |
| Security rules | CSO |
| Operational SOPs | COO |
| Priorities and decisions | Chief of Staff |

## Final rule

```text
Store only what helps future work.
Keep it safe.
Keep it findable.
Keep it short.
```
