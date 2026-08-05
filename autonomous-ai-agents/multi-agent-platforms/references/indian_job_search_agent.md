# Autonomous Job Search Agent (1000+ Platforms Ecosystem)

This reference documents the design, deduplication mechanics, anti-scam heuristics, and multi-workspace alert dispatching for autonomous job search agents across 1000+ job portals, startup platforms, enterprise ATS boards, and regional/government databases.

---

## 1. 6-Tier Indian Job Platform Architecture

```
+---------------------------------------------------------------------------------------------------------+
|                               INDIAN JOB SEARCH AGENT COVERAGE SPECTRUM                                 |
+--------------------------+------------------------------------+-----------------------------------------+
| Category                 | Platforms Included                 | Sourcing Method                         |
+--------------------------+------------------------------------+-----------------------------------------+
| Tier 1 Portals           | Naukri.com, LinkedIn India, Indeed | API + Direct Scrape Waterfall           |
|                          | Foundit (Monster), Shine, Glassdoor| Real-time keyword & CTC filters         |
+--------------------------+------------------------------------+-----------------------------------------+
| Tech & Startup Portals   | Instahyre, Cutshort, Wellfound     | GraphQL / REST API Extraction           |
|                          | Hirist, Hasjob, Unstop, iimjobs    | Equity, Tech stack, & Remote filters    |
+--------------------------+------------------------------------+-----------------------------------------+
| Enterprise ATS Systems   | PwC, EY, Deloitte, KPMG Careers,   | Direct Corporate Career Site Crawling   |
|                          | Greenhouse, Lever, Workday         | Unfiltered direct-to-company postings   |
+--------------------------+------------------------------------+-----------------------------------------+
| Global Remote for India  | Turing India, Outlier AI, Toptal   | Global Remote RSS & API Ingestion       |
|                          | RemoteOK India, WeWorkRemotely     | USD-to-INR CTC Conversion               |
+--------------------------+------------------------------------+-----------------------------------------+
| Govt / PSU & Regional    | National Career Service (NCS),     | Public Feed Ingestion                   |
|                          | FreeJobAlert, Sarkari Result       | Pay Commission CTC parsing              |
+--------------------------+------------------------------------+-----------------------------------------+
| Search Engine Waterfall  | Google Jobs India API, SerpAPI,    | Deep Web Extraction                     |
|                          | Firecrawl Crawl Engine             | Catches hidden unlisted portal listings |
+--------------------------+------------------------------------+-----------------------------------------+
```

---

## 2. Core Deduplication & Anti-Scam Mechanics

### A. Cross-Platform Fingerprinting
Job postings listed simultaneously across Naukri, LinkedIn, and Indeed are deduplicated using a deterministic MD5 fingerprint hash of normalized job attributes:

```python
import re, hashlib

def generate_job_fingerprint(title: str, company: str, location: str) -> str:
    clean_title = re.sub(r'[^a-zA-Z0-9]', '', title.lower())
    clean_company = re.sub(r'[^a-zA-Z0-9]', '', company.lower())
    clean_loc = re.sub(r'[^a-zA-Z0-9]', '', location.lower())
    return hashlib.md5(f"{clean_title}_{clean_company}_{clean_loc}".encode('utf-8')).hexdigest()
```

### B. Anti-Scam & Fraud Heuristics
Flags suspicious job postings common on unverified job boards:
1. **Upfront Payment Demands:** Keywords like "registration fee", "refundable deposit", "pay money for interview".
2. **Unverified Messenger Redirects:** Redirection to "WhatsApp group", "contact on Telegram", "t.me/".
3. **Unrealistic Freshers Packages:** Entry-level postings offering >50 LPA without technical requirements.

---

## 3. Supported Entry-Level & Professional Role Domains

* **Tech & AI Roles:** AI Engineer, LLM Developer, Full Stack Engineer, Data Scientist, DevOps / Cloud Architect, Cybersecurity Specialist.
* **Finance & Audit Roles:** Audit Associate (Statutory / Internal Audit - PwC, EY, Deloitte, KPMG), Financial Analyst (FP&A, Valuation - Goldman Sachs, J.P. Morgan), Risk & Compliance Associate (AML/KYC - Amex, HSBC).
* **Operations & Safety Roles:** Trust & Safety Associate (Google, Amazon, Meta, Genpact), Policy Enforcement Analyst.

---

## 4. Mobile & iOS PWA Execution Pattern

Deploy an interactive single-page app (SPA) or PWA (e.g. `jobs.html`) to Netlify/Cloudflare to allow users to search, filter by city (Bengaluru, Mumbai, Gurgaon, Hyderabad, Pune, Noida, Remote), adjust minimum CTC LPA sliders, and apply with 1 tap directly from an iPhone Home Screen icon.
