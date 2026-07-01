// Cloudflare Worker template for Southpaw Boxing review notes.
// Do not commit real secrets. Configure them in Cloudflare Worker settings.
//
// Required secrets / vars:
// - GITHUB_TOKEN: fine-grained GitHub token with Issues read/write on target repo
// - REVIEW_KEY: shared key used by the frontend x-review-key header
// - GITHUB_OWNER: example LindaData
// - GITHUB_REPO: repo with Issues enabled
// - GITHUB_ISSUE: issue number to receive comments
// - ALLOWED_ORIGIN: example https://lindadata.github.io

const MAX_NOTES = 100;
const MAX_TEXT_LENGTH = 4000;

function corsHeaders(env) {
  return {
    "access-control-allow-origin": env.ALLOWED_ORIGIN || "https://lindadata.github.io",
    "access-control-allow-methods": "POST, OPTIONS",
    "access-control-allow-headers": "content-type, x-review-key",
    "access-control-max-age": "86400"
  };
}

function jsonResponse(body, status, env) {
  return new Response(JSON.stringify(body, null, 2), {
    status,
    headers: {
      "content-type": "application/json; charset=utf-8",
      ...corsHeaders(env)
    }
  });
}

function cleanText(value, maxLength = MAX_TEXT_LENGTH) {
  return String(value || "")
    .replace(/[\u0000-\u001f\u007f]/g, " ")
    .replace(/\s+/g, " ")
    .trim()
    .slice(0, maxLength);
}

function validatePayload(payload) {
  if (!payload || typeof payload !== "object") return "Missing JSON payload.";
  if (payload.project !== "southpaw-boxing-rebuild") return "Unexpected project.";
  if (!Array.isArray(payload.notes) || payload.notes.length === 0) return "No notes provided.";
  if (payload.notes.length > MAX_NOTES) return `Too many notes. Max ${MAX_NOTES}.`;
  for (const note of payload.notes) {
    if (!cleanText(note.text, 1)) return "Each note needs text.";
  }
  return null;
}

function formatComment(payload) {
  const source = payload.source || {};
  const header = [
    "## Southpaw Boxing review notes",
    "",
    `- Project: \`${cleanText(payload.project, 120)}\``,
    `- Page: \`${cleanText(payload.page, 160)}\``,
    `- Source: ${cleanText(source.href, 300) || "unknown"}`,
    `- Submitted: ${new Date().toISOString()}`,
    ""
  ];

  const notes = payload.notes.map((note, index) => {
    return [
      `### ${index + 1}. ${cleanText(note.section, 120) || "General"}`,
      "",
      `- Lens: ${cleanText(note.role, 120) || "Founder"}`,
      `- Created: ${cleanText(note.createdAt, 80) || "unknown"}`,
      `- Viewport: ${cleanText(note.viewport, 80) || "unknown"}`,
      "",
      cleanText(note.text),
      ""
    ].join("\n");
  });

  return [...header, ...notes].join("\n");
}

async function createIssueComment(env, body) {
  const owner = env.GITHUB_OWNER;
  const repo = env.GITHUB_REPO;
  const issueNumber = env.GITHUB_ISSUE;
  if (!owner || !repo || !issueNumber) throw new Error("Missing GitHub target env vars.");

  const response = await fetch(`https://api.github.com/repos/${owner}/${repo}/issues/${issueNumber}/comments`, {
    method: "POST",
    headers: {
      "authorization": `Bearer ${env.GITHUB_TOKEN}`,
      "accept": "application/vnd.github+json",
      "content-type": "application/json",
      "user-agent": "lindadata-southpaw-review-bridge"
    },
    body: JSON.stringify({ body })
  });

  if (!response.ok) {
    const detail = await response.text();
    throw new Error(`GitHub comment failed: ${response.status} ${detail.slice(0, 300)}`);
  }

  return response.json();
}

export default {
  async fetch(request, env) {
    if (request.method === "OPTIONS") return new Response(null, { status: 204, headers: corsHeaders(env) });
    const url = new URL(request.url);
    if (request.method !== "POST" || url.pathname !== "/submit") {
      return jsonResponse({ ok: false, error: "Use POST /submit." }, 404, env);
    }

    const reviewKey = request.headers.get("x-review-key") || "";
    if (!env.REVIEW_KEY || reviewKey !== env.REVIEW_KEY) {
      return jsonResponse({ ok: false, error: "Unauthorized review key." }, 401, env);
    }

    if (!env.GITHUB_TOKEN) {
      return jsonResponse({ ok: false, error: "Worker missing GITHUB_TOKEN secret." }, 500, env);
    }

    let payload;
    try {
      payload = await request.json();
    } catch (error) {
      return jsonResponse({ ok: false, error: "Invalid JSON." }, 400, env);
    }

    const validationError = validatePayload(payload);
    if (validationError) return jsonResponse({ ok: false, error: validationError }, 400, env);

    try {
      const comment = await createIssueComment(env, formatComment(payload));
      return jsonResponse({ ok: true, comment_url: comment.html_url || null }, 200, env);
    } catch (error) {
      return jsonResponse({ ok: false, error: error.message }, 500, env);
    }
  }
};
