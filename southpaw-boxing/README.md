# Southpaw Boxing concept rebuild

This folder contains a LindaData concept rebuild for Southpaw Training Center / Southpaw Boxing.

Status: demo/prototype, not the official Southpaw website until approved by Southpaw Training Center.

## What was reviewed

### Current public site

- Canonical public site: `https://southpawboxing.net/`
- `https://southpawtrainingcenter.com/` redirects to the Southpaw Boxing site.
- Main navigation currently includes Home, Schedule, Shop, Contact Us, About Coach Jamie, Coaches, Southpaw Strong, Knockout Parkinson's, Testimonials, Training Certifications, Newsletter, Parties, Southpaw in the News, and Wellness pages.
- Key conversion link: WellnessLiving signup / first-class flow.
- Public contact info shown on the current site:
  - Southpaw Training Center
  - 13501 Dorman Road, Pineville, NC 28134
  - (980) 505-2291
- Current site footer says copyright 2022 and has a generic powered-by/cookie footer.

### Account / operations clues

- Gmail search confirmed Southpaw operational emails come from `no-reply@wellnessliving.com`.
- Email types found: class reminders, class cancellations, purchase receipts, auto-pay confirmation, membership renewal.
- The iOS and Google Play app listings also point to a Southpaw Training Center app connected to WellnessLiving.
- Recommendation: keep WellnessLiving as the scheduling, account, payment, membership, cancellation, reminders, and app backend for v1.

## UX diagnosis

### Current strengths

- Jamie McGrath is a strong credibility anchor.
- The gym has a local family/community angle that should stay.
- Small-group coaching is a strong differentiator.
- WellnessLiving already supports the operational system.
- There are multiple valuable programs: first class, women's classes, fight camp, youth/family/parties, Knockout Parkinson's, strength, boxing, Pilates/yoga/wellness.

### Current friction

- Navigation is too broad for a first-time visitor.
- Booking CTAs are present, but the handoff to WellnessLiving needs more explanation.
- The first-class experience needs a clearer anxiety-reducing path: what happens, what to bring, where to park, how hard it is, what if I am out of shape.
- Coach Jamie's proof is strong, but should be surfaced earlier and broken into scan-friendly proof blocks.
- Schedule and Shop pages appear thin from the public text snapshot.
- Content hierarchy mixes boxing, wellness, products, parties, news, and certifications without a tight conversion hierarchy.

## Benchmark takeaways

Sources reviewed:

- Rumble Boxing
- TITLE Boxing Club
- Mayweather Boxing + Fitness
- EverybodyFights

Reusable patterns for Southpaw:

1. Strong top CTA: Book / Try a class should always be visible.
2. First-timer reassurance: Explain exactly what the first session feels like.
3. Program cards: Let users self-select by goal and intensity.
4. Coach/community proof: Convert testimonials and media into trust modules.
5. App handoff: Present the app as convenience, not as a random external link.
6. Local SEO pages: Pineville boxing, Charlotte boxing, women's boxing, youth boxing, personal training, fight camp, boxing for beginners.
7. Mobile-first content: Short cards, sticky booking CTA, thumb-friendly review/booking actions.

## Architecture decision

Use a static GitHub Pages front door for the prototype.

Do not rebuild scheduling/payments yet. Link to WellnessLiving and app stores.

Future production stack can evolve to:

- Static marketing frontend or Next.js/Astro if the site grows.
- WellnessLiving embedded/linked flows for class operations.
- Analytics layer for CTA clicks and lead source attribution.
- Review endpoint bridge for founder notes.
- Optional CMS later for staff/news/testimonials.

## Review layer behavior

The page includes a founder review drawer that:

- Saves notes locally in the browser.
- Tags notes with page section, role/lens, viewport, timestamp, user agent, and URL.
- Lets the reviewer copy or export JSON.
- Can submit all notes to a secure endpoint when `reviewEndpoint` is provided.
- Accepts optional `reviewKey` for a Cloudflare Worker shared key.
- Never exposes GitHub tokens in frontend code.

Example review URL:

```text
https://lindadata.github.io/southpaw-boxing/?reviewEndpoint=https%3A%2F%2FYOUR-WORKER.workers.dev%2Fsubmit
```

Optional shared key:

```text
https://lindadata.github.io/southpaw-boxing/?reviewEndpoint=https%3A%2F%2FYOUR-WORKER.workers.dev%2Fsubmit&reviewKey=YOUR_REVIEW_KEY
```

Do not put a GitHub token in the URL or frontend.

## GitHub issue blocker

Issues are disabled on `LindaData/LindaData.github.io`, so a GitHub review inbox issue could not be created in this repository.

Options:

1. Enable Issues on this repo and create a `Southpaw Boxing Review Inbox` issue.
2. Point the review bridge to another LindaData repo with Issues enabled.
3. Keep local copy/export feedback until the production review bridge is wired.

## Files

- `index.html` — mobile-first concept rebuild with review layer.
- `review-bridge-worker.js` — optional Cloudflare Worker bridge pattern for submitting review notes to a GitHub issue.
- `site-audit.json` — structured audit data for future Codex/agent work.

## Next product tasks

Urgent:

- Review the page on iPhone.
- Confirm whether the tone should be more gritty/fight-focused or warmer/family-focused.
- Decide whether WellnessLiving should remain external or be embedded visually.
- Add real Southpaw-approved photos/videos only after permission.

Later:

- Build individual pages for First Class, Programs, Coach Jamie, Pricing, Schedule, Testimonials, and Contact.
- Add local SEO metadata.
- Add event tracking for CTA clicks.
- Add review Worker endpoint.
- Add a lightweight CMS or data file for class/program content.

Ignore for now:

- Custom scheduling backend.
- Payment backend.
- Native app rebuild.
- Private member portal replication.
