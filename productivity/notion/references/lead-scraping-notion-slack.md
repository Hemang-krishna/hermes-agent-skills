# Local Business Lead Scraping & Direct Notion/Slack Database Sync

## Workflow Overview

1. **Scrape Local Listings:** Query local business directories / Google Maps search endpoints (e.g., using `ddgs` or Playwright) for target business categories (e.g. Plumbers, Contractors, Mechanics) in a given city/region.
2. **Filter Website Absence:** Check whether `website` is missing / `None` / empty. Businesses without websites represent high-value web development, digital marketing, and local SEO sales leads.
3. **Lead Qualification Scoring:**
   - Base Score: +40 for missing website.
   - Phone presence: +25 if direct phone line available.
   - Review count: +20 for 20+ reviews, +10 for 5+ reviews.
   - Rating: +15 for 4.0+ rating.
   - Tiering: `HOT` (Score >= 75), `WARM` (Score >= 50), `COLD` (Score < 50).
4. **Direct Notion Sync:**
   - Search workspace connected objects via `POST /v1/search`.
   - Identify database ID where `"object"` is `"database"` or `"data_source"`.
   - Create typed page via `POST /v1/pages` with `parent: {"database_id": db_id}` and schema properties matching the database (`Task Name`, `Status`, `Priority`, `Assignee`, `Due Date`).
5. **Direct Slack Sync:**
   - Post formatted block/markdown lead card via Incoming Webhook or Bot API (`chat.postMessage`).
   - Include Lead Tier Emoji, Business Name, Location, Phone, Rating, Lead Score, Outreach Strategy, and Google Maps location URL.
