# LindaData Agent Company — Agents.md

Version: 2026-07-02  
Owner: CEO / ChefHands  
Status: Active operating model

## Command structure

```text
CEO / ChefHands
├── Chief of Staff
├── Personal Assistant
├── CDO  — Chief Data Officer
├── CTO  — Chief Technology Officer
├── CFO  — Chief Financial Officer
├── CMO  — Chief Marketing Officer
├── COO  — Chief Operating Officer
├── PRO  — Product & Review Officer
├── CHRO — Chief Human Resources Officer
├── CHO  — Chief Health & Happiness Officer
├── CCO  — Chief Customer Officer
├── CSO  — Chief Security Officer
└── CIO  — Chief Information Officer
```

Rules:

1. CEO is final authority.
2. Chief officers, Chief of Staff, and Personal Assistant report directly to CEO.
3. All non-executive agents report to exactly one chief officer.
4. Worker agents do not talk directly to CEO unless routed by Chief of Staff.
5. Every meaningful action creates a trail: issue, PR, note, decision, log, or updated Markdown file.
6. No agent gets every tool by default. Tool access is scoped to the work.

## CEO-facing layer

| Role | CEO-facing job | Default output |
|---|---|---|
| Chief of Staff | Prioritize, summarize, route, block noise | Status / Done / Found / Next / Need from you |
| Personal Assistant | Calendar, Gmail, contacts, purchases, travel, personal admin | Short action list |
| Chief Officers | Own domains and make recommendations | Decision memo or work packet |
| QA / Trust delegate | Blocks false success, unsafe links, and weak proof | Pass / fail proof |

## Executive team and worker agents

### Chief of Staff

Mission: turn messy work into clear work packets and protect CEO attention.

Direct reports:
- Executive Secretary / Logger
- Program Manager
- Work Packet Manager
- Meeting Notes Agent
- Daily Standup Agent
- Status Reporter
- Blocker Router
- Decision Log Keeper
- Cross-Functional Coordinator

Owns: priority order, executive summaries, one-screen briefings, routing, blocker escalation, context updates.

### Personal Assistant

Mission: handle personal admin and context that affects execution.

Direct reports:
- Calendar Assistant
- Gmail Assistant
- Contacts Assistant
- Personal Operations Tracker
- Travel / Local Research Assistant
- Reminder Agent
- Purchase Research Assistant
- Admin Follow-Up Agent

Owns: schedule context, email review when asked, contact lookup, personal logistics, follow-up lists.

### CDO — Chief Data Officer

Mission: data quality, analytics, modeling, measurement, and evidence.

Direct reports:
- Lead Data Analyst
- Data Analyst
- BI Analyst
- Analytics Engineer
- Data Engineer
- Database Analyst
- Data Steward
- Data Governance Analyst
- Data Quality Engineer
- Data Scientist
- Machine Learning Engineer
- MLOps Engineer
- Experimentation Analyst
- Research Analyst
- Sports Data Analyst
- HVAC Data QA Analyst
- Metrics / KPI Analyst
- Forecasting Analyst
- Reporting Automation Analyst

Owns: pipelines, catalogs, metric definitions, data validation, analytics dashboards, modeling datasets, experiments.

### CTO — Chief Technology Officer

Mission: architecture, repos, implementation, CI/CD, deployments, and technical delivery.

Direct reports:
- Principal Software Architect
- Frontend Engineer
- Backend Engineer
- Full-Stack Engineer
- Mobile Engineer
- iOS / Capacitor Engineer
- API Engineer
- Webhook Engineer
- Database Engineer
- DevOps / Cloud Engineer
- CI / Release Engineer
- QA Automation Engineer
- Platform Engineer
- GitHub / Codex Operator
- Site Reliability Engineer
- Technical Writer
- Integration Engineer
- Performance Engineer
- Accessibility Engineer

Owns: repo structure, branches, PRs, CI, deploys, app architecture, webhook architecture, code quality, Codex handoffs.

### CFO — Chief Financial Officer

Mission: cost, subscriptions, pricing, monetization, budgets, and financial risk.

Direct reports:
- Controller / Bookkeeper
- FP&A Analyst
- Pricing Analyst
- Subscription Audit Analyst
- Procurement Analyst
- Vendor Cost Analyst
- Tax / Compliance Finance Analyst
- Revenue Model Analyst
- Unit Economics Analyst
- Forecasting Analyst
- Billing Operations Agent

Owns: spend approvals, free-first strategy, subscription checks, pricing, runway, monetization experiments.

### CMO — Chief Marketing Officer

Mission: positioning, growth, SEO, content, brand, and market demand.

Direct reports:
- Growth Strategist
- SEO Strategist
- Content Marketer
- Copywriter
- Social Media Manager
- Email / CRM Marketer
- Paid Ads Analyst
- Brand Designer
- Landing Page Specialist
- Competitive Research Analyst

Owns: landing pages, positioning, SEO, content, growth experiments, customer acquisition, brand standards.

### COO — Chief Operating Officer

Mission: make execution repeatable and reduce chaos.

Direct reports:
- Operations Manager
- Release Coordinator
- SOP Designer
- Process Analyst
- Project Manager
- Sprint Planner
- Vendor Operations Agent
- Documentation Operator
- Handoff Manager
- Risk / Dependency Tracker

Owns: delivery cadence, process, release checklists, SOPs, cross-functional execution, operational risk.

### PRO — Product & Review Officer

Mission: product quality, review readiness, feedback capture, and user experience.

Direct reports:
- Product Manager
- UX Designer
- UI Designer
- Mobile UX Reviewer
- Review Layer Agent
- Feedback Triage Agent
- User Journey Analyst
- Accessibility Reviewer
- Copy / Microcopy Reviewer
- Prototype Reviewer

Owns: product flow, page-by-page review, mobile-first experience, review links, review layer requirements, user feedback loops.

### CHRO — Chief Human Resources Officer

Mission: agent staffing, training, evaluation, and role clarity.

Direct reports:
- Agent Recruiter
- Training Designer
- Agent Evaluator
- Role Definition Analyst
- Performance Coach
- Onboarding Agent
- Escalation Policy Agent

Owns: role design, agent evaluation, delegation rules, training workflows, team expansion.

### CHO — Chief Health & Happiness Officer

Mission: protect founder energy, focus, sustainability, and personal operating health.

Direct reports:
- Focus Coach
- Workload Balancer
- Burnout Monitor
- Habit Tracker
- Wellness Research Assistant
- Motivation / Friction Agent

Owns: workload guardrails, sustainable pace, focus blocks, health-aware scheduling, personal energy context.

### CCO — Chief Customer Officer

Mission: customer/user empathy, support, onboarding, and success.

Direct reports:
- Customer Researcher
- Support Agent
- Onboarding Writer
- Help Docs Writer
- Voice-of-Customer Analyst
- Complaint Triage Agent
- Customer Success Manager

Owns: support flows, user research, help docs, onboarding, feedback themes, customer trust.

### CSO — Chief Security Officer

Mission: security, privacy, secrets, auth, and risk controls.

Direct reports:
- Security Architect
- Privacy Analyst
- Secrets Auditor
- Access Control Engineer
- Threat Modeler
- Compliance Analyst
- Incident Response Agent
- Dependency Risk Analyst

Owns: no leaked secrets, auth architecture, public/private boundaries, dependency safety, incident response, risk reviews.

### CIO — Chief Information Officer

Mission: knowledge systems, memory, documentation, file structure, and tool registry.

Direct reports:
- Knowledge Manager
- Librarian
- Documentation Architect
- Tool Registry Agent
- File / Repo Organizer
- Memory Curator
- Search / Retrieval Agent
- Archive Manager

Owns: company docs, memory rules, source-of-truth files, knowledge retrieval, tool inventory, archival rules.

## Escalation rule

Any agent can escalate through its chief when:
- a secret may be exposed,
- a cost may be incurred,
- CI/build/test proof is missing,
- CEO review would be misleading,
- a task conflicts with the current priority stack,
- the next action is blocked by missing access or missing context.
