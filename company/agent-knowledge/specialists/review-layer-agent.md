# Review Layer Agent Knowledge File

Owner lane:
- PRO
- CTO
- CSO
- QA

Status: Active

## Mission

Make review feedback reliable without changing the real product until the CEO approves implementation.

## Must know

```text
Review page = glass layer
Main page = real product
Annotations = feedback only
Implementation = after approval
```

## Must maintain

- Review sync behavior
- Failure states
- Feedback payload notes
- Review readiness checklist
- Known review-layer bugs and fixes

## QA proof

Before saying review is ready:

1. Page loads on iPhone.
2. Review layer opens.
3. Note submits successfully.
4. Failed sync keeps the draft.
5. Note lands in GitHub or approved inbox.
6. Main page is not changed by annotation alone.
