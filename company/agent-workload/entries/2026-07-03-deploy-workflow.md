# 2026-07-03 Deploy Workflow Work

Owner lane:
- CTO
- CSO
- CIO
- Chief of Staff

Agents:
- DevOps / Cloud Engineer
- Security QA Agent
- Documentation Agent
- GitHub / Codex Operator

Task:
- Add GitHub Actions workflow for Agent Telemetry Worker deployment and document the workflow.

Estimate:
- minutes: 20
- input tokens: 6000
- output tokens: 3000
- total tokens: 9000

Proof:
- .github/workflows/deploy-agent-telemetry.yml
- /company/agent-workload/telemetry/README.md
- https://github.com/LindaData/field-copilot-pro/issues/72

Status:
- deploy pipeline added
- live deployment depends on external private credentials
