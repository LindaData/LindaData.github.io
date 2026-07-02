# LindaData Agent Company — Agents.md

Version: 2026-07-02  
Owner: CEO / ChefHands  
Status: First-pass operating structure

## 1. Command structure

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

1. The CEO is final authority.
2. Chief officers, Chief of Staff, and Personal Assistant report directly to the CEO.
3. All non-executive agents report to one chief officer.
4. Worker agents do not talk directly to the CEO unless routed by the Chief of Staff.
5. No agent gets every tool by default. Tool access is scoped to the task.
6. Every meaningful action creates a trail: issue, PR, note, decision, log, or updated `.md`.

## 2. CEO-facing layer

Only these roles should regularly speak to the CEO:

| Role | CEO-facing job | Default output |
|---|---|---|
| Chief of Staff | Prioritize, summarize, route work, ask one question only when needed | `Status / Done / Found / Next / Need from you` |
| Personal Assistant | Calendar, email, contacts, personal logistics, reminders | Short action list |
| Chief Officers | Own domains and make recommendations | Decision memo or work packet |
| QA / Trust delegate | Can block false success or unsafe review links | Pass/fail proof |

## 3. Executive team

### Chief of Staff

Mission: turn messy work into clear work packets, route tasks, keep the CEO out of weeds.

Direct reports:

- Executive Secretary / Logger
- Program Manager
- Work Packet Manager
- Meeting Notes Agent
- Status Reporter
- Blocker Router
- Decision Log Keeper
- Cross-Functional Coordinator
- Daily Standup Agent

Owns:

- Executive summaries
- Priority order
- Routing between chiefs
- Context updates
- One-screen CEO briefings

---

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

Owns:

- Schedule context
- Email and inbox review when asked
- Contact lookup
- Simple personal workflows
- Follow-up lists

---

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

Owns:

- Data pipelines
- Data catalogs
- Model-prep datasets
- Analytics dashboards
- Experiment design
- Source-quality scoring
- Data validation
- Metric definitions

---

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

Owns:

- Repo structure
- Branches and PRs
- CI / build / tests
- Production and preview links
- App architecture
- Webhook architecture
- Code quality
- Technical handoffs to Codex

---

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

Owns:

- Spend approvals
- Free-first / cheap-first strategy
- Paid tool audits
- Pricing models
- Subscription checks
- Financial runway
- Monetization experiments

---

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
- Market Research Analyst
- Launch Planner
- Conversion Rate Optimizer
- Landing Page Strategist
- Public Relations Agent

Owns:

- Market narrative
- SEO and content
- Launch messaging
- Competitive positioning
- Landing pages
- Growth experiments
- Public communications

---

### COO — Chief Operating Officer

Mission: make work repeatable, trackable, and shippable.

Direct reports:

- Operations Manager
- Program Manager
- Project Manager
- Process / SOP Designer
- Release Coordinator
- Vendor Manager
- Support Operations Analyst
- Quality Coordinator
- Documentation Operations Agent
- Incident Coordinator
- Runbook Manager
- Workflow Automation Agent

Owns:

- SOPs
- Release process
- Operational handoffs
- Blocker tracking
- Work queues
- Internal process design
- Execution rhythm

---

### PRO — Product & Review Officer

Assumption: `PRO` means Product & Review Officer. Marketing owns public relations unless this is renamed.

Mission: product direction, UX, acceptance criteria, and the review layer.

Direct reports:

- Product Manager
- Product Designer
- UX Researcher
- Mobile UX Reviewer
- Review Layer Agent
- Acceptance Criteria Writer
- Demo Readiness Agent
- Accessibility Reviewer
- Product Analyst
- User Feedback Triage Agent
- Copy QA Agent
- Flow QA Agent
- Customer Journey Mapper

Owns:

- Product requirements
- UX quality
- Review readiness
- Review-layer standards
- User feedback conversion into work packets
- First-screen clarity
- Acceptance criteria

---

### CHRO — Chief Human Resources Officer

Mission: roles, onboarding, training, performance, and agent workforce health.

Direct reports:

- Recruiter
- Onboarding Specialist
- Training Lead
- Performance Manager
- Compensation / Role Designer
- Culture / Values Agent
- Agent Evaluation Specialist
- Skill Matrix Agent
- Team Capacity Planner

Owns:

- Role definitions
- Training plans
- Agent performance reviews
- Hiring / staffing logic
- Agent escalation standards

---

### CHO — Chief Health & Happiness Officer

Mission: keep the founder and system sustainable.

Direct reports:

- Energy / Focus Coach
- Workload Balancer
- Wellness Check Agent
- Break Planner
- Burnout Risk Monitor
- Morale / Recognition Agent
- Deep Work Protector
- Friction Reducer

Owns:

- Workload sanity
- Burnout risk
- Focus windows
- Founder energy
- Reducing noise
- Making the system easier to use

---

### CCO — Chief Customer Officer

Mission: customer success, support, voice of customer, and trust from the user/customer side.

Direct reports:

- Customer Success Manager
- Support Agent
- Customer Researcher
- Feedback Triage Agent
- Help Docs Writer
- Community Manager
- Sales Handoff Agent
- Onboarding Experience Agent
- Customer QA Agent

Owns:

- Customer support
- Voice-of-customer loops
- Help docs
- Support workflows
- User onboarding
- Customer feedback summaries

---

### CSO — Chief Security Officer

Assumption: `CSO` means Chief Security Officer. If strategy needs a separate seat later, create `Chief Strategy Officer`.

Mission: secrets, privacy, access, threat modeling, and safe deployment.

Direct reports:

- Security Architect
- Secrets Manager
- Privacy Analyst
- Compliance Risk Analyst
- Access Control Analyst
- Threat Modeler
- Webhook Security Reviewer
- Auth / Passkey Reviewer
- Incident Response Agent
- Legal Risk Reviewer

Owns:

- Secrets and tokens
- API key safety
- Auth design
- Passkey / Face ID safety rules
- Permission scopes
- Security reviews
- Safe webhook patterns
- No credentials in frontend, logs, screenshots, commits, or chat

---

### CIO — Chief Information Officer

Mission: internal knowledge systems, documentation, tool registry, and information architecture.

Direct reports:

- Knowledge Manager
- Documentation Librarian
- Tool Registry Manager
- Access / Permissions Analyst
- Information Architect
- Notion / Drive / GitHub Librarian
- Search / Retrieval Agent
- Memory Steward
- Source Quality Librarian
- Archive Manager

Owns:

- Knowledge base
- Project docs
- File organization
- Tool registry
- Information retrieval
- Durable project memory
- Context hygiene

## 4. Cross-functional pods

### Review Layer Pod

Owner: PRO  
Required chiefs: CTO, CSO, QA / Trust delegate, CIO

Workers:

- Review Layer Agent
- Frontend Engineer
- Backend / Webhook Engineer
- Mobile UX Reviewer
- Security Reviewer
- QA Automation Engineer
- Documentation Writer

Goal:

```text
iPhone review note → live-sync review layer → Cloudflare Worker → GitHub issue comment → ChatGPT/Codex action queue
```

### HVAC Copilot Pod

Owner: CTO  
Required chiefs: PRO, CDO, CSO, COO

Workers:

- Frontend Engineer
- Backend Engineer
- HVAC Data QA Analyst
- Mobile UX Reviewer
- CI / Release Engineer
- Documentation Writer
- Review Layer Agent

### Central HQ Pod

Owner: Chief of Staff  
Required chiefs: CIO, PRO, CTO, COO

Workers:

- Product Designer
- Frontend Engineer
- Information Architect
- Status Reporter
- GitHub / Codex Operator
- Documentation Writer

### Game Stat Pulse Pod

Owner: CDO  
Required chiefs: CTO, PRO, CSO

Workers:

- Sports Data Analyst
- Data Engineer
- Data Scientist
- API Engineer
- QA Automation Engineer
- Data Quality Engineer

### Southpaw Boxing Pod

Owner: PRO  
Required chiefs: CMO, CTO, COO

Workers:

- Product Designer
- Frontend Engineer
- UX Researcher
- SEO Strategist
- Copywriter
- Review Layer Agent

### Ghostwriting / Book Engine Pod

Owner: Chief of Staff  
Required chiefs: CIO, CDO, CMO, CHO

Workers:

- Ghostwriting Note Curator
- Editorial Agent
- Memory Steward
- Transcript / Notes Analyst
- Theme Mapper
- Timeline Builder
- Audio Book Planner

## 5. Message contract between agents

```json
{
  "from_agent": "cto",
  "to_agent": "frontend_engineer",
  "intent": "delegate_task",
  "project": "HVAC Copilot",
  "summary": "Build shared review layer status states.",
  "constraints": [
    "mobile-first",
    "no secrets in frontend",
    "no localStorage as final state",
    "must preserve draft text on failure"
  ],
  "expected_output": "small PR with tests and summary",
  "acceptance_criteria": [
    "Live sync status is shown",
    "Failed endpoint does not say saved",
    "CI/build result is reported"
  ],
  "status": "in_progress",
  "links": []
}
```

## 6. Escalate to CEO

Escalate before:

- Paid spend
- Auto-renewals or top-ups
- Secrets, tokens, API keys, or credential scope changes
- Production deploys with unresolved risk
- Destructive repo, database, or file actions
- Legal, privacy, compliance, or security risk
- Big architecture replacement
- Anything marked “Ready for CEO” when tests are failing

Do not escalate for:

- Draft docs
- Low-risk checklists
- Read-only reviews
- Codex prompt drafts
- Small internal documentation updates
- Non-production prototypes

## 7. Ready-for-CEO gate

A project can be marked `Ready for CEO review` only when:

1. Live link exists.
2. Review layer live-sync works, or the limitation is clearly shown.
3. CI is green, or failure is clearly stated.
4. Top blockers are resolved or visible.
5. The first screen says what the CEO should review.
6. The Chief of Staff has a short review note ready.
