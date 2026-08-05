# Voice Calling, B2B Email & Privacy Payments Reference Guide

This reference provides detailed technical specifications, hardware configuration examples, and code snippets for sub-second AI voice calling, B2B email discovery, Wyoming LLC privacy shielding, and Stripe Crypto USDC payouts.

---

## 1. Sub-Second Voice AI Engine Configuration

### Audio Pipeline Benchmarks:
- **Speech-to-Text (STT):** Groq Whisper API (`whisper-large-v3-turbo`) or local `faster-whisper` (< 120ms).
- **LLM Reasoning Engine:** Google Gemini 2.0 Flash REST API (`models/gemini-2.0-flash:generateContent`). Use `maxOutputTokens: 150` and `temperature: 0.5` for concise phone conversation turns (< 250ms).
- **Text-to-Speech (TTS):** `edge-tts` (Microsoft Neural Voices: `en-US-AvaNeural` / `en-US-AndrewNeural`) or `Kokoro-82M` (< 280ms).
- **Combined Latency:** **270ms – 900ms** total round-trip voice latency.

### GSM Modem Serial AT Command Interface (`pyserial`):
```python
import serial

conn = serial.Serial("/dev/ttyUSB2", 115200, timeout=2)

def dial_number(phone_number):
    conn.write(f"ATD{phone_number};\r\n".encode("utf-8"))

def answer_call():
    conn.write(b"ATA\r\n")

def hangup_call():
    conn.write(b"ATH\r\n")
```

### Android ADB / Termux Call Interface:
```bash
# Place call via Termux API
termux-telephony-call +15145550199

# Place call via ADB
adb shell am start -a android.intent.action.CALL -d tel:+15145550199
```

---

## 2. Same-Day Urgency Pitch & Pipeline Rules

- **Urgency Pitch Rule:** When a user sets a same-day deadline (e.g., 5 hours), **do NOT default to "tomorrow at 10 AM"**. Use **"TODAY in 30 minutes / 2 hours"** CTAs with direct payment activation links (`https://.../retail_demo.html`).
- **Exclusion List:** Keep a persistent list of converted/booked clients (`EXCLUDED_NAMES`) to prevent re-contacting leads who have already agreed to a strategy demo or meeting.

---

## 3. Privacy-Preserving Company Incorporation & Stripe Crypto Payouts

- **US Wyoming Anonymous LLC Structure:**
  - **Filing Fee:** $100 official state filing fee ($150–$300 total via Firstbase/Doola).
  - **Annual Renewal:** $62 / year.
  - **Public Privacy:** W.S. 17-29-201 prohibits listing owner/member names on public records. Only Registered Agent address is public.
  - **Taxation:** 0% US Federal Income Tax for non-US residents operating outside the US.

- **Stripe Crypto USDC Payouts:**
  - Connect Stripe US to Wyoming LLC.
  - Enable **Stripe Crypto Payouts** under Settings $\rightarrow$ Crypto.
  - Input Solana or Polygon Web3 wallet address (Phantom or MetaMask).
  - Stripe automatically converts fiat credit card payments into **USDC stablecoins** paid directly to your Web3 wallet.

---

## 4. Local Downloadable File Generation Rule

- When generating memory, skills, or codebase packages for knowledge transfer to an independent AI agent, generate direct downloadable local files (`/data/MEMORY.md`, `/data/SKILLS.md`, `/data/Project_Anya_Full_System_Codebase.zip`), without relying on live web hosting links.
