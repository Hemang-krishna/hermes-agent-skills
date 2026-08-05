# Gemini API & Cyber Void UI Guide for Agent OS

## 1. Google Gemini API Integration Pattern
* **Base URL:** `https://generativelanguage.googleapis.com/v1beta`
* **Default Model:** `gemini-2.0-flash`
* **Endpoint Pattern:** `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key={GEMINI_API_KEY}`
* **Rate-Limit Handling (HTTP 429):**
  When Google Gemini API returns HTTP 429 (Too Many Requests), the Agent OS Kernel must catch the exception and immediately route execution to the **Option 3 Local Deterministic Engine** so user interactions never fail.

## 2. Cyber Void Design Tokens (No-Boilerplate Look)
* **Background Base:** `#060811` (Deep Obsidian / Cyber Void)
* **Card Container:** `#0E1322` (Translucent Glassmorphism with `border: 1px solid #1E293B`)
* **Electric Cyan Glow:** `#06B6D4` (Active buttons, focus outlines, primary highlights)
* **Cyber Violet Accent:** `#8B5CF6` (Secondary badges, role selectors, model indicators)
* **Emerald Status:** `#10B981` (Online indicators, zero-cost badges, completed task tags)
* **Rose Accent:** `#F43F5E` (Clear triggers, error recovery, code sandbox tags)

## 3. Netlify Anonymous Deployment Protocol
To deploy anonymous preview builds without hitting Netlify team-token permissions:
```bash
env -u NETLIFY_AUTH_TOKEN NETLIFY_CONFIG_DIR=/tmp/net_anon_power /data/deploy_tools/node_modules/.bin/netlify deploy --prod --dir=/data/agent_os_extracted/dist --allow-anonymous
```
Ensure `/data/agent_os_extracted/dist/netlify.toml` exists with `[build] command = "" publish = "."`.
