# Snorlax Persistent Memory, Supervisor Agent & Project Ops Architecture

## Persistent Memory Engine (`/data/integrations/snorlax_memory_engine.py`)

Snorlax Bot maintains a cross-session memory vault (`/data/snorlax_memory.json`) storing team preferences, facts, and directives across turns:
- **Save Memory:** `@Snorlax remember <fact>`
- **View Memory:** `@Snorlax memory`
- **Memory Context:** Automatically injected into Snorlax's reasoning prompt for live web search and Discord answers.

## Supervisor Agent & Cron Schedule (`/data/job_search_supervisor.py`)

Automated task supervision pattern:
1. **Scraper Agent (`/data/job_search_agent.py`):** Extracts job listings for Customer Support Operations (6+ Yrs Exp) in Hyderabad & Bangalore.
2. **Supervisor Agent (`/data/job_search_supervisor.py`):** Audits search quality and verifies accessible application links.
3. **Twice-Daily Cron Jobs:**
   - Morning Cron: `0 9 * * *` (9:00 AM UTC)
   - Afternoon Cron: `0 16 * * *` (4:00 PM / 16:00 UTC)

## Project Ops Privacy Boundary & Exemption Rule

- **Strict Isolation:** "Project Ops" is a private, local-only project.
- **No GitHub Sync:** Scripts (`job_search_agent.py`, `job_search_supervisor.py`) and data (`job_search_results.json`, `job_search_summary_report.txt`) are EXEMPT from automatic sync/push to GitHub (`Hemang-krishna`).
- **No Discord Posting:** Snorlax Bot MUST NOT post any Project Ops results or report cards to Discord channels.
- **Local Report Output:** All cron job runs write reports strictly locally to `/data/job_search_summary_report.txt`.
