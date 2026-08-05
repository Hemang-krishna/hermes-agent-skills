# Mobile-First Execution & iOS Integration Patterns for Multi-Agent Platforms

## 📱 Mobile Operational Architecture (iPhone & iPad)

When deploying multi-agent platforms for users operating primarily from mobile devices (iOS / Android):

### 1. Progressive Web App (PWA) & Safari Home Screen Setup
- Design web control dashboards with responsive Tailwind containers (`max-w-7xl`, `p-4 md:p-6`, `overflow-x-auto`).
- Include viewport meta tag: `<meta name="viewport" content="width=device-width, initial-scale=1.0">`.
- Instruct users on 2-tap PWA installation: *Safari Share Button* $\rightarrow$ *Add to Home Screen*.

### 2. Live Notion API Sync on Mobile
- To make databases visible in the Notion iOS app, prompt the user for an Internal Integration Secret (`ntn_...`).
- **Critical Authorization Step on iOS:** Users must open a page in Notion, tap `...` (top right), select `Connect to`, and pick the integration bot (`Anya’s connection`).
- Once shared, use `POST https://api.notion.com/v1/databases` and `POST https://api.notion.com/v1/pages` to populate database items live over REST.

### 3. Slack Mobile Webhook Notifications
- Configure Slack Incoming Webhooks (`SLACK_WEBHOOK_URL`) for real-time mobile push notifications when agent tasks, SDR leads, or scheduled jobs complete.

### 4. Single-Tap File Deliveries on Mobile
- For downloadable artifacts (PowerPoint `.pptx`, Markdown `.md`, n8n `.json`, Notion `.csv`), deploy static files to public CDN endpoints (Netlify/Cloudflare) or deliver directly via native messaging attachments (`MEDIA:/path/to/file`).

### 5. Multi-Level Explanation Style
- When requested to explain complex workflows ("explain in simple words"):
  - Provide an everyday analogy (e.g. "a 24/7 personal assistant").
  - Use simple step-by-step ASCII flowcharts.
  - Present the 3-line code example with inline line-by-line annotations.
