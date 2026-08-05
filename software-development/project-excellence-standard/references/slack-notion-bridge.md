# Slack & Notion Enterprise Communication Bridge Reference

## Architecture & Integration Strategy

Connecting Slack and Notion provides real-time messaging, workflow dispatch, and structured enterprise documentation for team collaboration and autonomous AI digital workers.

### 1. Slack Integration Capabilities
- **Incoming Webhooks (`SLACK_WEBHOOK_URL`):** Send channel announcements, leader instructions, and documentation alerts.
- **Bot Web API (`SLACK_BOT_TOKEN`):** Full bidirectional channel posting (`chat.postMessage`), user mentions, and thread replies.
- **Message Formatting:** Markdown formatting (`*bold*`, `_italic_`, `~strikethrough~`, `` `code` ``, `> quotes`, and `🔗 [links]`).

### 2. Notion API & Data Sources Integration (`2025-09-03` Version)
- **Data Source Databases:**
  - **Roadmap & Tasks:** Properties: Title (`title`), Assignee (`select`/`rich_text`), Priority (`select`), Status (`select`), Due Date (`date`).
  - **Knowledge Base Docs:** Properties: Title (`title`), Category (`select`), Author (`rich_text`), Markdown Content.
  - **Team Directory:** Members, roles, and platform status.
- **Authentication:** `NOTION_API_KEY` stored in `/data/.env` or passed via `Authorization: Bearer <key>`.
- **Markdown Endpoint:** Notion API `v1/pages` and `v1/pages/{id}/markdown` endpoints accept and output native Markdown syntax.

### 3. Unified Bridge Workflow
1. **Leader Instruction Dispatch:** When the Project Lead issues a command, the bridge logs a task in Notion and sends a Slack channel alert.
2. **Documentation Publishing:** Publishing markdown docs creates a page in Notion Knowledge Base and posts a notification link to Slack.

---

## 📱 iOS Mobile & Notion Integration Setup Pattern

When managing Notion integrations from an iOS device (iPhone/iPad):

### 1. Notion API Permission Model on iOS
- Notion API integration bots (`ntn_...` or `secret_...`) cannot see workspace pages until explicitly shared.
- **Mobile Setup Step:** In Notion iOS app, open the target page $\rightarrow$ tap `...` (top right) $\rightarrow$ `Connect to` $\rightarrow$ select the integration bot name (e.g. `Anya's connection`).

### 2. Automated Live Database Provisioning Protocol
1. **Probe Connected Pages:** Call `POST https://api.notion.com/v1/search` with `Authorization: Bearer <NOTION_TOKEN>`.
2. **Create Target Databases:** Once a parent page is returned, invoke `POST /v1/databases` to provision:
   - **Tasks & Roadmap Database:** `Task Name` (`title`), `Assignee` (`select`), `Status` (`select`), `Priority` (`select`), `Due Date` (`date`).
   - **Team Directory Database:** `Member Name` (`title`), `Email / Contact` (`email`), `Role` (`select`), `Status` (`select`).
3. **Populate Live Records:** Invoke `POST /v1/pages` with `parent: {"database_id": "<db_id>"}` to populate records.
4. **Fallback CSV Export:** Provide instant downloadable `.csv` files hosted via Netlify/Vercel so mobile users can tap 1-click import into Notion if live permissions are pending.
