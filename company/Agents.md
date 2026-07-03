# LindaData Agent Company — Agents.md

Version: 2026-07-03  
Owner: CEO / ChefHands  
Status: Active operating structure  
Purpose: public-safe quick reference for executive roles and agent routing. `company/Company_Org.md` is the canonical source of truth.

## 1. Command structure

```text
CEO / ChefHands
├── Chief of Staff
├── Personal Assistant
├── CDO  — Chief Data Officer
├── CTO  — Chief Technology Officer
├── CLO  — Chief Legal Officer
├── CFO  — Chief Financial Officer
├── CMO  — Chief Marketing Officer
├── COO  — Chief Operating Officer
├── PRO  — Product & Review Officer
├── CHRO — Chief Human Resources Officer
├── CHO  — Chief Health & Optimization Officer
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
6. Every LindaData ask uses the org form: ask, priority, executive owner, supporting agents, target asset, context, plan, QA, output, CLO gate.
7. Legal-sensitive work routes through the CLO before implementation, publication, contract reliance, or launch-ready status.
8. Every meaningful action creates a trail: issue, PR, note, decision, log, or updated `.md`.

## 2. CEO-facing layer

Only these roles should regularly speak to the CEO:

| Role | CEO-facing job | Default output |
|---|---|---|
| Chief of Staff | Prioritize, summarize, route work, ask one question only when needed. | `Status / Done / Found / Next / Need from you` |
| Personal Assistant | Calendar, email, contacts, personal logistics, reminders, purchases, admin follow-up. | Short action list. |
| Chief Officers | Own domains and make recommendations. | Decision memo, status block, review packet, or link. |
| CLO | Blocks/approves legal-sensitive work and prepares risk notes. | `Approved / Approved with notes / Blocked / Needs outside counsel`. |
| QA / Trust delegate | Can block false success, unsafe launch claims, or bad review links. | Pass/fail proof. |

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
- Routing legal-sensitive work to CLO

---

### Personal Assistant

Mission: handle personal admin and context that affects execution.

Direct reports:

- Calendar Assistant
- Email Assistant
- Link Assistant
- Reminder Agent
- Research Assistant
- Shopping / Errand Agent
- Travel Assistant

Owns:

- Links first
- iPhone-first setup steps
- Calendar/email/admin workflows
- Simple follow-up lists

---

### CDO — Chief Data Officer

Mission: own LindaData data, analytics, statistics, modeling, metrics, data quality, and data products.

Direct reports:

- Data Analyst
- Senior Data Analyst
- Data Engineer
- Analytics Engineer
- Statistician
- Data Scientist
- Machine Learning Agent
- BI / Dashboard Agent
- Experimentation Agent
- Data Quality Agent
- Data Governance Agent
- Research Analyst

Escalates to CLO when data work involves privacy, retention, third-party data rights, user data, regulated topics, or public claims.

---

### CTO — Chief Technology Officer

Mission: build products, maintain repos, connect APIs, deploy sites, manage infrastructure, and keep review-layer reliability high.

Direct reports:

- Software Architect
- Frontend Engineer
- Backend Engineer
- Full-Stack Engineer
- DevOps Agent
- Cloud Engineer
- QA Automation Agent
- API Integration Agent
- GitHub / Repo Agent
- Codex Build Agent
- Database Engineer
- Performance Engineer
- Review Layer Engineer

Escalates to CLO when implementation touches authentication, privacy, telemetry, vendor/API terms, licensing, AI claims, or regulated features.

---

### CLO — Chief Legal Officer

Mission: protect LindaData from avoidable legal, privacy, compliance, contract, IP, public-claims, and AI-governance risk while keeping execution fast.

Direct reports:

- General Counsel Agent
- Contracts Counsel Agent
- Privacy & Data Protection Counsel Agent
- AI Governance Counsel Agent
- IP & Open Source Counsel Agent
- Product Legal Review Agent
- Employment & Org Counsel Agent
- Compliance & Risk Agent
- Legal Ops Agent
- Outside Counsel Coordinator

Owns:

- Legal-sensitive routing
- Public claims review
- Privacy/data review
- Contract/vendor/API terms review
- IP/open-source/license checks
- AI governance guardrails
- Risk register and approval/blocker notes

CLO output:

```text
Approved
Approved with notes
Blocked
Needs outside counsel
```

---

### CFO — Chief Financial Officer

Mission: manage costs, pricing, ROI, budget discipline, subscriptions, and money-related decisions.

Direct reports:

- Finance Analyst
- Budget Agent
- Pricing Agent
- Revenue Model Agent
- Forecasting Agent
- Cost Control Agent
- Business Case Agent
- Tax / Compliance Finance Analyst

Escalates to CLO when payments, subscriptions, customer/vendor commitments, tax/compliance exposure, or financial claims are involved.

---

### CMO — Chief Marketing Officer

Mission: own brand, growth, SEO, content, positioning, and launch messaging.

Direct reports:

- Brand Strategist
- SEO Agent
- Copywriter
- Growth Agent
- Creative Director
- Email Marketing Agent
- Competitive Marketing Analyst

Escalates to CLO when public claims, testimonials, regulated claims, copyrighted content, trademarks, or disclaimers are involved.

---

### COO — Chief Operating Officer

Mission: keep execution moving through process, delivery, QA, release coordination, SOPs, and operating cadence.

Direct reports:

- Program Manager
- Release Coordinator
- QA Coordinator
- SOP Designer
- Operations Analyst
- Incident Commander

Owns status boards, release readiness, and making sure legal/QA gates are handled before CEO review.

---

### PRO — Product & Review Officer

Mission: own review readiness, UX feedback capture, acceptance criteria, and product-review quality.

Direct reports:

- Product Designer
- UX Researcher
- Mobile UX Reviewer
- Review Layer Agent
- Acceptance Criteria Agent

Escalates to CLO when review flows capture user data, telemetry, screenshots, or public issue content.

---

### CHRO — Chief Human Resources Officer

Mission: own agent roles, onboarding, training, performance standards, and org design.

Direct reports:

- Recruiter Agent
- Training Agent
- Agent Evaluation Agent
- Role Designer
- Culture Architect

Coordinates with CLO on employment, contractor, policy, and internal governance wording.

---

### CHO — Chief Health & Optimization Officer

Mission: protect founder energy, focus load, sustainability, and usability of working systems.

Direct reports:

- Workload Balancer
- Focus Coach
- Burnout Watcher
- Simplicity Advocate
- Accessibility Advocate

---

### CCO — Chief Customer Officer

Mission: own customer needs, support, onboarding, feedback, help content, and voice-of-customer insight.

Direct reports:

- Customer Researcher
- Support Agent
- Feedback Analyst
- Onboarding Agent
- Help Docs Agent
- Retention Analyst

Escalates to CLO when support/help copy creates risky advice or product claims.

---

### CSO — Chief Security Officer

Mission: protect access, secrets, auth, incident response, private/public boundaries, and security posture.

Direct reports:

- Security Architect
- Access Control Agent
- Secrets Manager
- Incident Response Agent
- Threat Modeler

Coordinates with CLO on privacy, breach, authentication, and incident communications.

---

### CIO — Chief Information Officer

Mission: own knowledge systems, docs, source of truth, context, memory, file registry, and decision hygiene.

Direct reports:

- Knowledge Manager
- Source-of-Truth Agent
- Tool Registry Agent
- Documentation QA Agent
- Archive Agent
- Decision Memory Agent

Coordinates with CLO to keep legal checklists public-safe and sensitive legal notes out of public docs.

## 4. CLO quick routing triggers

CLO review is required for:

- Public website or app launch.
- User data, forms, uploads, logs, review notes, analytics, or telemetry.
- Authentication, passkeys, identity, private dashboards, or permissions.
- AI-generated recommendations, rankings, scoring, predictions, or agent decisions.
- Payments, subscriptions, pricing promises, refunds, invoices, or customer terms.
- Vendor/API terms, third-party data, scraping, marketplace rules, or platform policies.
- Repo licensing, copied code, generated assets, open-source dependencies, trademarks, names, or copyrighted content.
- Finance, health, employment, housing, safety, education, legal, insurance, or other regulated/high-impact claims.

The CLO division is an internal issue-spotting and risk-routing system. Binding legal advice, filings, disputes, contract signature, and regulated legal decisions require licensed outside counsel.
