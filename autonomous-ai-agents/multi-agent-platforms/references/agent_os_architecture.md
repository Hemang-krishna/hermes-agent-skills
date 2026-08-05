# Agent OS Reverse-Engineered Architecture & Integration Reference

## 🏛️ System Overview

Agent OS (extracted from `Agent-OS-1.zip`) is an enterprise local-first studio for building, managing, and orchestrating visual AI agent workflows.

## 🔑 Key Architectural Components

1. **Codex Intelligence Layer (`server/runtime/codex-api.js` & `agent-os-builder.js`):**
   - Uses OpenAI Responses API (`gpt-5.3-codex`) to generate, refine, and preview multi-node DAG workflows.
   - Converts natural-language prompts into strict JSON workflow graphs.

2. **Visual DAG Graph Execution Engine (`server/runtime/workflows.js`):**
   - Node Schema: `{ id, label, type, provider, model, prompt, config, timeoutMs, maxRetries }`.
   - Edge Schema: `{ id, source, target, condition, branch }`.
   - Execution Capabilities: Parallel branch fan-out, loop/retry guards, human approval resume gates, and replay event overlays.

3. **Agent Runtimes & Control Rooms (`server/runtime/modules.js`):**
   - **Hermes Agent Runtime:** Profile state, channel status (Telegram, Slack), local execution gate.
   - **OpenClaw Runtime:** Daemon onboard, local execution gate.
   - **Claude Code / Codex CLI / OpenCode / Gemini CLI:** Sandboxed terminal runners with stdout/stderr redaction.

4. **3-Tier Hybrid Memory Architecture (`server/runtime/memory.js`):**
   - Lexical Search (BM25) + Vector Embeddings (Ollama/OpenAI) + Remote Qdrant Vector Collection Sync.

5. **Signed Skill Registry (`server/runtime/skills.js`):**
   - Ed25519 cryptographic bundle signatures, publisher trust policies (allowlists/blocklists), and dependency resolution.

6. **Cron Scheduler & Leader Lock (`server/runtime/scheduler.js`):**
   - Interval and Cron scheduled jobs, leader lock with stale-lock recovery, and human approval cards.

7. **Multi-LLM Router & Billing Reconciliation (`server/runtime/router.js` & `usage.js`):**
   - Routes across OpenAI, Anthropic, Gemini, OpenRouter, Ollama, MiniMax, Firecrawl.
   - Parses CSV/JSON billing records, reconciles token costs against execution logs.

## 🚀 Running Agent OS Backend
```bash
cd /data/agent_os_extracted
PORT=8090 HERMES_AGENT_OS_ENABLE_EXEC=1 node server/index.js
```
- Health Check: `http://localhost:8090/api/health`
- Generate Workflow API: `POST /api/agent-os/workflows/generate`
- Memory Search API: `GET /api/memory/search?q=query`
