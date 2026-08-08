---
name: multi-agent-platforms
description: Architecture, design patterns, and implementation guide for building production multi-agent systems with stateful databases, security guardrails, sandbox runners, and live web dashboards.
category: autonomous-ai-agents
---

# Multi-Agent Platform Engineering

This skill provides proven architectural patterns, state management strategies, security guardrails, and dashboard implementation guidance for building production-grade multi-agent platforms from scratch.

---

- **Reference Material:** See `references/agent_archetypes.md` for real-world revenue models and enterprise implementations (Salesforce Agentforce, Sierra AI, 11x AI, Claygent).
- **Agentic OS Reference:** See `references/agentic_os_kernel.md` for parsing 250+ agent role specs, dynamic registries, and multi-agent swarm handoffs.
- **Agentic Workflows Reference:** See `references/agentic_workflows.md` for pre-configured multi-phase pipelines (SDLC, Growth Marketing, Incident Response).
- **MCP Server Integration Reference:** See `references/mcp_server_integration.md` for compiling, registering, and testing native MCP tools (Firecrawl, Stdio/HTTP transport).
- **Browser-Use Automation Reference:** See `references/browser_use_integration.md` for `browser-use` setup, Linux container sandbox flags, Playwright binaries, and LLM adapters.
- **Deployment Engine Reference:** See `references/deployment_integrations.md` for Netlify and Cloudflare Wrangler 1-click deployment patterns, CLI commands, and token management.
- **n8n Workflow Automation Reference:** See `references/n8n_agent_workflows.md` for n8n JSON workflow templates, node configurations, and zero-cost hosting options (Docker, Oracle Cloud, Railway, HuggingFace Spaces).
- **Autonomous Job Search Agent Reference:** See `references/indian_job_search_agent.md` for 1000+ platform aggregation (Tech, Finance, Audit, Trust & Safety), cross-portal deduplication, anti-scam heuristics, and iOS mobile web execution patterns.
- **Slack & Notion Enterprise Bridge Reference:** See `references/slack_notion_enterprise_bridge.md` for Slack Webhooks, Notion API databases, multi-workspace alert schedulers, mobile/iOS PWA setups, and $0-cost enterprise stack setups.
- **Discord & Notion Enterprise Bridge Reference:** See `references/discord_notion_enterprise_bridge.md` for Discord Bot Gateway connection, `PrivilegedIntentsRequired` resolution, live web search in Discord channels, team directory management, and mandatory GitHub repo auto-pushes.
- **NotebookLM Agentic Memory Reference:** See `references/notebooklm_agentic_memory.md` for structuring episodic/procedural memory vaults, automating Google NotebookLM sync via `browser-use`, and extracting research documents in all file formats using `notebooklm-py`.
- **External Repositories, UI Skills & Master Prompting Reference:** See `references/cloned_repos_and_prompting.md` for indexing 16 cloned developer repositories, 7 extracted UI component skills (ReactBits, Refero, Aceternity, 21st.dev, Componentry, Toggle Supply, Motion), and exact prompt templates.
- **Agent OS Reverse-Engineered Architecture Reference:** See `references/agent_os_architecture.md` for the reverse-engineered Agent OS blueprint (138 REST routes, visual DAG execution engine, Codex API intelligence layer, Ed25519 signed skill registry, 3-tier hybrid memory, and multi-agent runtimes).
- **Mobile-First & iOS Integration Reference:** See `references/mobile_ios_integration.md` for iPhone/iPad PWA setups, live Notion API integration secrets, Slack mobile webhooks, single-tap artifact downloads, and multi-level simple explanations.
- **Personal Agentic OS Reference ($0 Cost Architecture):** See `references/personal_agentic_os.md` for SQLite + local JSON database schemas, Option 3 Local Engine configuration (zero API key dependencies, zero rate limits), custom preferred UI/UX (`personal_os.html`), direct media attachment delivery (`MEDIA:/path`), and Notion/Slack workspace dispatch.
- **Direct In-Browser AI Engine & n8n Infusion Reference:** See `references/direct_browser_ai_and_n8n_infusion.md` for direct client-side Gemini 2.0 Flash REST execution, multi-model fallback cascades, dual local/cloud task storage, and 330+ awesome n8n automation template indexing.
- **Local Business Lead Scraper & Notion/Slack Reference:** See `references/local_business_lead_scraper.md` for scraping businesses without websites, lead scoring algorithms, Notion database ID mapping (`{"parent": {"database_id": ...}}`), and Slack lead alert dispatch.
- **Telephony Hardware & Sub-Second Voice AI Reference:** See `references/telephony_voice_ai_agents.md` for $0 hardware SIM/eSIM gateways (Android Termux, USB 4G modems), serial AT command drivers, sub-second streaming STT -> LLM -> TTS pipelines, and Project Anya outbound calling workflows.
- **Autopilot Retail Lead & Web Prototype Pipeline Reference:** See `references/toronto_retail_autopilot_pipeline.md` for full autopilot campaign execution, specialized supervisory agent delegation, sub-second international voice AI calling, and autonomous client web prototype generation.
- **Stripe Crypto & Privacy Architecture Reference:** See `references/stripe_crypto_payouts_and_privacy.md` for Stripe USDC stablecoin payouts, Wyoming Anonymous LLCs, nominee service shielding, and Web3 payment integration.
- **Autonomous Email Discovery & Proposal Engine Reference:** See `references/autonomous_email_lead_engine.md` for $0-cost B2B email discovery, personalized proposal generation, SMTP dispatch, and Notion/Slack sync.
- **Global Overseas Headquarters & Banking Setup Reference:** See `references/global_ai_agency_headquarters.md` for US Wyoming LLC, Estonia E-Residency, UAE Free Zone setups, $0 tax pass-throughs, Mercury/Wise global banking, and `python-docx` report generation.
- **Master Prompt Engineering Skillset:** See `/data/skills/prompt-engineering/master-prompt-skillset.md` for structural XML scaffolding, ReAct reasoning loops, anti-slop frontend design rules, and TDD prompt patterns.

## 1. Core Agent Archetypes & Workflow Patterns

When building enterprise multi-agent platforms, structure each agent around a well-defined state machine, dedicated database schema, and tool execution protocol:

### A. Autonomous SDR & Lead Generation Agent (Alice/Jordan Class)
* **Workflow:** Ingestion $\rightarrow$ Waterfall Enrichment $\rightarrow$ ICP Qualification Scoring $\rightarrow$ Personalization $\rightarrow$ Inbound Reply Handling.
* **ICP Scoring Logic:** Weighted scoring based on firmographic metrics (employee count threshold, target CRM/stack overlap, executive title seniority).
* **Inbound State Machine:** Classifies reply intents (`MEETING_REQUESTED`, `PRICING_QUERY`, `OBJECTION_COMPETITOR`, `NOT_INTERESTED`) and automatically routes to action handlers (e.g., calendar booking links or opt-out markers).

### B. Enterprise Conversational & Security Agent (Sierra/Agentforce Class)
* **Workflow:** Input Guardrail Check $\rightarrow$ Intent & Tool Routing $\rightarrow$ Deterministic Transaction Execution / RAG Retrieval $\rightarrow$ Audit Trail Logging.
* **Security Guardrails:** Pre-screen prompts against prompt injection, system prompt leakage, jailbreaks, and SQL injection patterns. Block execution immediately upon threat detection.
* **Deterministic Tool Operations:** Keep state-changing operations (address updates, order cancellations, refunds) separate from non-deterministic LLM output generation. Execute tools programmatically and pass verified results to the user.

### C. Software Engineering & Research Sandbox Agent (Devin Class)
* **Workflow:** Goal Planning $\rightarrow$ Workspace File Prep $\rightarrow$ Sandboxed Execution $\rightarrow$ Error Traceback Reflection $\rightarrow$ Auto-Patching $\rightarrow$ Verification Re-Test.
* **Sandbox Environment:** Execute commands inside isolated workspace directories or containers. Capture `stdout`/`stderr` and return codes.
* **Reflection Loop:** Parse specific error tracebacks (e.g. `ZeroDivisionError`, `KeyError`, `AssertionError`) to apply targeted code patches automatically until test suites pass.

---

## 2. Platform Architecture & Stack Selection

```
+-------------------------------------------------------------------------------+
|                       MULTI-AGENT PLATFORM STACK                              |
+-------------------------------------------------------------------------------+
| FRONTEND:  Tailwind CSS + Single Page App (SPA) Dashboard (Tabbed Views)      |
| BACKEND:   FastAPI / Uvicorn REST APIs + WebSocket/Poll Events                 |
| STORAGE:   SQLite / PostgreSQL per Agent (Stateful Logs & Execution Steps)   |
| EXECUTION: Python Subprocess / Sandboxes for Code Execution & Tool Calling    |
| TESTING:   PyTest + FastAPI TestClient Integration Suite                     |
+-------------------------------------------------------------------------------+
```

---

## 3. Public Tunneling & Live Dashboard Sharing

When deploying or demonstrating live local agent servers (e.g. running on `http://localhost:8000`), expose them securely to the public web via SSH reverse tunneling without needing complex cloud deployments:

```bash
# Option 1: localhost.run (HTTPS URL with TLS termination)
ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=30 -R 80:localhost:8000 nokey@localhost.run

# Option 2: Pinggy.io
ssh -o StrictHostKeyChecking=no -p 443 -R0:localhost:8000 a.pinggy.io
```

---

## 4. Agentic OS Kernel & Swarm Orchestration Architecture

When scaling from a few bespoke agents to hundreds of specialized roles (e.g. 250+ role markdown specifications like `agency-agents-zh`), implement an **Agentic OS Kernel**:

### A. Dynamic Agent Registry & Loader
* **Directory Indexer:** Recursively scans repository folders to extract role specifications, department classification, descriptions, capabilities, and system prompts.
* **Metadata Extraction:** Normalizes markdown role specs into structured `AgentSpec` models with required tool bindings (`terminal`, `file_io`, `python_interpreter`).

### B. Multi-Agent Swarm Pipeline Orchestrator
* **Sequential & DAG Execution:** Chains multiple agents sequentially (e.g. *Product Architect* $\rightarrow$ *Backend Engineer* $\rightarrow$ *QA Engineer*).
* **Context Propagation:** Appends output deliverables from upstream agents into the prompt context of downstream agents.
* **Aggregate Synthesis:** Compiles individual step deliverables into a unified swarm output report.

### C. OS Telemetry & Process Lifecycle Management
* Expose `/api/os/telemetry` tracking active kernel status, total loaded agents, active departments, and execution counts.
* Run self-healing background daemons with automated port bindings and live reverse tunnels.

---

## 5. Pre-Configured Agentic Workflows & Multi-Phase Pipeline Engine

In addition to custom swarms, provide pre-configured, production-ready **Agentic Workflows** (multi-phase DAGs) for common enterprise pipelines:

1. **Product & SDLC Pipeline:** Product Manager $\rightarrow$ System Architect $\rightarrow$ Backend Developer $\rightarrow$ QA Engineer.
2. **Growth Campaign Pipeline:** Growth Hacker $\rightarrow$ Copywriter $\rightarrow$ Social Platform Specialist.
3. **Security Incident Response Pipeline:** Security Pentester $\rightarrow$ Incident Responder $\rightarrow$ Infrastructure Ops Maintainer.

Store workflow definitions as structured `WorkflowDefinition` models, pass accumulated outputs downstream between phases, and expose `/api/workflows/list` and `/api/workflows/execute` for 1-click execution from web control rooms.

---

## 5. Common Implementation Pitfalls & Verification

1. **Python Venv Execution Paths:** When launching background server processes with `terminal(background=True)`, pass the absolute virtual environment python binary path (e.g. `/opt/venv/bin/python3 app.py`) to prevent module resolution errors.
2. **FastAPI TestClient Dependency:** `starlette.testclient.TestClient` requires `httpx` installed (`pip install httpx`). Ensure it is included in `requirements.txt`.
3. **Regex Tool Routing Fallbacks:** When parsing non-deterministic text inputs for tool arguments (e.g. order IDs or shipping addresses), always verify match object existence before accessing `.group()` to prevent `AttributeError`.
4. **Database Isolation:** Maintain separate database tables or SQLite databases per agent (`sdr_leads.db`, `sierra_orders.db`, `devin_tasks.db`) to decouple state and schema migrations.
5. **REST & Dashboard Integration:** Expose `/api/<agent>/dashboard` endpoints returning aggregate metrics alongside detailed execution lists.
6. **Automated Testing:** Always write integration tests covering:
   - Positive execution flows (e.g., qualified lead generation, order update).
   - Negative security flows (e.g., prompt injection blocking).
   - Automated repair loops (e.g., code auto-patching).
7. **Live Verification:** Run unit test suites and verify background server process readiness using health checks or `curl` before presenting results to the user.
