---
name: agent-os-orchestrator
description: Complete Agent OS Orchestrator Skill — Visual DAG workflow graphs, Universal Any-API Gateway, Hermes/OpenClaw runtimes, hybrid vector memory, signed skill registry, and cron scheduling.
category: devops/agent-os
---

# Agent OS Orchestrator Skill

## Overview
This skill provides full procedural access to the **Agent OS** architecture extracted from `/data/agent_os_extracted/`.

## Key Capabilities
1. **Universal Any-API Gateway:** Generates and runs DAG workflows across ANY API key and provider endpoint (OpenAI, OpenRouter, Gemini, Anthropic, DeepSeek, Groq, Ollama) without proprietary vendor locks.
2. **Visual DAG Graph Execution:** Parallel branch fan-out, loop guards, approval resume gates, and replay overlays.
3. **Local Agent Runtimes:** Native control of Hermes Agent, OpenClaw, Claude Code, and Gemini CLI.
4. **Hybrid Memory Store:** Lexical (BM25) + Vector (Ollama/OpenAI) + Remote Qdrant collection sync.
5. **Signed Skill Bundles:** Cryptographic Ed25519 signature checks, publisher reputation, and dependency resolution.

## References & API Routes
- See [API Routes Reference](references/agent_os_api_routes.md) for the complete 138 API endpoints inventory and module map.
- See [Free API Ecosystem Guide](references/free_api_ecosystem_guide.md) for step-by-step setup of zero-cost providers (Ollama, Gemini, OpenRouter).
- See [Gemini API & Cyber Void UI Guide](references/gemini_api_and_custom_ui_guide.md) for Gemini key integration, rate-limit fallback, Cyber Void design tokens, and Netlify anonymous deployment.
- See [GitHub Swarm & Custom Workspace Guide](references/github_swarm_and_custom_workspace_guide.md) for GitHub tools, local repos integration, pre-commit reviews, and bespoke workspace customization.
- See [Awesome n8n Templates Infusion Guide](references/awesome_n8n_templates_infusion_guide.md) for indexing, REST endpoints, and UI integration of 330+ production n8n automation workflows.
- See [Dynamic Full-Stack Backend & Tunneling Guide](references/dynamic_fullstack_backend_and_tunneling_guide.md) for hosting Python FastAPI/SQLite backend services over public HTTPS tunnels (`localtunnel` / `cloudflared`) with CORS and browser AI execution fallbacks.

## Critical Workflow Guidelines & Pitfalls
- **Dynamic Full-Stack Backend vs. Static Edge Hosting:** When static hosting (e.g. Netlify) cannot execute Python FastAPI, SQLite, or local background processes, expose the Python backend server (`app.py`, `kernel.py`, SQLite) over a public HTTPS tunnel (`localtunnel` / `cloudflared` / Vercel Serverless) with CORS (`CORSMiddleware`) and header bypass (`Bypass-Tunnel-Reminder: true`). Combine this with in-browser direct Google Gemini REST API calls so prompt execution works with $0 overages on any device.
- **Awesome n8n Templates Infusion:** When infusing n8n workflows, index all `.json` workflow files from `/data/external_repos/awesome-n8n-templates/` into `/data/agent_platform/static/n8n_templates.json`. Serve them via `GET /api/n8n/templates` and `GET /api/n8n/template?path=...` in `n8n_routes.py` and expose an interactive n8n Templates Hub tab in the web UI for one-click template selection and execution.
- **Bespoke Agentic Space & No Forced Frameworks:** When a user specifies a unique project vision (e.g. "don't use stupid framework routes", "this project is unique and different"), NEVER force boilerplate templates. Build a tailored, bespoke Agentic Workspace featuring custom Cyber Void dark aesthetics (`#060811`), full-box functional prompting spaces with live parameter controls (Temperature, Tokens) and tool toggles, 5 active digital worker control rooms, and live terminal execution.
- **GitHub Swarm & Repositories Integration:** Integrate GitHub developer tools (`git`, 16 cloned local repos in `/data/external_repos/`, PR code reviews, codebase inspection, and pre-commit security audits) as a primary worker capability (`GitHub Developer Swarm Agent`).
- **Execute Provided Codebases Directly:** When a user uploads or references a specific codebase or zip file (`Agent-OS-1.zip`), DO NOT substitute a custom built simplified script or separate HTML dashboard. Always extract, compile (`npm install && npm run build`), deploy (`dist/`), and execute the user's actual extracted codebase (`/data/agent_os_extracted/`).
- **Bespoke UI Customization & Dark Palette Standards:** Enforce high-aesthetic Cyber Void styling (`#060811` void background, `#0E1322` glass panels, `#06B6D4` electric cyan highlights, `#8B5CF6` violet accents, `#10B981` emerald status indicators), full-box functional prompting spaces with live parameter sliders (Temperature, Tokens) and tool toggles, live terminal consoles, and persistent SQLite task tables.
- **Universal Provider Architecture & Removing Vendor Lock-ins:** Never enforce hardcoded proprietary vendor API requirements (e.g., hardcoded Codex API constraints). Refactor the provider setup and router (`server/runtime/codex-api.js` -> Universal Gateway) so ANY API key (OpenAI, OpenRouter, Gemini, Anthropic, DeepSeek, Groq, Ollama) and custom base URL works out of the box.
- **Google Gemini API Integration & Rate-Limit Fallback:** For Gemini keys (e.g. `AQ.Ab8RN...`), integrate `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=...`. When HTTP 429 rate limits occur, immediately failover to Option 3 Local Deterministic Engine so the UI and agent execution stay 100% operational with $0 overages.
- **Netlify Deployments for Static Builds:** Always inject a `netlify.toml` file containing `[build] command = "" publish = "."` into the build directory (`/data/agent_os_extracted/dist/`) before calling `netlify deploy --prod --dir=dist` to prevent Netlify from running unexpected remote build commands (like `hugo`). Use `env -u NETLIFY_AUTH_TOKEN NETLIFY_CONFIG_DIR=/tmp/net_anon` for anonymous deployments to avoid team scope permission conflicts.
- **Provider Key Configuration:** Persist API keys into `/data/agent_os_extracted/server/data/connections.json` and export them in process environment variables (`GEMINI_API_KEY`, `OPENROUTER_API_KEY`, `OPENAI_API_KEY`) so runtime status endpoints (`/api/setup/providers`) show `status: "configured"`.

## How to Build & Deploy Extracted Agent OS
```bash
# 1. Install & Build Frontend
cd /data/agent_os_extracted
npm install && npm run build

# 2. Deploy Compiled Frontend (dist/) to Netlify
NETLIFY_CONFIG_DIR=/tmp/net_agent_os /data/deploy_tools/node_modules/.bin/netlify deploy --prod --dir=/data/agent_os_extracted/dist --allow-anonymous

# 3. Start Backend Server Engine
PORT=4173 HERMES_AGENT_OS_ENABLE_EXEC=1 node server/index.js
```

## How to Start Agent OS Server
```bash
cd /data/agent_os_extracted
PORT=8090 HERMES_AGENT_OS_ENABLE_EXEC=1 node server/index.js
```

## Primary API Endpoints
- `POST /api/agent-os/workflows/generate` — Generate DAG graph from prompt.
- `POST /api/workflows/:id/run` — Run workflow graph.
- `GET /api/memory/search?q=query` — Hybrid memory search.
- `POST /api/scheduler/jobs` — Create scheduled job with human approval gate.
