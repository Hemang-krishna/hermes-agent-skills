# Awesome n8n Templates Infusion & Automation Guide

## Overview
This reference guide details how 330+ production n8n automation workflow JSON files from `awesome-n8n-templates` (`/data/external_repos/awesome-n8n-templates/`) are indexed, served via REST endpoints, and integrated into the Agentic Workspace.

---

## 1. Indexing & Storage Structure
All n8n templates are indexed into a local JSON store at `/data/agent_platform/static/n8n_templates.json`:

```json
[
  {
    "title": "Agentic Telegram AI bot with with LangChain nodes and new tools",
    "category": "Telegram",
    "nodes_count": 8,
    "path": "Telegram/Agentic Telegram AI bot with with LangChain nodes and new tools.json"
  },
  {
    "title": "Creating a AI Slack Bot with Google Gemini",
    "category": "Slack",
    "nodes_count": 20,
    "path": "Slack/Creating a AI Slack Bot with Google Gemini.json"
  }
]
```

---

## 2. Dedicated FastAPI REST Endpoints (`n8n_routes.py`)

### A. Search & Filter Templates
- `GET /api/n8n/templates?search=Telegram`
- **Response:**
  ```json
  {
    "total": 29,
    "templates": [
      {
        "title": "Telegram AI Chatbot",
        "category": "Telegram",
        "nodes_count": 16,
        "path": "Telegram/Telegram AI Chatbot.json"
      }
    ]
  }
  ```

### B. Fetch Full Workflow JSON
- `GET /api/n8n/template?path=Telegram/Telegram%20AI%20Chatbot.json`
- **Response:** Returns raw n8n workflow nodes, credentials placeholders, connections, and node triggers.

---

## 3. UI Integration & One-Click Execution
- **`n8n Templates (330)` Navigation Tab:** Live search box filtering 330+ workflows across Telegram, Slack, WhatsApp, WordPress, and OpenAI.
- **One-Click Use Template Button:** Injects the template title and file path directly into the **Functional Prompting Space** for live Gemini 2.0 Flash / Option 3 execution and Notion/Slack sync.
