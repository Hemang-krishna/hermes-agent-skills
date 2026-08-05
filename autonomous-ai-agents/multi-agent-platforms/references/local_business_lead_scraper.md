# Local Business Lead Scraper & Notion/Slack Integration Reference

## 1. Overview & Business Value

Local businesses lacking an active website are high-converting leads for web development, online booking systems, and digital marketing services. This module automates the discovery, website filtering, lead qualification scoring, and direct synchronization into enterprise databases (Notion & Slack).

---

## 2. Technical Pipeline Architecture

```
[Local Business Query] -> [Google Maps / DDGS Search]
                             │
                             ▼
              [Website Exclusion Filter]
           (Keeps businesses with Website == Null)
                             │
                             ▼
              [AI Lead Qualification Scoring]
           (Evaluates Phone, Reviews & Rating)
                             │
           ┌─────────────────┴─────────────────┐
           ▼                                   ▼
[Notion Database Page Creation]    [Slack Channel Webhook Alert]
 (`{"parent": {"database_id": ...}}`)   (Formatted Lead Card)
```

---

## 3. Lead Qualification Algorithm

```python
def qualify_lead(name: str, phone: str, website: Optional[str], rating: float, reviews_count: int):
    has_site = bool(website and website.strip() and website.lower() not in ["none", "n/a", "no website", "null"])
    if has_site:
        return (True, 0.0, "DISQUALIFIED", "Already has website")

    score = 40.0 # Base missing website bonus
    if phone and phone != "N/A": score += 25.0
    if reviews_count >= 20: score += 20.0
    elif reviews_count >= 5: score += 10.0
    if rating >= 4.0: score += 15.0
    elif rating >= 3.0: score += 5.0

    score = min(100.0, score)
    tier = "HOT" if score >= 75.0 else ("WARM" if score >= 50.0 else "COLD")
    return (False, score, tier, outreach_strategy)
```

---

## 4. Notion API Database Page Targeting Pitfall & Solution

* **Pitfall:** Calling `https://api.notion.com/v1/pages` with `parent: {"page_id": ...}` on a Notion database object results in `HTTP 404 Not Found`.
* **Solution:** Inspect `search_connected_pages()` objects. When `object == "database"`, pass `parent: {"database_id": target_db_id}` and map properties to exact database column types (`Task Name`: title, `Status`: select, `Priority`: select, `Assignee`: select, `Due Date`: date).

---

## 5. File Location & Unit Tests

* Module: `/data/local_business_lead_scraper.py`
* Tests: `/data/test_local_business_lead_scraper.py`
* Command: `PYTHONPATH=/data python3 /data/local_business_lead_scraper.py --category "Plumbers" --location "Austin TX" --limit 5`
