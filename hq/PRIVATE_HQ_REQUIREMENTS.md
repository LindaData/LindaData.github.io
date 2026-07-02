# Private HQ Requirements

## Non-negotiable

Do not expose private workflow data in public GitHub Pages source.

## What is allowed on `lindadata.github.io`

- Public-safe landing page.
- Link to HQ.
- High-level status with no private details.
- Login/lock screen.
- Static UI shell.

## What is not allowed in public source

- Personal schedule details.
- Private notes.
- Tokens/secrets.
- Internal strategy that should not be public.
- Sensitive financial/personal/relationship/health data.
- Anything that should require Sergio approval to view.

## Target user experience

1. Sergio opens `lindadata.github.io` on iPhone.
2. It opens HQ.
3. HQ shows locked state.
4. Sergio signs in using Apple-friendly credentials.
5. Face ID / Touch ID unlocks the saved passkey or password.
6. Private workflow data loads only after authentication.

## First safe release

Keep the root pointed to HQ and make the current dashboard public-safe. Build private auth before adding sensitive data.
