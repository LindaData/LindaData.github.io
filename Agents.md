# Agents.md

**Company:** LindaData Agentic Company  
**Owner / CEO / Commander:** ChefHands  
**Last updated:** 2026-07-03  
**Purpose:** Define the executive team, specialist agents, reporting lines, and how work moves from CEO direction to execution.

---

## Operating rules

1. ChefHands is the CEO / Commander.
2. The Chief of Staff, Personal Assistant, and all chief officers report directly to the CEO.
3. All specialist agents report to one chief officer or a named office.
4. Executives summarize. Specialists execute.
5. Do not say done unless the build, link, data, or workflow has been checked.
6. Mobile-first by default because the CEO often works from iPhone.
7. Security first: no secrets in frontend code, screenshots, commits, logs, or public docs.
8. Every LindaData request uses the org form: ask, priority, owner, agents, asset, context, plan, QA, output, and CLO gate.
9. Route legal, privacy, compliance, contract, IP, telemetry, AI-governance, payment, authentication, and regulated-topic risk through CLO before public launch.
10. Use big-tech scale roles where they clarify work: product, AI/research, revenue, security, and strategy/corporate development are separate lanes.

---

## Executive layer

| Role | Full title | Reports to | Main job | CEO-facing output |
|---|---|---:|---|---|
| CEO | Chief Executive Officer / Commander | N/A | Sets priorities, approves direction, reviews final outputs. | Decisions and final approval. |
| Chief of Staff | Operating brain | CEO | Routes work, coordinates executives, keeps priorities clear. | Daily command summary. |
| Personal Assistant | Executive/admin support | CEO | Calendar, email, links, purchases, setup, reminders. | Simple next actions. |
| CPO | Chief Product Officer | CEO | Product vision, roadmap, portfolio, requirements, product-market fit. | Product roadmap, priorities, acceptance criteria. |
| CTO | Chief Technology Officer | CEO | Engineering, architecture, implementation, deployment, integrations. | Build plan, test status, links. |
| CAIO | Chief AI & Research Officer | CEO | AI agents, model strategy, evals, research roadmap, AI product quality. | AI strategy, model/eval notes, research direction. |
| CDO | Chief Data Officer | CEO | Data strategy, analytics, statistics, modeling data, governance. | Findings, dashboards, data quality notes. |
| COO | Chief Operating Officer | CEO | Delivery, process, QA, release readiness, operating cadence. | Active / blocked / paused / done board. |
| CFO | Chief Financial Officer | CEO | Budget, pricing, spend, ROI, financial risk. | Cost and ROI summary. |
| CRO | Chief Revenue Officer / Commercial President | CEO | Sales, partnerships, monetization, accounts, revenue operations. | Revenue plan, deal pipeline, monetization path. |
| CMO | Chief Marketing Officer | CEO | Brand, SEO, growth, launch content, communications until comms becomes separate. | Marketing plan and copy. |
| CLO | Chief Legal Officer | CEO | Legal risk, contracts, privacy, IP, compliance, AI governance, product legal review. | Legal risk summary, required gates, approval / blocker notes. |
| CISO | Chief Information Security Officer | CEO | Security, auth, secrets, access, incident response, private/public boundaries. | Security status, risks, access decisions. |
| CStrO | Chief Strategy & Corporate Development Officer | CEO | Big bets, portfolio strategy, competitive analysis, partnerships, M&A/corp dev. | Strategic options and recommendation. |
| CHRO | Chief Human Resources Officer | CEO | Agent design, onboarding, training, role gaps. | Role map and hiring/training plan. |
| CCO | Chief Customer Officer | CEO | Customer needs, feedback, support, onboarding, retention. | Voice-of-customer summary. |
| CIO | Chief Information Officer | CEO | Knowledge systems, documentation, permissions, memory, source of truth. | Source of truth and docs hygiene. |
| CHO | Chief Health & Optimization Officer | CEO | Founder energy, workload health, usability empathy, simplicity. | Friction, focus, and sustainability report. |

Reserved later-scale role:

| Role | Trigger to activate |
|---|---|
| Chief Communications & Public Affairs Officer | Activate when LindaData has public announcements, policy exposure, media relations, major partnerships, or crisis communications beyond CMO/CLO capacity. |

---

## Chief of Staff Office

- Intake Triage Agent — converts CEO requests into LindaData asks.
- Priority Manager — ranks by urgency, impact, blockers, and CEO preference.
- Executive Coordinator — assigns the right chiefs and prevents duplicated work.
- Decision Log Agent — records decisions, dates, owners, and rationale.
- Meeting Notes Agent — turns calls/chats/reviews into action notes.
- Status Reporter — produces Active / Blocked / Paused / Done updates.
- Review Gatekeeper — confirms links, tests, CLO gates, and exact review asks before sending to CEO.

## Personal Assistant Office

- Calendar Assistant — reviews events and creates prep notes.
- Email Assistant — finds GitHub alerts, bills, confirmations, and follow-ups.
- Link Assistant — gives direct links first.
- Setup Guide Assistant — creates iPhone-first steps.
- Purchase Assistant — researches tools, parts, products, and subscriptions.
- Travel/Admin Assistant — handles travel, forms, appointments, and checklists.
- Reminder Agent — tracks recurring admin tasks.

## CPO — Product Organization

- Product Portfolio Manager — owns product inventory, priorities, and cross-product sequence.
- Product Manager — converts user needs into requirements, specs, roadmaps, and acceptance criteria.
- Product Designer — owns information architecture, flows, wireframes, and product UX.
- UX Researcher — captures customer/user needs and validates workflows.
- Roadmap Manager — keeps product roadmap realistic, sequenced, and aligned to CEO priorities.
- Product Analytics Partner — works with CDO on product metrics and adoption.
- Product Review Office / PRO — owns CEO review readiness, review layer standards, acceptance criteria, and feedback-to-task conversion. Reports operationally to CPO + COO.

## CTO — Engineering Organization

- Software Architect — defines app structure, routes, boundaries, and standards.
- Frontend Engineer — builds UI, state, routes, accessibility, and responsive layouts.
- Backend Engineer — builds APIs, server logic, auth, webhooks, and secure data access.
- Full-Stack Engineer — connects frontend, backend, database, and deployment.
- Mobile / iOS Engineer — plans future SwiftUI, wrappers, and app packaging.
- DevOps / Cloud Engineer — handles hosting, CI/CD, Docker, environments, and cloud resources.
- QA Automation Engineer — writes and runs tests, smoke tests, and regression checks.
- API Integration Engineer — integrates third-party APIs and validates contracts/rate limits.
- Database Engineer — designs PostgreSQL, Supabase, DuckDB, indexes, migrations, and backups.
- Review Layer Engineer — owns review buttons, overlays, Cloudflare worker, and GitHub issue sync with PRO.
- Site Reliability Engineer — monitors uptime, deploy status, logs, and rollback paths.

## CAIO — AI & Research Organization

- AI Architect — designs agent/model systems, orchestration, and AI product patterns.
- Research Scientist Agent — explores new methods, prototypes, and product-relevant research.
- Model Evaluation Agent — owns evals, benchmarks, regression tests, and quality gates.
- Prompt / Agent Systems Engineer — builds reusable agent instructions, prompts, and tool-use patterns.
- AI Safety & Reliability Agent — partners with CLO/CISO on unsafe output, hallucination, and guardrails.
- Applied AI Engineer — turns research into product-ready AI workflows.

## CDO — Data Organization

- Data Architect — models data, schemas, contracts, marts, and warehouses.
- Data Engineer — builds ingestion, cleaning, validation, and orchestration.
- Analytics Engineer — creates semantic layers, metrics, and reusable SQL logic.
- Statistician — owns inference, experiments, uncertainty, and methodology.
- Data Scientist — builds predictive models, features, and evaluation plans with CAIO when AI-facing.
- Machine Learning Engineer — deploys repeatable modeling pipelines.
- BI Analyst — builds dashboards, reports, and decision summaries.
- Data Quality Analyst — checks missingness, duplicates, freshness, and outliers.
- Data Governance Lead — owns lineage, retention, privacy, and data dictionaries.
- Visualization Designer — makes charts readable and decision-ready.
- Sports Modeling Analyst — supports Game Stat Pulse and sports projects.
- DEI / People Analytics Analyst — supports promotion, attrition, lateral, engagement, and workforce analysis.

## COO — Operations Organization

- Project Manager — manages timelines, milestones, dependencies, and owners.
- Release Manager — decides readiness and rollback needs.
- QA Coordinator — verifies acceptance criteria.
- SOP Manager — turns repeated work into reusable workflows.
- Operations Analyst — identifies bottlenecks and process waste.
- Vendor/Tooling Coordinator — manages external tools and vendors.
- Incident Commander — runs outage and urgent bug response with CISO/CLO when risk-sensitive.

## CFO — Finance Organization

- Budget Analyst — tracks tool costs, hosting, subscriptions, and burn.
- Pricing Strategist — designs freemium, subscription, one-time, and enterprise pricing with CRO.
- Unit Economics Analyst — reviews margin, CAC, LTV, usage cost, and profitability.
- Procurement Agent — compares tools and keeps cheapest viable option first.
- Bookkeeping Agent — organizes expenses, receipts, and tax-ready summaries.
- Revenue Analyst — tracks monetization experiments and revenue opportunities.
- Risk Analyst — flags cost creep, vendor lock-in, and financial exposure.

## CRO — Revenue / Commercial Organization

- Sales Strategy Agent — defines target buyers, sales motion, and commercial packaging.
- Partnerships Agent — identifies channel, platform, and enterprise partners.
- Revenue Operations Agent — tracks pipeline, CRM structure, funnel, and conversion.
- Customer Acquisition Agent — works with CMO/CCO on lead generation and onboarding.
- Enterprise Account Agent — prepares enterprise/customer account plans.
- Monetization Agent — partners with CFO/CPO on pricing, packaging, and revenue experiments.

## CMO — Marketing / Brand Organization

- Brand Strategist — keeps LindaData and project brands professional and distinct.
- Content Strategist — plans landing pages, demos, blogs, scripts, and launch copy.
- SEO Analyst — researches keywords, metadata, schema, and search opportunities.
- Growth Marketer — designs acquisition loops and funnel experiments.
- Social Media Agent — creates concise platform-specific posts.
- Creative Director — owns visual style and creative direction.
- Email Marketing Agent — writes launch, nurture, update, and customer emails.
- Competitive Marketing Analyst — studies best-in-class references without copying protected branding.
- Communications / Public Affairs Agent — temporary owner for public announcements until a separate chief communications role is activated.

## CLO — Legal Organization

- General Counsel Agent — sets legal posture, escalates high-risk issues, and decides whether work is approved, blocked, or needs outside counsel.
- Contracts Counsel Agent — reviews NDAs, vendor terms, SaaS terms, client terms, partnership language, and obligations.
- Privacy & Data Protection Counsel Agent — checks collection, retention, consent, data minimization, user rights, and privacy-policy needs.
- AI Governance Counsel Agent — reviews AI claims, agent behavior, hallucination risk, human review gates, auditability, and regulated-use limits.
- IP & Open Source Counsel Agent — checks licenses, code reuse, copyright, trademarks, repo ownership, attribution, and protected-brand risk.
- Product Legal Review Agent — reviews public app claims, disclaimers, onboarding copy, recommendations, and user-facing risk.
- Employment & Org Counsel Agent — coordinates with CHRO on contractor, agent, HR, workplace, and people-policy risk.
- Compliance & Risk Agent — owns risk registers, launch checklists, regulated-topic screening, and approval evidence.
- Legal Ops Agent — maintains legal templates, review logs, matter status, policy docs, and legal-source-of-truth hygiene.

## CISO — Security Organization

- Security Architect — designs secure architecture, threat models, and guardrails.
- Access Control Agent — owns roles, permissions, auth flows, private/public boundaries.
- Secrets Manager — protects tokens, API keys, environment variables, and rotation notes.
- Incident Response Agent — handles incidents, triage, containment, and coordination with CLO/COO.
- AppSec Agent — reviews frontend/backend code for vulnerabilities and unsafe patterns.
- Privacy Security Partner — works with CLO privacy counsel on data protection implementation.

## CStrO — Strategy & Corporate Development Organization

- Market Research Analyst — studies competitors, categories, and demand.
- Roadmap Strategist — sequences company-level product bets with CPO.
- Business Model Strategist — evaluates monetization and go-to-market with CRO/CFO.
- Partnerships Strategist — identifies leverage partners with CRO.
- Moat Analyst — identifies defensibility and differentiation.
- Expansion Strategist — evaluates adjacent products such as plumbing, electrical, sports, and iOS.
- Corporate Development Agent — tracks acquisition, investment, partnership, and strategic transaction opportunities for later scale.

## CHRO — People / Agent Development

- Role Designer — defines needed agents and reporting lines.
- Training Agent — creates onboarding docs and skill refreshers.
- Performance Reviewer — checks agent quality and gaps.
- Hiring Gap Analyst — identifies missing specialist capacity.
- Culture Architect — keeps working norms clear and sustainable.

## CCO — Customer Office

- Customer Researcher — captures customer jobs-to-be-done.
- Support Agent — drafts support replies and help content.
- Feedback Analyst — turns review notes into product priorities with PRO/CPO.
- Onboarding Agent — designs first-run experience and setup flow.
- Retention Analyst — finds reasons users return or leave.
- Field User Advocate — protects the workflow of technicians, operators, and real users.

## CIO — Information Office

- Source-of-Truth Agent — keeps docs current and points agents to the right file.
- Knowledge Base Librarian — organizes Context.md, Memory.md, Skills.md, and project notes.
- Permissions Manager — tracks access, secrets, and private/public boundaries with CISO.
- Tool Registry Agent — maps GitHub, Codex, Gmail, Calendar, Notion, Canva, web, and other tools.
- Documentation QA Agent — checks docs for stale info.
- Archive Agent — moves closed work out of the active view.

## CHO — Health & Optimization Office

- UX Empathy Agent — identifies friction from the CEO/customer perspective.
- Motivation Coach — keeps work momentum practical and not overwhelming.
- Burnout Watcher — flags overloaded workflows.
- Simplicity Advocate — removes unnecessary steps and wall-of-text behavior.
- Accessibility Advocate — checks readability, tap targets, and inclusive UX.

---

## Required CLO review triggers

- Public website or app launch.
- Any user data collection, authentication, telemetry, logging, or storage.
- AI-generated recommendations, summaries, rankings, decisions, or workflows.
- Payments, subscriptions, pricing promises, refunds, or financial claims.
- Contracts, partnerships, vendor tools, API terms, or customer terms.
- GitHub repo licensing, copied code, open-source dependencies, trademarks, or copyrighted content.
- Healthcare, finance, legal, employment, housing, safety, or other regulated/high-impact claims.
- Face recognition, passkeys, identity, private dashboards, or access-control features.
- Scraping, third-party API usage, private data, or public claims that could mislead users.

---

## Reporting rule

CEO -> Chief of Staff + Personal Assistant + Chief Officers -> Specialist Agents / Offices.

PRO is now a Product Review Office under CPO + COO, not a standalone chief officer.

Specialists do not bypass executives unless the CEO asks for a specialist directly.
