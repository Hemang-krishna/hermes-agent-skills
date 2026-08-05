# Google NotebookLM Agentic Memory Sync & `notebooklm-py` Extraction Reference

This reference covers the architecture, data schemas, extraction APIs, and integration patterns for connecting Hermes local memory stores with Google NotebookLM (`https://notebooklm.google.com`) using `notebooklm-py` and the `browser-use` framework.

---

## 1. Architecture Overview

Google NotebookLM is a Gemini-powered grounded research assistant. By synchronizing local agentic memories into NotebookLM notebooks and leveraging `notebooklm-py` APIs, Hermes achieves continuous self-improvement, local document extraction in all file formats, and Gemini-grounded audio digests / study guides.

```
+--------------------------------------------------------------------------------------------------+
|                            HERMES x NOTEBOOKLM AGENTIC MEMORY ENGINE                             |
+--------------------------------------------------------------------------------------------------+
|                                                                                                  |
|   1. EVERY ACTION & TASK                                                                         |
|      Hermes captures session activity & error fixes in real time.                                |
|                                   |                                                              |
|                                   v                                                              |
|   2. DEDICATED LOCAL AGENTIC MEMORY STORE (/data/agent_memory/)                                  |
|      - /episodic/     ---> Daily conversation traces, user goals, and outcomes                   |
|      - /procedural/   ---> Learned deployment steps, API schemas, and code patches               |
|                                   |                                                              |
|                                   v                                                              |
|   3. AUTOMATED NOTEBOOKLM DOSSIER BUILDER                                                        |
|      Compiles high-density Markdown vault:                                                       |
|      `/data/agent_memory/vault_exports/LATEST_HERMES_MEMORY_VAULT.md`                           |
|                                   |                                                              |
|                                   v                                                              |
|   4. NOTEBOOKLM SYNC & EXTRACTOR ENGINE (notebooklm-py & browser-use)                            |
|      - Syncs dossiers directly into 'Hermes Agentic Memory Vault'                                |
|      - Programmatically extracts fulltext markdown, sources, notes, and research artifacts       |
|      - Downloads audio podcasts, PDFs, data tables, mind maps, quizzes, and slide decks locally  |
|                                                                                                  |
+--------------------------------------------------------------------------------------------------+
```

---

## 2. Triple-Fallback Resilience Architecture

To protect against Google RPC endpoint shifts, `notebooklm-py` and Hermes implement a 3-tier fallback strategy:

```
+--------------------------------------------------------------------------+
|                 HERMES TRIPLE-FALLBACK ARCHITECTURE                      |
+--------------------------------------------------------------------------+
| TIER 1: notebooklm-py Direct Async RPCs                                  |
|         - Direct /_/NotebookLmUi/data/batchexecute protocol execution    |
|         - High performance (<200ms latency per RPC)                      |
+--------------------------------------------------------------------------+
| TIER 2: CLI Wrapper & Isolated Storage Profile                           |
|         - Executed via /data/.local/bin/notebooklm                       |
|         - Isolated profiles: notebooklm -p <profile> use <notebook_id>   |
+--------------------------------------------------------------------------+
| TIER 3: browser-use Playwright CDP DOM Runner                            |
|         - Drives Playwright Chromium directly on notebooklm.google.com   |
|         - Bypasses RPC schema modifications via browser UI interaction    |
+--------------------------------------------------------------------------+
```

---

## 3. Directory Structure & Memory Categories

* `/data/agent_memory/episodic/` — JSON files storing daily interaction traces (`session_title`, `user_prompt`, `actions_taken`, `outcome`).
* `/data/agent_memory/procedural/` — JSON files storing reusable skills, deployment steps, code snippets, and bug fixes.
* `/data/agent_memory/dossiers/` — Timestamped Markdown dossiers (`hermes_memory_vault_YYYY-MM-DD.md`).
* `/data/agent_memory/vault_exports/` — Contains `LATEST_HERMES_MEMORY_VAULT.md` for instant NotebookLM source upload.
* `/data/notebooklm_downloads/` — Directory containing extracted sources, fulltext markdown, and downloaded research artifacts.

---

## 4. `notebooklm-py` Python API & Extractor Engine (`/data/notebooklm_extractor.py`)

```python
from notebooklm_extractor import NotebookLMExtractorEngine

extractor = NotebookLMExtractorEngine(download_dir="/data/notebooklm_downloads")

# 1. Check authentication status
auth_info = extractor.check_auth_status()

# 2. List notebooks
notebooks = extractor.list_notebooks()

# 3. Export full research artifacts (audio MP3, report PDFs, data tables, mind maps)
artifacts = extractor.download_all_artifacts(
    notebook_id="notebook_id_here",
    artifact_types=["audio", "report", "data-table", "flashcards", "mind-map", "quiz", "slide-deck", "video"]
)

# 4. Extract fulltext markdown document from source
doc = extractor.download_source_fulltext(notebook_id="notebook_id_here", source_id="source_id_here")
```

---

## 5. Cookie Authentication Management

`notebooklm-py` validates required Google cookies before executing RPC calls:
* **Required Cookie Keys:** `SID`, `HSID`, `SSID`, `APISID`, `SAPISID`, `__Secure-1PSID`, `__Secure-3PSID`, `__Secure-1PSIDTS`.
* **Importing Cookies via CLI:**
  ```bash
  /data/.local/bin/notebooklm auth import-cookies /path/to/cookies.json
  ```
* **Importing Cookies via REST API:**
  `POST /api/memory/import_cookies` with JSON payload `{"cookies_json": "..."}`.

---

## 6. High-Density Dossier Format (`LATEST_HERMES_MEMORY_VAULT.md`)

NotebookLM performs best with structured markdown headers:

```markdown
# 🧠 Hermes Agentic Memory Vault — YYYY-MM-DD
*Generated by Hermes Autonomous Engine on YYYY-MM-DD HH:MM:SS*

---
## 1. System Identity & Mission
- **Agent Name:** Hermes Agent
- **Capabilities:** SDR Lead Gen, Sierra CS, Devin Software Repair, Browser-Use Automation, Firecrawl Scraping
- **Deployment Target:** Netlify & Cloudflare Pages
- **Memory Objective:** Continuous self-improvement, error reduction, and knowledge synthesis.

---
## 2. Learned Procedural Skills & Fixes
### Skill: <Skill Name>
- **Category:** <Category>
- **Steps:**
  1. Step 1
  2. Step 2
```python
<code snippet>
```

---
## 3. Daily Episodic Activity Logs
### Episode: <Title> (<Timestamp>)
**Prompt:** <User prompt>
**Actions Taken:**
- Action 1
- Action 2
**Outcome:** <Final outcome text>
```

---

## 7. REST API Endpoints for Platform Dashboard

* `GET /api/memory/status` — Returns memory vault status, auth check, and dossier preview.
* `GET /api/memory/notebooks` — Programmatically lists all NotebookLM notebooks.
* `POST /api/memory/import_cookies` — Accepts browser cookie JSON payloads to refresh authentication.
* `POST /api/memory/download_artifacts` — Batch downloads audio podcasts, reports, slides, and flashcards locally.
* `POST /api/memory/skill` — Records new procedural skill.
* `POST /api/memory/episode` — Records episodic task trace.
* `POST /api/memory/sync_notebooklm` — Triggers dossier build and NotebookLM sync payload.
