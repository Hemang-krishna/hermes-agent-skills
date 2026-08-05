# Telephony Hardware & Sub-Second Voice AI Agents ($0 Infrastructure Blueprint)

## 1. Overview & Telephony Pathways

To connect AI agents to PSTN phone networks without recurring cloud VoIP fees ($0/month), four main hardware and software pathways exist:

```
                  +-----------------------------------+
                  |   HERMES VOICE AI AGENT CORE      |
                  +-----------------------------------+
                                    |
     ┌──────────────────────────────┼──────────────────────────────┐
     ▼                              ▼                              ▼
[Pathway 1: Android SIM]   [Pathway 2: USB 4G Modem]      [Pathway 3: Free Cloud VoIP]
Spare Android + Termux     USB 4G Dongle + AT Commands    Twilio / Telnyx Trial Credit
/ ADB / Local Linphone SIP  / Asterisk chan-dongle         / Google Voice WebRTC
```

---

## 2. Hardware Driver & Cellular Control (`telephony_ai_agent_bridge.py`)

### A. GSM Modem Serial Driver (AT Commands)
* Dial Outbound: `ATD+15125550199;`
* Answer Inbound: `ATA`
* Hang Up: `ATH`
* Send SMS: `AT+CMGS="+15125550199"` $\rightarrow$ `Message text\x1a`

### B. Android Smartphone Bridge (Termux / ADB)
* ADB Call: `adb shell am start -a android.intent.action.CALL -d tel:+15125550199`
* Termux Call: `termux-telephony-call +15125550199`

---

## 3. Sub-Second Latency (< 1.0s) Speech Pipeline Architecture

To achieve natural phone conversations (< 1.0s response latency):

1. **Voice Activity Detection (VAD):** Cuts audio frame on silence (< 50ms).
2. **Streaming STT:** Groq Whisper API / Faster-Whisper local model (< 120ms).
3. **LLM Reasoning:** Google Gemini 2.0 Flash REST API (Free Tier: 1,500 req/day, 4M tokens/min) (< 250ms).
4. **Streaming TTS:** Edge-TTS (`en-US-AvaNeural`) or Kokoro-82M Neural Voice (< 280ms).
5. **Total End-to-End Latency:** **~700ms – 900ms** (Sub-second response!).

---

## 4. Project Anya Outbound Sales Campaign Engine

* **Module:** `/data/project_anya_voice_calling_agent.py`
* **Tests:** `/data/test_project_anya_voice_calling_agent.py`
* **Workflow:**
  1. Load scraped local leads without websites.
  2. Initiate cellular call over SIM or Termux bridge.
  3. Deliver 2-sentence pattern interrupt pitch + handle objections dynamically.
  4. Upon agreement, log `[MEETING BOOKED]` to Notion & Slack.
