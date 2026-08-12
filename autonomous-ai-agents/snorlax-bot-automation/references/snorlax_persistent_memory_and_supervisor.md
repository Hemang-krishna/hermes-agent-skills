# Snorlax Persistent Memory Engine & Supervisor Isolation Reference

## 🧠 Persistent Memory Engine (`/data/integrations/snorlax_memory_engine.py`)

Snorlax Bot maintains a cross-session persistent memory vault stored at `/data/snorlax_memory.json`.

### Features
1. **Facts & Directives Store:** Stores team preferences, executive roles, and operational directives across restarts.
2. **Discord Interactive Memory Commands:**
   - `@Snorlax remember <fact>`: Saves a new fact/rule directly to `/data/snorlax_memory.json`.
   - `@Snorlax memory`: Displays the current persistent facts and rules logged in memory.
3. **Exact Web Search Synthesis:** Combines persistent memory context with live DuckDuckGo web search results to deliver exact answers with direct, clickable source links.

---

## 🔒 Project Ops Privacy & Isolation Protocol

### Privacy Rules
1. **GitHub Exemption:** All scripts (`job_search_agent.py`, `job_search_supervisor.py`), datasets (`job_search_results.json`), and reports (`job_search_summary_report.txt`) created for **"Project Ops"** are **STRICTLY PRIVATE & EXEMPT** from sync to GitHub account `Hemang-krishna`.
2. **Discord Exemption:** Snorlax Bot must **NEVER** post Project Ops search results, job reports, or updates to public Discord channels.
3. **Local & Direct Output:** All Project Ops results are stored locally in `/data/` and reported directly to the user in session output or private Telegram state reports.
