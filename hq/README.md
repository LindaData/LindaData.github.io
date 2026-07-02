# LindaData HQ

`https://lindadata.github.io` should open this HQ command center.

## Security position

GitHub Pages is public static hosting. Treat every committed file as public.

For real private workflow data, use an auth-backed layer before sensitive details are shown:

- Cloudflare Access on a custom domain, or
- Cloudflare Worker auth gateway, or
- managed auth such as Supabase/Auth0/Clerk/Firebase.

Apple-friendly sign-in should use passkeys/WebAuthn or a saved strong password in Apple Passwords/iCloud Keychain. Face ID can unlock Apple Passwords/passkeys on supported Apple devices, but static GitHub Pages cannot verify passkeys by itself.
