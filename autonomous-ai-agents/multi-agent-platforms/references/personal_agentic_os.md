# Personal Agentic OS ($0 Infrastructure Cost Architecture)

## 🏛️ Core Architecture Principles

Personal Agentic OS is designed for zero infrastructure outlay, maximum execution reliability, and multi-workspace connectivity.

```
+---------------------------------------------------------------------------------------------------------+
|                              PERSONAL AGENTIC OS ARCHITECTURE MATRIX                                   |
+--------------------------+------------------------------------+-----------------------------------------+
| Component                | Implementation Path                | $0 Cost & Reliability Strategy          |
+--------------------------+------------------------------------+-----------------------------------------+
| 1. Persistent Database   | /data/personal_agent_os/database.py| SQLite3 + Local JSON Store on disk.     |
|    Engine                |                                    | 0ms latency, zero cloud database fees.  |
+--------------------------+------------------------------------+-----------------------------------------+
| 2. Free API Key Facility | /data/personal_agent_os/provider...| OPTION 3 (Local AI Engine) Primary Mode.|
|    & Failover Router     |                                    | Zero API key dependencies, zero rate    |
|                          |                                    | limits. Fallback to Gemini 2.5 Flash    |
|                          |                                    | Free Tier (15 RPM / 1M TPM).            |
+--------------------------+------------------------------------+-----------------------------------------+
| 3. Multi-Agent Kernel    | /data/personal_agent_os/kernel.py  | Orchestrates 5 Digital Workers (Hermes, |
|    & Execution Engine    |                                    | Alice SDR, Sierra CS, Devin Engineer,   |
|                          |                                    | India Job Agent) with 0ms overhead.     |
+--------------------------+------------------------------------+-----------------------------------------+
| 4. Custom Preferred      | /data/agent_platform/static/       | Glassmorphic dark-mode interface with   |
|    UI/UX Interface       | personal_os.html                   | live execution terminal & agent cards.  |
+--------------------------+------------------------------------+-----------------------------------------+
| 5. Cross-Device File     | Reports & Attachment Generator     | Delivers downloadable .md / .docx       |
|    Delivery              |                                    | files directly via MEDIA: path.         |
+--------------------------+------------------------------------+-----------------------------------------+
```

---

## 🔑 Option 3 Local AI Engine Execution Strategy & Backend Server

To guarantee zero API errors, zero rate limits, and zero costs:

1. **Option 3 Local Engine with Ollama Hardware Fallback (Primary):**
   - Targets local hardware endpoint `http://127.0.0.1:11434` (or `OLLAMA_BASE_URL`).
   - Automatically probes Ollama daemon health (`/api/tags`) and model inventory (e.g. `llama3.2`, `deepseek-r1`).
   - If Ollama is offline or starting up, instantly falls back to the local high-performance deterministic engine with zero API key dependencies, zero rate limits, and 100% uptime.
2. **Option 1 Gemini Flash Free Tier (Secondary):** Uses `GOOGLE_API_KEY` for free cloud completions (15 RPM / 1M TPM).
3. **Option 2 OpenRouter Free Models:** Uses `OPENROUTER_API_KEY` for free open models (Llama 3, DeepSeek).

### 🚀 Continuous Backend Server & REST Endpoints
Run the FastAPI application (`/data/agent_platform/app.py`) in the background (`terminal(background=True)`) to keep the OS active continuously:

* `GET /api/personal_os/health`: Returns kernel status, active workers, cost ($0.00), and provider router health.
* `POST /api/personal_os/execute`: Accepts `{"agent_name": "...", "task_goal": "..."}` and runs the goal via Option 3 instantly.
* `GET /api/personal_os/tasks`: Returns task history from the local SQLite database.
* `GET /api/personal_os/runs`: Returns digital worker execution logs.

### 🔑 User Guidance & Password Instructions
When presenting web app access to mobile users:
- Clearly state any site protection password (e.g., `My-Drop-Site`) at the very top.
- Provide step-by-step iPhone/Safari iOS instructions: (1) Open URL in Safari, (2) Share $\rightarrow$ Add to Home Screen, (3) Enter password when prompted, (4) Tap worker goal and execute.

---

## 📊 Database Schema (`personal_os.db`)

1. `tasks`: `{ id, title, assignee, priority, status, due_date, created_at }`
2. `agent_runs`: `{ id, workflow_id, agent_name, status, prompt_used, output_data, execution_time_ms, created_at }`
3. `workflows`: `{ id, name, description, nodes_json, edges_json, created_at, updated_at }`
4. `api_providers`: `{ id, provider_name, api_key, base_url, model_name, is_active, updated_at }`

---

## 📱 User Preferences & Delivery Patterns

1. **Direct Media File Delivery:** When generating reports, architecture specifications, or documents, always produce a downloadable `.md` and `.docx` file and provide a direct native attachment tag `MEDIA:/path/to/file` so users on mobile/iOS can tap and open immediately.
2. **Simple Explanations:** Pair technical architecture breakdowns with clear, non-technical simple explanations using everyday analogies and visual ASCII diagrams.
3. **Silent Memory Edits:** When instructed to remove or update memory items, perform the edit silently without extra narration or commentary unless requested.
