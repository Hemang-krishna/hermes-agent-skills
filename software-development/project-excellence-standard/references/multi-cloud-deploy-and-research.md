# Multi-Cloud Deployment, Research Dossiers & NotebookLM Reference

This reference documents proven integration patterns for project execution under the Project Excellence Standard.

## 1. 5-Cloud Unified Deployment Engine

The executable at `/data/deploy_tools/deploy` handles 1-click deployments across 5 major cloud providers:

| Provider | Command Syntax | Environment Credentials |
|---|---|---|
| **Netlify** | `/data/deploy_tools/deploy netlify <dir>` | `NETLIFY_AUTH_TOKEN` in `/data/.env` |
| **Cloudflare** | `/data/deploy_tools/deploy cloudflare <dir> [app_name]` | `CLOUDFLARE_API_TOKEN` in `/data/.env` |
| **Vercel** | `/data/deploy_tools/deploy vercel <dir>` | `VERCEL_TOKEN` in `/data/.env` |
| **Firebase** | `/data/deploy_tools/deploy firebase <dir>` | `FIREBASE_TOKEN` in `/data/.env` |
| **Heroku** | `/data/deploy_tools/deploy heroku <dir> <app_name>` | `HEROKU_API_KEY` in `/data/.env` |

### Key Rule for Netlify CLI
Always ensure `netlify.toml` exists in the build directory with `[build] command = "" publish = "."` before running CLI deployments to prevent remote build command guessing errors.

---

## 2. Research Repository & Dossier Logging (`/data/research_repository/`)

Whenever any research is conducted (via Web Search, Firecrawl, arXiv, NotebookLM, or Deep Research):

1. Format the findings into a structured Markdown & JSON dossier using `/data/research_manager.py`.
2. Output path: `/data/research_repository/dossiers/YYYYMMDD_HHMMSS_topic.md`.
3. Verify that `/data/research_repository/research_index.json` is updated with the new dossier entry.

---

## 3. Google NotebookLM & Agentic Memory Sync

- `notebooklm-py` (v0.8.0) is installed at `/data/notebooklm-py` with CLI at `/data/.local/bin/notebooklm`.
- Daily memory vaults are compiled into `/data/agent_memory/vault_exports/LATEST_HERMES_MEMORY_VAULT.md`.
- `NotebookLMSyncAgent` uses `browser-use` (Playwright Chromium) to navigate `https://notebooklm.google.com` and sync the latest memory dossier into the **"Hermes Agentic Memory Vault"** notebook.
