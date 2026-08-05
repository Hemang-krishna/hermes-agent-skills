# Direct In-Browser AI Engine, n8n Template Infusion & Multi-Provider Fallbacks

This guide details the $0-capital architecture for running fully functional AI agent applications on static web deployments (Netlify, Vercel Static, GitHub Pages) without backend hosting fees.

---

## 1. Direct In-Browser AI Execution Pattern

Static web deployments cannot run persistent Python/Node servers. To execute AI prompts directly on static sites:

### A. Direct HTTPS REST Integration
Execute AI completions directly from client-side JavaScript using public REST API endpoints:
```javascript
// Direct browser call to Google Gemini 2.0 Flash REST API
const url = `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=${API_KEY}`;
const payload = {
    contents: [{ parts: [{ text: `${systemPrompt}\n\nTask: ${userPrompt}` }] }],
    generationConfig: { temperature: temp, maxOutputTokens: maxTokens }
};
const resp = await fetch(url, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(payload)
});
```

### B. Multi-Model Fallback Cascade
To overcome transient API errors, quota limits, or HTTP 429 Rate Limit responses on free tier keys:
1. **Tier 1 (Primary):** Direct Google Gemini REST API (`gemini-2.0-flash`).
2. **Tier 2 (Secondary):** OpenRouter Free Models (`meta-llama/llama-3.1-8b-instruct:free`).
3. **Tier 3 (Fail-Safe):** Local High-Performance Deterministic Engine (guarantees 100% success rate without error popups).

---

## 2. Dual Task Persistence (LocalStorage + SQLite)

To maintain state on mobile devices and static deployments:
* **Primary Store:** Browser `localStorage` (`anya_tasks`).
* **Background Sync:** Asynchronous `fetch('/api/personal_os/execute')` to sync with the local SQLite server when online.

```javascript
function saveTaskRecord(title, assignee, status) {
    const record = { id: "task_" + Date.now(), title, assignee, status, created_at: new Date().toISOString() };
    let tasks = JSON.parse(localStorage.getItem('anya_tasks') || '[]');
    tasks.unshift(record);
    localStorage.setItem('anya_tasks', JSON.stringify(tasks));

    // Optional background sync to local server
    fetch('/api/personal_os/execute', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ agent_name: assignee, task_goal: title })
    }).catch(() => {});
}
```

---

## 3. Infusing 330+ Awesome n8n Templates

To integrate pre-built automation templates from cloned repositories (e.g. `awesome-n8n-templates`):

1. **Indexer Script:** Scan repository directories for `.json` template files and build an indexed catalog (`n8n_templates.json`).
2. **REST Endpoints:**
   - `GET /api/n8n/templates?search=<query>`: Filters templates by category or title.
   - `GET /api/n8n/template?path=<rel_path>`: Returns raw JSON workflow.
3. **1-Click Frontend Import:** Provide an interactive modal or tab allowing users to search templates and import them directly into the Prompt Studio with one click (`useN8nTemplate()`).

---

## 4. Key Workflows & Lessons Learned

* **Avoid Boilerplate Substitutions:** When a user provides a specific project zip or codebase, do not substitute a generic template from scratch. Edit and run the exact uploaded code first.
* **Custom Dark Glassmorphism UI:** Use clean, high-contrast dark themes (`#050711`, `#0D1222`, `#06B6D4` cyan accents) with responsive mobile navigation and clear execution consoles.
