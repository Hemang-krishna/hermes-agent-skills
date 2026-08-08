# Discord-Notion Enterprise Bridge & Mandatory GitHub Account Synchronization Policy

## 1. Discord as Primary Enterprise Communication Bridge & Snorlax 24/7 Bot
- **Replacing Slack with Discord:** Discord serves as the primary communication bridge for Project Snorlax / Project Anya. Discord provides rich colored embeds, webhooks, channel messages, file attachments, and unlimited message history on its free tier.
- **Notion to Discord Live Sync (`DiscordIntegrationEngine`):**
  - Notion Task Database events (creation, status changes, priority assignments) are formatted into Discord Embeds with custom color coding (e.g., `#2563eb` Royal Blue for instructions, `#10b981` Emerald Green for documentation, `#f59e0b` Gold for Founder/Executive announcements, `#8b5cf6` Purple for team additions).
  - Discord Webhooks (`post_webhook_embed`) or Bot Token API (`post_channel_message`) dispatch alerts instantly into designated channels (e.g., `#general` channel ID `1535612387111997512`).
- **Bot Setup, Invite Extraction & Gateway Connection:**
  - **Invite Link Extraction:** When given a Discord invite link (e.g. `https://discord.gg/vQyhEVeRu`), query `https://discord.com/api/v10/invites/{code}?with_counts=true` to extract Guild ID (`1535612386009161881`), Channel ID (`1535612387111997512`), and Server Name ("Project Snorlax").
  - **OAuth2 Authorize Link:** Direct user to `https://discord.com/api/oauth2/authorize?client_id=<BOT_ID>&permissions=8&scope=bot%20applications.commands`.
  - **Privileged Gateway Intents Pitfall & Fix:** When connecting a bot via `discord.py` (`discord.Client` / `commands.Bot`), requesting `intents.message_content = True` before enabling it in the Developer Portal causes `discord.errors.PrivilegedIntentsRequired` and prevents the bot from coming online.
  - **Correct Connection Pattern:** Use default non-privileged intents (`intents = discord.Intents.default()`) during initial startup so the bot connects instantly to the Gateway (`wss://gateway.discord.gg`). Then, instruct the user to toggle **Message Content Intent** `ON` in the Discord Developer Portal under the Bot tab for full channel message reading.
  - **24/7 Background Runner (`discord_bot_runner.py`):** Launch the bot in a background process using `python3 /data/discord_bot_runner.py`. Ensure `sys.path.append("/data/integrations")` and `sys.path.append("/data")` are set so sub-modules (`discord_integration`, `enterprise_bridge`) resolve properly.

## 2. Bulletproof Real-Time Web Search, Passive Chat Reading & Telegram Reporting
- **Bulletproof Web Search Engine (`perform_bulletproof_web_search`):**
  - **Regex Fragility Pitfall:** Do NOT rely on brittle regex matching over DuckDuckGo HTML results (regex breaks when DDG updates class names or HTML tags).
  - **BeautifulSoup + DuckDuckGo Lite Solution:** Use `BeautifulSoup4` with `https://lite.duckduckgo.com/lite/`. Parse result rows (`tr`) to extract clean titles (`a.result-link`), clean snippets (`td.result-snippet`), and direct unquoted URLs (`https://...`), returning 100% real-time web sources.
- **Universal Catch-All Router vs. Brittle Keywords:**
  - Do NOT restrict query routing to narrow keyword matches (`search`, `what is`, `how to`, `?`, `status`, `help`). Arbitrary user questions (e.g., `"give me the least boring ways to sit at work"`) fall through and produce empty responses.
  - Always route arbitrary user queries into the live web search + AI answer synthesis pipeline so Snorlax returns a rich, structured embed card.
- **Selective Mention Responding vs. Passive Chat Reading:**
  - **Passive Chat Logging:** Snorlax passively reads and logs ALL team messages into `/data/discord_team_chats.json` to monitor workflow state without spamming the public channel.
  - **Cute @Mention-Only Responding:** Snorlax posts public Discord responses ONLY when explicitly `@mentioned` by a team member, incorporating relative cute emojis (`🌸`, `🎀`, `🐣`, `⚡`, `☕`) and clean embed formatting.
- **Personal Telegram Workflow State Reporting:**
  - Snorlax analyzes team chat logs (`/data/discord_team_chats.json`) and generates a structured **Personal Workflow Report** detailing active team members, recent messages, and progress blockers.
  - Deliver this report **EXCLUSIVELY TO TELEGRAM (`8549729101`)** for the workspace owner (Dxrk sky) — do NOT post private team workflow state reports to public Discord channels or Notion.

## 3. Twice-Daily Automated Check-In Routine & Anti-Brain-Fog Engine
- **Twice-Daily Schedule (`tasks.loop`):**
  - **Morning Check-In (09:00 AM UTC):** Greets Founder Vishwajith (@Vish7781), Tech Director Monkey D Luffy (@lo_uffy_1999), and Dxrk sky. Rotates a fresh, non-repetitive motivational quote (from Dijkstra, Alan Kay, Picasso, Tim Ferriss, Robin Sharma), asks for daily roadmap goals, and reminds the team of 24/7 AI availability.
  - **Afternoon Check-In (02:00 PM UTC / 14:00 PM):** Mid-day energy check-in, anti-brain-fog protocol (3-minute screen breaks, rubber-duck debugging, 25-minute Pomodoro focus blocks), and technical support offer.
- **Unlocking 5 Advanced Superpowers:**
  1. **GitOps AI Issue Creator:** `@Snorlax issue <title>` creates a live issue in `Hemang-krishna/project-anya` via GitHub REST API.
  2. **Visual n8n Flow Architect:** Renders visual Mermaid.js node flowcharts and JSON template links.
  3. **Bulletproof Real-Time Web Search:** BeautifulSoup DDG Lite search engine.
  4. **Notion Workspace Sync:** Live-syncs tasks and docs to *Anya's Space*.
  5. **Sub-Second Voice AI & Scraper Telemetry:** Monitors voice call latency (~380ms) and local business lead scrapers.

## 2. Executive Team Directory & Notion-Discord Bridge
- **Adding Team Members & Executive Leads (`add_team_member`):**
  - When user provides team member or founder details (e.g., `Vishwajith`, `Founder`, `chvishwajith.pandu@gmail.com`, `Vish7781` or `Monkey D Luffy`, `Director in Technology`, `lo_uffy_1999`):
  - Store record in Notion Team Database (`team_database.json` / Notion API) under `members` list with status `ACTIVE & AUTHORIZED`.
  - Format and broadcast a welcome embed card to Discord (`post_channel_message` / `post_webhook_embed`). Use Gold (`#f59e0b`) for Founder/Executive cards and Purple (`#8b5cf6`) for Technology Directors.
  - Commit and push updated `enterprise-communication-bridge` repository to GitHub under `Hemang-krishna`.

## 3. Visual n8n Automation Demonstration Format
- **Demonstrating Workflows in Discord & Notion:**
  - Represent n8n workflows as structured visual ASCII / node diagrams: `[Trigger] ➔ [Logic] ➔ [Action]`.
  - Include Node details, execution status badges (`🟢 ACTIVE`), latency stats, and 1-click webhook test links.
  - Post formatted workflow embeds into Discord and Notion Knowledge Base pages so team members understand automation mechanics visually.

## 4. Visual n8n Automation & Flow Architect Engine
- **Conversational Tone & Answer-FIRST + Webpages-LATER Architecture:**
  - **Eliminating Stiff/Robotic Embed Templates:** Never use robotic templates like `"I have processed your message in real-time"`, `"Your Message: hii"`, or `"Productivity Insight:"`. Snorlax must respond like a warm, intelligent, human-like team assistant using natural phrasing and relative cute emojis (`🌸`, `😴`, `⚡`, `☕`, `✨`).
  - **Handling Simple Greetings:** Simple hellos (`hii`, `hello`, `hey`, `good morning`) receive a warm, friendly chat reply with cute emojis (e.g. *"Hii Luffy! 🌸 Hope you're having an awesome day on Project Snorlax! How can I help you right now? ☕⚡"*), without dumping search links or daily quotes.
  - **Answer FIRST, Webpages LATER Flow:**
    1. **Direct Answer FIRST:** Synthesize a clear, direct, intelligent human prose answer answering the user's question or defining the concept.
    2. **Visual n8n Node Flowchart Diagram:** Always render an ASCII / Mermaid visual flow diagram (`[Trigger Node] ➔ [Ollama/Gemini LLM] ➔ [Qdrant Vector RAG] ➔ [Action/Discord Embed]`).
    3. **Interactive Web Canvas Link:** Provide direct link to the self-hosted n8n AI Flow Architect web application (`https://anya-agentic-space.loca.lt/static/n8n_ai_flow_architect.html`).
    4. **Supporting Web References LATER:** Append 2-3 top supporting reference webpage links (with clean titles, snippets, and direct URLs) at the bottom.
- **Self-Hosted AI Starter Kit Integration (`self-hosted-ai-starter-kit`):**
  - Uses `n8n-io/self-hosted-ai-starter-kit.git` (n8n + Ollama local LLMs + Qdrant Vector Store + PostgreSQL).
  - Pushed to head GitHub account: `https://github.com/Hemang-krishna/self-hosted-ai-starter-kit`.

## 5. Mandatory GitHub Head Account Synchronization Policy
- **Primary GitHub Account:** `Hemang-krishna` (`krishnachaitanyalagadapatihema@gmail.com`).
- **Mandatory Policy Rule:** Every project, skill, code engine, web builder suite, or automation tool created or installed in the environment MUST automatically be initialized as a Git repository and pushed live to `https://github.com/Hemang-krishna/<repo-name>`.
- **Handling Secret Scanning (GH013 Push Protection):**
  - Before committing or pushing, scan files for API keys, tokens, or credentials (e.g., Notion tokens `ntn_...`, Gemini keys `AQ...`, Slack tokens `xoxp-...`).
  - Replace raw key strings with dynamic environment reads (`os.environ.get("...")`) or browser `localStorage.getItem("...")`.
- **Handling Shallow Clones (`git clone --depth 1`):**
  - Shallow clones fail on push with `remote unpack failed: index-pack failed`.
  - Fix: Copy source files (excluding `.git`) to a fresh export directory, run `git init`, `git add .`, `git commit`, and push using authenticated PAT URL `https://Hemang-krishna:<PAT>@github.com/Hemang-krishna/<repo_name>.git`.
