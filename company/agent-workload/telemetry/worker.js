export default {
  async fetch(request, env) {
    const url = new URL(request.url);
    const cors = {
      "access-control-allow-origin": env.ALLOWED_ORIGIN || "https://lindadata.github.io",
      "access-control-allow-methods": "GET,POST,OPTIONS",
      "access-control-allow-headers": "content-type,authorization,x-telemetry-token"
    };

    try {
      if (request.method === "OPTIONS") return new Response(null, { headers: cors });

      if (url.pathname === "/health") {
        return json({ ok: true, service: "lindadata-agent-telemetry", mode: "private-ingest" }, cors);
      }

      if (url.pathname === "/debug/github-token") {
        const authCheck = checkTelemetryAuth(request, env);
        if (!authCheck.ok) return json(authCheck, cors, 401);
        const result = await checkGitHubAccess(env);
        return json(result, cors, result.ok ? 200 : 502);
      }

      if (url.pathname === "/v1/agent-usage" && request.method === "POST") {
        const authCheck = checkTelemetryAuth(request, env);
        if (!authCheck.ok) return json(authCheck, cors, 401);

        let body;
        try { body = await request.json(); } catch { return json({ ok: false, error: "invalid_json" }, cors, 400); }

        const entry = sanitizeUsage(body);
        if (!entry.agent || !entry.task || !entry.executive_owner) {
          return json({ ok: false, error: "missing_required_fields" }, cors, 400);
        }

        try {
          const result = await appendToGitHubUsageLog(env, entry);
          return json({ ok: true, entry, github: result }, cors);
        } catch (err) {
          return json({ ok: false, error: "github_write_failed", detail: safeError(err) }, cors, 502);
        }
      }

      return json({ ok: false, error: "not_found" }, cors, 404);
    } catch (err) {
      return json({ ok: false, error: "worker_exception", detail: safeError(err) }, cors, 500);
    }
  }
};

function checkTelemetryAuth(request, env) {
  const auth = request.headers.get("authorization") || "";
  const headerToken = request.headers.get("x-telemetry-token") || "";
  const expected = env.TELEMETRY_WRITE_TOKEN;
  const given = auth.startsWith("Bearer ") ? auth.slice(7) : headerToken;
  if (!expected || given !== expected) return { ok: false, error: "unauthorized" };
  return { ok: true };
}

function sanitizeUsage(input) {
  const inputTokens = number(input.input_tokens ?? input.inputTokens ?? input.usage?.input_tokens);
  const outputTokens = number(input.output_tokens ?? input.outputTokens ?? input.usage?.output_tokens);
  const totalTokens = number(input.total_tokens ?? input.totalTokens ?? input.usage?.total_tokens ?? inputTokens + outputTokens);
  const now = new Date().toISOString();
  return {
    id: clean(input.id) || `${now.slice(0,10)}-${crypto.randomUUID()}`,
    date: clean(input.date) || now.slice(0, 10),
    source: "private_telemetry_api",
    executive_owner: clean(input.executive_owner || input.owner),
    agent: clean(input.agent),
    task: clean(input.task),
    minutes_estimate: number(input.minutes_estimate ?? input.minutes),
    input_tokens_estimate: inputTokens,
    output_tokens_estimate: outputTokens,
    total_tokens_estimate: totalTokens,
    proof: clean(input.proof),
    status: clean(input.status) || "done",
    telemetry_source: clean(input.telemetry_source) || "api_or_manual_report",
    created_at: now
  };
}

function githubToken(env) {
  return env.AGENT_TELEMETRY_GITHUB_TOKEN || env.GITHUB_TOKEN || "";
}

function githubTarget(env) {
  return {
    owner: env.GITHUB_OWNER || "LindaData",
    repo: env.GITHUB_REPO || "LindaData.github.io",
    branch: env.GITHUB_BRANCH || "master",
    path: env.USAGE_LOG_PATH || "company/agent-workload/usage-log.json"
  };
}

function githubHeaders(env) {
  const token = githubToken(env);
  if (!token) throw new Error("missing_agent_telemetry_github_token");
  return {
    "accept": "application/vnd.github+json",
    "authorization": `Bearer ${token}`,
    "content-type": "application/json",
    "user-agent": "lindadata-agent-telemetry"
  };
}

async function checkGitHubAccess(env) {
  try {
    const { owner, repo, branch, path } = githubTarget(env);
    const api = `https://api.github.com/repos/${owner}/${repo}/contents/${path}`;
    const res = await fetch(`${api}?ref=${encodeURIComponent(branch)}`, { headers: githubHeaders(env) });
    const body = await res.text();
    return { ok: res.ok, status: res.status, path, detail: res.ok ? "github_read_ok" : clean(body).slice(0, 220) };
  } catch (err) {
    return { ok: false, status: 0, detail: safeError(err) };
  }
}

async function appendToGitHubUsageLog(env, entry) {
  const { owner, repo, branch, path } = githubTarget(env);
  const api = `https://api.github.com/repos/${owner}/${repo}/contents/${path}`;
  const headers = githubHeaders(env);

  const currentRes = await fetch(`${api}?ref=${encodeURIComponent(branch)}`, { headers });
  if (!currentRes.ok) throw new Error(`github_get_${currentRes.status}_${clean(await currentRes.text()).slice(0, 120)}`);
  const current = await currentRes.json();
  const text = decodeBase64Utf8(current.content.replace(/\n/g, ""));
  const ledger = JSON.parse(text);
  ledger.updated = new Date().toISOString().slice(0,10);
  ledger.entries = [entry, ...(ledger.entries || [])].slice(0, 1000);

  const content = encodeBase64Utf8(JSON.stringify(ledger, null, 2) + "\n");
  const putRes = await fetch(api, {
    method: "PUT",
    headers,
    body: JSON.stringify({ message: `Log agent usage: ${entry.id}`, content, sha: current.sha, branch })
  });
  if (!putRes.ok) throw new Error(`github_put_${putRes.status}_${clean(await putRes.text()).slice(0, 120)}`);
  const saved = await putRes.json();
  return { commit: saved.commit?.sha, path };
}

function encodeBase64Utf8(text) {
  const bytes = new TextEncoder().encode(text);
  let binary = "";
  for (const byte of bytes) binary += String.fromCharCode(byte);
  return btoa(binary);
}

function decodeBase64Utf8(text) {
  const binary = atob(text);
  const bytes = Uint8Array.from(binary, c => c.charCodeAt(0));
  return new TextDecoder().decode(bytes);
}

function clean(value) {
  return String(value ?? "").replace(/[\u0000-\u001F\u007F]/g, " ").slice(0, 500);
}

function number(value) {
  const n = Number(value);
  return Number.isFinite(n) && n >= 0 ? Math.round(n) : 0;
}

function safeError(err) {
  return String(err?.message || err || "unknown_error").replace(/[\u0000-\u001F\u007F]/g, " ").slice(0, 220);
}

function json(data, headers = {}, status = 200) {
  return new Response(JSON.stringify(data), { status, headers: { ...headers, "content-type": "application/json" } });
}
