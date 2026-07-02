# Codex Work Packet — Private LindaData HQ Auth

## Goal

Add a real private mode for LindaData HQ without pretending GitHub Pages alone can secure private data.

## Required architecture

- Public GitHub Pages can show only public-safe shell content.
- Private workflow details must be served after authentication from a protected backend.
- Preferred owner UX: Apple passkey / Face ID / Touch ID, with saved credentials in Apple Passwords/iCloud Keychain.

## Implementation options

### Option A — fastest secure path

Use a custom domain behind Cloudflare Access.

- Example: `hq.lindadata.com`
- Protect with Cloudflare Access email/OTP or identity provider first.
- Later add passkeys/WebAuthn if needed.

### Option B — passkey-first Worker

Build a Cloudflare Worker auth gateway.

Required endpoints:

- `GET /auth/status`
- `POST /auth/register/options`
- `POST /auth/register/verify`
- `POST /auth/login/options`
- `POST /auth/login/verify`
- `GET /private/workflows.json`

Storage:

- D1 or KV for public keys, credential IDs, user handles, session ids, and allowed emails.

Security rules:

- Challenge generated server-side.
- Verify origin and relying party id.
- HttpOnly Secure SameSite cookie for session.
- No private data in static HTML/JS.
- No tokens in browser source, query strings, or localStorage.

## UI behavior

- Root `lindadata.github.io` opens HQ.
- HQ shows a locked shell if unauthenticated.
- After auth, fetch private workflow data.
- If auth fails, show no private details.
- Notes continue to post to the existing review worker.

## Acceptance criteria

- Directly viewing source does not reveal private data.
- Private JSON endpoint rejects unauthenticated users.
- Face ID / Touch ID passkey login works on iPhone Safari.
- Apple Passwords can save/use credentials.
- The page clearly distinguishes public-safe mode from private mode.
