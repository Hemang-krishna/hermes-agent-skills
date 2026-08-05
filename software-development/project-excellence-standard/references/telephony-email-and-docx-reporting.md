# Telephony, Email Dispatch & Document Reporting Workflows

This reference documents the proven technical patterns for sub-second AI voice calling, autonomous email discovery & dispatch, and multi-format document generation (.docx / .xlsx).

---

## 1. Sub-Second (< 450ms) AI Voice Calling Pipeline

To achieve human-like, real-time phone responses on outbound AI calls:

- **Speech-to-Text (STT):** Groq Whisper API or local `faster-whisper` / `vosk` (< 120ms).
- **LLM Reasoning:** Google Gemini 2.0 Flash REST API (`models/gemini-2.0-flash:generateContent`) with `maxOutputTokens: 150` for short conversational turns (< 250ms).
- **Text-to-Speech (TTS):** `edge-tts` (Microsoft Neural Voices like `en-US-AvaNeural`) or local `Kokoro-82M` (< 280ms).
- **Telephony Drivers:**
  - **GSM Modem AT Commands:** Control `SIM7600` / `Huawei E3372` over `/dev/ttyUSB2` via `pyserial` (`ATD<number>;`, `ATA`, `ATH`, `AT+CMGS`).
  - **Android Gateway:** Trigger calls via Termux API (`termux-telephony-call`) or ADB (`adb shell am start -a android.intent.action.CALL -d tel:<number>`).

---

## 2. Autonomous B2B Email Discovery & Dispatch Engine

When dispatching B2B proposal emails without external MCP services:

- **Email Synthesis:** Clean company name into domain slug (`info@<slug>.ca` / `contact@<slug>.com`).
- **MIME HTML Generation:** Include a highlighted call-to-action button linking directly to the live custom web prototype (`https://<domain>/static/retail_demo.html`).
- **Dual Database Dispatch:** Simultaneously log the task into Notion Task Database (`create_notion_task`) and broadcast alert cards to Slack Webhook (`send_webhook_message`).

---

## 3. Microsoft Word (.docx) & Excel (.xlsx) Report Generation

### Microsoft Word (.docx) Formatting with `python-docx`:
- **Document Styling:** Set 1-inch margins, custom RGB typography (`Pt(22)` title, `Pt(14)` section headers), and callout boxes.
- **Custom XML Table Shading & Padding:**
  ```python
  from docx.oxml import parse_xml, OxmlElement
  from docx.oxml.ns import nsdecls, qn

  def set_cell_background(cell, fill_color_hex):
      tcPr = cell._tc.get_or_add_tcPr()
      shd = parse_xml(f'<w:shd {nsdecls("w")} w:fill="{fill_color_hex}"/>')
      tcPr.append(shd)
  ```
- **Dual Path Saving:** Always save `.docx` files to both `/data/reports/` and static web folder `/data/agent_platform/static/` for direct browser downloads over HTTPS tunnels.
