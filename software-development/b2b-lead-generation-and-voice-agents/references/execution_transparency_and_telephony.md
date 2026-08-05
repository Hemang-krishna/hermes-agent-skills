# Execution Transparency, Same-Day Sales Scripting & Native Telegram Delivery

## 1. Execution Mode Transparency
When executing automated sales, calling, or emailing tasks:
- **Disclose Live vs. Simulated Mode:** Always state up front whether the action is running against live production APIs/hardware or in simulated/mock mode.
- **Data Source Breakdown:** Explicitly differentiate between scraped real business listings, verified phone/email leads, and synthetic fallback seeds.

## 2. Urgent Same-Day Sales Scripting
- **Short-Window Deadlines:** When a user sets a short execution deadline (e.g., 2–5 hours), do NOT default to standard "tomorrow at 10 AM" sales booking placeholders.
- **Immediate Call-to-Action:** Frame CTAs around same-day activation: *"If you activate your custom store in the next 30 minutes, we waive the $100 setup fee."*
- **Direct Link Delivery:** Send direct payment checkout links (`/static/retail_demo.html`) via SMS/email while on the phone call.

## 3. Telegram Native File Delivery
- **Native Delivery Format:** Use `MEDIA:/path/to/file.ext` to deliver files natively in Telegram chats.
- **Local File Generation:** Write persistent knowledge exports locally to `/data/MEMORY.md` and `/data/SKILLS.md` without requiring external live web download services.
