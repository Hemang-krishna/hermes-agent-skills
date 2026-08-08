---
name: b2b-lead-generation-and-voice-agents
description: Complete architecture and execution guide for B2B lead discovery (businesses lacking websites), sub-second AI voice calling, autonomous email proposals, privacy-preserving overseas company incorporation, and Stripe Crypto USDC payouts.
category: software-development
metadata:
  hermes:
    tags: [lead-generation, voice-ai, sales-automation, privacy-incorporation, stripe-crypto]
---

# B2B Lead Generation & Outbound AI Voice Calling Skill

## Overview
This skill governs the end-to-end procedural execution for identifying, qualifying, contacting, and converting local business prospects lacking a digital presence using sub-second AI voice pipelines, autonomous email proposals, and privacy-preserving payment structures.

## References & Supporting Knowledge
- See [Voice Calling, Email & Privacy Payment Guide](references/voice_calling_and_privacy_payments.md) for sub-second voice pipeline configurations, GSM/Android hardware drivers, B2B email discovery, Wyoming Anonymous LLC setup, and Stripe Crypto USDC payouts.
- See [Execution Transparency & Telephony Guide](references/execution_transparency_and_telephony.md) for execution mode disclosures, same-day sales scripting, and native Telegram file delivery.

## Core Procedural Workflows

### 1. Local Lead Discovery & Website Verification
1. **Scrape Local Directories:** Use `Scrapling` or `Google-Maps-Scrapper` to search target business categories (e.g. retail, plumbing, mechanics, contractors) in target cities.
2. **Technical Website Verification:** Run automated DNS/HTTP checks (`A` records / HTTP `HEAD`). Filter strictly for businesses with missing or invalid websites (`has_website == False`).
3. **Lead Qualification Scoring (0–100):**
   - Base Missing Website Bonus: +40 points
   - Direct Phone Line Present: +25 points
   - Review Count $\ge 20$: +20 points (or $\ge 5$: +10 points)
   - Star Rating $\ge 4.0$: +15 points
4. **Dual Database Dispatch:** Automatically push lead cards to Notion Tasks Database (`NotionEnterpriseEngine`) and post formatted alert cards to Slack Incoming Webhooks (`SlackIntegrationEngine`).

### 2. Sub-Second (< 450ms Latency) Outbound AI Voice Calling Pipeline
1. **Architecture:**
   - **Speech-to-Text (STT):** Groq Whisper API / Faster-Whisper (< 120ms)
   - **LLM Token Reasoning:** Google Gemini 2.0 Flash REST API (`models/gemini-2.0-flash:generateContent`, < 250ms)
   - **Text-to-Speech (TTS):** `edge-tts` (Microsoft Neural Voices like `en-US-AvaNeural`, < 280ms)
2. **Telephony Hardware Routing:**
   - **Android Smartphone Gateway:** Connect phone with active physical SIM/eSIM over local Wi-Fi. Trigger calls via Termux API (`termux-telephony-call`) or ADB commands.
   - **USB 4G Modem AT Commands:** Control `SIM7600G-H` over serial `/dev/ttyUSB2` via `pyserial` (`ATD<number>;`, `ATA`, `ATH`).
3. **Execution Transparency & Same-Day Urgency Rules (User Correction Lessons):**
   - **Mandatory Execution Transparency:** Always state clearly whether calls, emails, or transactions are running in **LIVE MODE** or **SIMULATED/STAGED TEST MODE**. Never present simulated test runs or synthetic seed data as live real-world dispatches.
   - **Same-Day Urgency CTA:** When the user specifies an urgent deadline (e.g. 2-hour / 5-hour revenue requirement), **NEVER default to placeholder CTAs like "tomorrow at 10 AM"**. Shift script & email CTAs to **Same-Day Urgent Options ("TODAY within 30 minutes / 2 hours")** with direct payment activation links (`https://.../retail_demo.html`).
   - **Preserve Converted Leads:** Always filter out previously booked/converted leads from subsequent campaign passes.
   - **Native Telegram Delivery:** Deliver reports, exports, and memory archives as native platform attachments using `MEDIA:/path/to/file` syntax and local files (`MEMORY.md`, `SKILLS.md`).

### 3. Privacy-Preserving Overseas Company Formation & Stripe Crypto Payouts
1. **Wyoming Anonymous LLC (US):** Wyoming law (W.S. 17-29-201) prohibits listing owner/member names on public state records. Only the Registered Agent address is public. 0% US Federal Income Tax for non-US residents operating outside the US.
2. **Stripe Crypto USDC Payouts:** Connect Stripe US to the Wyoming LLC. Stripe processes credit card payments (Visa, Mastercard, Apple Pay) and automatically converts fiat proceeds into **USDC stablecoins** paid directly to your private self-custody Web3 wallet (Phantom/MetaMask on Solana or Polygon).
3. **Local File Transfer Rule:** When generating memory or skill packages for knowledge transfer to another agent, generate direct downloadable local files (`/data/MEMORY.md`, `/data/SKILLS.md`), without depending solely on live web links.

### 4. Mandatory Multi-Repo GitHub Dispatch & Secret Sanitization
1. **Mandatory Head Account Dispatch Rule:** Every project, skill, code engine, or automation platform created in this environment MUST automatically be initialized as a git repository and pushed live to the head GitHub account `Hemang-krishna` (`krishnachaitanyalagadapatihema@gmail.com`).
2. **GitHub Secret Scanning & Push Protection (GH013) Sanitization:**
   - Before committing and pushing any repository to GitHub, scan all source code, HTML, and JS files for raw hardcoded secrets or API tokens (e.g. Notion API tokens `ntn_...`, Google API keys `AQ...`, Slack tokens `xoxp-...`).
   - Replace all raw credential strings with dynamic environment variable reads (`os.environ.get("KEY_NAME")`) or UI `localStorage` reads (`localStorage.getItem("KEY_NAME")`).
   - Push to authenticated remote URL: `git remote add origin https://Hemang-krishna:<PAT>@github.com/Hemang-krishna/<repo_name>.git`.

## Checklist Before Completing Lead Campaigns
1. [ ] Leads filtered strictly for missing websites (`has_website == False`).
2. [ ] Lead status live-synced in Notion & Slack workspace databases.
3. [ ] Voice agent turns running at sub-second latency (< 1.0 second).
4. [ ] Email proposals contain direct links to custom client web prototypes.
5. [ ] Prior converted/booked clients excluded from re-campaigning.
