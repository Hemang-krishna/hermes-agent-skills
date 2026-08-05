# Autopilot Retail Lead Generation, Voice Calling & Web Design Pipeline Reference

## 1. Overview & Autopilot Architecture

This reference details the full 100% autopilot pipeline for discovering retail businesses without a website, scoring and verifying leads, dispatching live Notion/Slack entries, executing outbound AI voice calls, and autonomously generating custom HTML5/Tailwind web prototypes for booked clients.

---

## 2. Autopilot Pipeline Workflow

```
[Retail Lead Discovery] -> [Website Exclusion & Qualification]
                                      │
                                      ▼
                      [Notion & Slack Live Sync]
                                      │
                                      ▼
                     [Sub-Second Voice AI Calling]
                                      │
                                      ▼
                   [Automated Client Web Prototype Builder]
```

---

## 3. Specialized Supervisory Agent Pattern

To ensure 100% execution reliability without human intervention, delegate pipeline oversight to a dedicated supervisor subagent:
* **Role:** Audit lead qualification filters, verify Notion/Slack database dispatches, monitor voice call response latency, and check client web prototype output.
* **Test Verification:** Run integration unit tests across all stages before reporting campaign completion.

---

## 4. Automated Client Web Prototype Generator

For every booked client, the pipeline executes `client_web_prototype_generator.py` to produce a high-converting HTML5 landing page prototype:
* **Header:** Glassmorphic layout with business name, location badge, and click-to-call CTA.
* **Trust Elements:** Live Google Reviews rating badge and customer testimonial cards.
* **Product Showcase:** Interactive grid featuring curated products/services with price tags.
* **Store Info:** Operating hours, address, and consultation request form.

---

## 5. Sub-Second Voice AI Calling Performance

* **Pipeline:** Groq Whisper STT / VAD -> Google Gemini 2.0 Flash REST API ($0 Free Tier) -> Edge-TTS (Microsoft Neural Voices).
* **Average Voice Response Latency:** ~270ms - 450ms.
* **International Routing:** Route calls through local Android phone nodes (via Termux API / ADB) or USB 4G dongles to eliminate international roaming charges ($0 infrastructure cost).

---

## 6. Code & File Locations

* **Lead Scraper Engine:** `/data/local_business_lead_scraper.py`
* **Voice Calling Engine:** `/data/project_anya_voice_calling_agent.py`
* **Web Prototype Generator:** `/data/client_web_prototype_generator.py`
* **Master Pipeline Audit:** `/data/audit_toronto_retail_pipeline.py`
* **Integration Tests:** `/data/test_audit_toronto_retail_pipeline.py`
