# Project Anya & Enterprise Presentation Standards

## 1. Executive Presentation Format Rule
- **Never present reports as plain Markdown text or static PowerPoint (.pptx) decks.**
- **Format:** Build an **Interactive Standalone Web Presentation Application** using single-page HTML5, Tailwind CSS, FontAwesome icons, Glassmorphism UI, interactive collapsible toggles (`<details><summary>`), and Chart.js visuals.
- **Public Hosting Verification:** Deploy the presentation app live to Netlify or Vercel using `deploy netlify /path/to/report` (with `--prod` flag to avoid HTTP 401 draft locks) and verify HTTP 200 OK public access before sending the URL to the user.

## 2. 5-Cloud Deployment Execution Rules
- Use unified deployment tool `/data/deploy_tools/deploy <target> <directory> [project-name]`.
- Supported targets: `netlify`, `cloudflare`, `vercel`, `firebase`, `heroku`.
- Automatically inject fallback `netlify.toml` with `build.command=""` or `firebase.json` if missing to avoid framework build errors.

## 3. Automated Research Repository & Dossiers
- All web research, Firecrawl scrapes, and market analysis MUST be documented using `/data/research_manager.py`.
- Saves structured dossiers as `.md` and `.json` in `/data/research_repository/dossiers/`.
- Auto-indexes all research entries in `/data/research_repository/research_index.json`.
- Compiles memory vaults to `/data/agent_memory/vault_exports/LATEST_HERMES_MEMORY_VAULT.md` for Google NotebookLM ingestion.
