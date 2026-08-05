# Zero-Cost Enterprise Infrastructure & Multi-Format Delivery Standards

This reference documents proven patterns for running enterprise AI workflows at $0 cost and delivering multi-format artifacts (Web Apps, PPTX presentations, Markdown dossiers).

---

## 1. $0-Cost Enterprise Infrastructure Stack

| Component | Provider & Free Tier | Limits & Capabilities | Integration Pattern |
|---|---|---|---|
| **Web Hosting** | Netlify Free Tier | 100GB/mo bandwidth, free SSL | `deploy netlify <build_dir>` |
| **Edge Hosting** | Vercel Hobby / Cloudflare Pages | Unlimited static requests, Edge functions | `deploy vercel <dir>` / `deploy cloudflare <dir>` |
| **AI Inference** | Google Gemini 2.5 Flash Free Tier | 15 RPM / 1,000,000 TPM | Free API Key in `/data/.env` |
| **Real-Time Comms**| Slack Free Workspace | Unlimited channels, 10 integrations | Incoming Webhooks / Bot API `chat.postMessage` |
| **Knowledge Base**| Notion Free Workspace | Unlimited pages, database API | `Notion Integration Token` (`NOTION_API_KEY`) |
| **Document Sourcing**| `notebooklm-py` + `browser-use` | Unlimited local Playwright CDP runs | `/data/.local/bin/notebooklm` CLI & Python API |

---

## 2. Multi-Format Presentation & Delivery Rules

When delivering research, strategic roadmaps, or business proposals, match the exact format requested:

### A. Standalone Interactive Web Presentation Apps (HTML5 + Tailwind)
- Use when the user asks for a presentation that is **not Markdown and not PowerPoint**.
- Build as a Glassmorphism single-page HTML application with Tailwind CSS, FontAwesome icons, Chart.js visuals, and `<details><summary>` collapsible mind map toggles.
- Deploy live to Netlify/Vercel with `--prod` flag so it gets an unrestricted public URL (`HTTP 200 OK`).

### B. PowerPoint Presentations (`.pptx` via `python-pptx`)
- Use when the user explicitly requests a **PowerPoint file (`.pptx`)**.
- Use `python-pptx` script to build a 12+ slide widescreen 16:9 presentation.
- Include Title slide, Executive Summary, Tech Stack, Flow Diagrams, Financial Unit Economics tables, 7-Day Roadmaps, and Next Steps.
- Deliver via `MEDIA:/path/to/presentation.pptx` in messaging platform AND host on live Netlify web platform.

### C. Research Dossiers & Memory Vaults
- Always save research dossiers as dual `.md` and `.json` files in `/data/research_repository/dossiers/`.
- Register entries in `/data/research_repository/research_index.json`.
- Compile daily activity and procedural skills into `/data/agent_memory/vault_exports/LATEST_HERMES_MEMORY_VAULT.md` formatted for Google NotebookLM ingestion.

---

## 3. `notebooklm-py` Integration Patterns

- **Authentication:** `notebooklm auth import-cookies cookies.json` (Playwright `storage_state.json` or cookie list containing `SID`, `HSID`, `SSID`, `APISID`, `SAPISID`, `__Secure-1PSIDTS`).
- **CLI Commands:**
  - `notebooklm list` — List all user notebooks.
  - `notebooklm source fulltext <source_id>` — Extract full document markdown.
  - `notebooklm download <audio|report|data-table|flashcards|mind-map|quiz|slide-deck|video>` — Download generated research artifacts locally.
