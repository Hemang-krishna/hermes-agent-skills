# Autonomous Email Discovery & B2B Proposal Engine ($0 Infrastructure)

This reference documents the autonomous email discovery, personalized B2B web preview proposal generation, SMTP/relay dispatch, and dual Notion/Slack logging engine (`/data/autonomous_email_lead_engine.py`).

---

## 🏛️ 1. Architecture & Workflow

```
[1. Lead Email Discovery] ──> [2. Hyper-Personalized Email Generator] ──> [3. Python SMTP / Relay Engine]
                                                                                │
[5. Slack Live Alert Card] <── [4. Notion DB Status Update (EMAIL_SENT)] <──────┘
```

---

## 🛠️ 2. Core Python Implementation Pattern

```python
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

# 1. Synthesize business contact email
clean_slug = re.sub(r"[^a-zA-Z0-9]", "", business_name.lower())[:32]
target_email = f"info@{clean_slug}.ca" if "canada" in city.lower() else f"contact@{clean_slug}.com"

# 2. Build personalized HTML5 email body linking to client web prototype
msg = MIMEMultipart("alternative")
msg["Subject"] = f"Custom Website & Online Store Preview for {business_name}"
msg["From"] = sender_email
msg["To"] = target_email

# 3. Dispatch via SMTP or simulated relay
with smtplib.SMTP("smtp.gmail.com", 587) as server:
    server.starttls()
    server.login(sender_email, sender_password)
    server.sendmail(sender_email, target_email, msg.as_string())
```

---

## 🗄️ 3. Notion Database Mapping & Slack Notifications

* **Notion Task Creation:** Creates a task in Notion database with property `Task Name: ✉️ [EMAIL SENT] <Business Name> (<Email>)` and status `In Progress` / `EMAIL_SENT`.
* **Slack Channel Alert:** Dispatches formatted markdown alert card containing lead name, target email address, web preview link, and delivery status.
