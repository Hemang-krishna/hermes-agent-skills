# Dynamic Full-Stack Backend & Tunneling Guide for Agent OS

This reference guide documents the procedural patterns for deploying and operating full-stack dynamic AI backend services with zero infrastructure fees, bypassing static-only hosting limitations.

---

## 1. Why Static Edge Hosting Fails for Full-Stack Agent OS

* **Static Hosting Limitations:** Static platforms like Netlify serve pre-rendered HTML, CSS, and JS. They cannot execute Python FastAPI kernels (`app.py`, `kernel.py`), run local SQLite database queries, or manage persistent background processes.
* **The Dynamic Solution:** Run the Python/Node.js full-stack server on a dynamic host or expose the local backend process using a public HTTPS tunnel (`localtunnel` / `cloudflared` / Cloudflare Workers / Vercel API).

---

## 2. Setting Up Dynamic Full-Stack Backend Service

### Step 1: Configure FastAPI CORS & Headers in `app.py`
To allow mobile browsers and cross-origin clients to communicate with the dynamic backend:

```python
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(title="Dynamic Full-Stack Agent Service")

# Enable CORS for all origins
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

### Step 2: Expose Backend Server Over Public HTTPS Tunnel
Launch the Python server on port 8000, then expose it using localtunnel:

```bash
# 1. Start Python FastAPI Server
python3 /data/agent_platform/app.py &

# 2. Start Public HTTPS Tunnel
npx localtunnel --port 8000 --subdomain anya-agentic-space
```

### Step 3: Client-Side Tunnel Request Handling
In client-side JavaScript, pass the header `Bypass-Tunnel-Reminder: true` on fetch calls:

```javascript
const BACKEND_HOST = "https://anya-agentic-space.loca.lt";

const resp = await fetch(`${BACKEND_HOST}/api/personal_os/execute`, {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json',
        'Bypass-Tunnel-Reminder': 'true'
    },
    body: JSON.stringify({ agent_name: "Master Agent", task_goal: prompt })
});
```

---

## 3. In-Browser Direct AI Execution & Multi-Model Cascade

To ensure 100% uptime even if a model provider hits HTTP 429 rate limits or network latency:

```javascript
// Multi-Level AI Execution Cascade
1. Try Direct Gemini 2.0 Flash API (generativelanguage.googleapis.com)
2. Try OpenRouter Free Models (meta-llama/llama-3.1-8b-instruct:free)
3. Try Option 3 High-Performance Local Engine (Deterministic Runner)
```

This guarantees that every button tap, prompt submission, and digital worker run produces real, instantaneous AI output with $0 overages!
