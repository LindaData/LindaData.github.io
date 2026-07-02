# LindaData HQ Security/Auth Plan

## Current state

`lindadata.github.io` is GitHub Pages. GitHub Pages serves static public files. Anything committed into this repo and deployed to Pages should be treated as public.

## Owner direction

Sergio wants the HQ at `lindadata.github.io` and wants sign-in to work with Apple saved credentials / Face ID where possible.

## Important distinction

Apple Face ID / passkeys are the right user experience, but real passkey authentication requires a server-side relying party to issue a challenge and verify the signed response. A static-only GitHub Pages file cannot securely verify identity or hide private data by itself.

## Safe plan

### Phase 1: Public-safe HQ entry

- Root `index.html` routes to `/hq/`.
- Do not put sensitive personal data, secrets, credentials, private notes, or private business details directly into public static files.
- Keep public cards high-level.

### Phase 2: Real private HQ

Use one of these secure approaches:

1. Cloudflare Access in front of a custom domain, for example `hq.lindadata.com`.
2. Cloudflare Worker auth gateway that protects private JSON/API responses.
3. Passkey/WebAuthn backend using a proper relying party flow.
4. Supabase/Auth0/Clerk/Firebase auth if we want managed login instead of custom auth.

### Phase 3: Apple-friendly sign-in

- Prefer passkeys/WebAuthn so Face ID or Touch ID can unlock sign-in on Apple devices.
- Apple Passwords/iCloud Keychain can also save a strong backup password if we choose password auth.
- Do not call a client-only JavaScript gate real security.

## Recommended first production path

Move private HQ data behind a Cloudflare Worker or Cloudflare Access-protected custom domain, then keep `lindadata.github.io` as the public-safe landing page or redirect.

## Acceptance criteria

- Public repo contains no private data.
- Private dashboard data is fetched only after auth.
- Auth uses passkey or identity-provider login.
- Notes still post through the review worker.
- If auth fails, the page shows no private project details.
