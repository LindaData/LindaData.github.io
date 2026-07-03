# Agent Usage Event Format

Required fields:

- executive_owner
- agent
- task

Optional fields:

- id
- date
- minutes_estimate
- input_tokens
- output_tokens
- total_tokens
- proof
- status
- telemetry_source

Nested API usage is also accepted when available:

```json
{
  "usage": {
    "input_tokens": 328,
    "output_tokens": 52,
    "total_tokens": 380
  }
}
```

The worker normalizes accepted events into `usage-log.json`.
