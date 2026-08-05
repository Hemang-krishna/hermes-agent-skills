# n8n Agent Workflow Automation & Self-Hosting Architecture

This reference documents production patterns for converting autonomous AI agents into **n8n JSON Workflow Templates** and hosting them on $0/low-cost infrastructure.

---

## 1. n8n Node Patterns for Core AI Agent Classes

### A. Autonomous SDR Lead Generation Agent (Alice/Jordan Class)
- **Webhook Node:** Listens for inbound lead form triggers or CRM lead creation events.
- **HTTP Request Node (Enrichment):** Calls Apollo, Clay, or Clearbit waterfall enrichment APIs.
- **OpenAI/Gemini LLM Node (ICP Evaluator):** Evaluates lead firmographics against ICP criteria and calculates qualification scores.
- **If / Switch Node:** Routes leads based on score (`>= 0.7` $\rightarrow$ Qualified outreach, `< 0.7` $\rightarrow$ Disqualified log).
- **OpenAI/Gemini LLM Node (Personalizer):** Generates custom email body referencing news triggers.
- **Email Send Node (SendGrid/SMTP):** Dispatches personalized outreach.
- **Slack/Notion Node:** Logs disqualified or low-priority leads.

### B. Enterprise Customer Action & Security Agent (Sierra Class)
- **Webhook Node:** Ingests live customer support chat messages.
- **LLM Guardrail Node:** Pre-screens user prompt for security violations (prompt injection, system prompt leakage, SQL injection).
- **If Node (Guardrail Check):** Halts workflow execution if prompt is flagged as unsafe.
- **LLM Intent Classifier Node:** Determines domain intent (Order modification vs policy inquiry).
- **HTTP Request Tool Node:** Executes deterministic REST API call (e.g. `PATCH /v1/orders/{id}`) for order address changes.
- **HTTP Request RAG Node:** Queries Qdrant/Pinecone vector database for policy document context.
- **Telegram/Slack/Chat Response Node:** Returns verified response to customer.

### C. Sandboxed Engineering Agent (Devin Class)
- **GitHub Issue Webhook Node:** Triggers on new issue creation or pull request events.
- **Execute Command Node (Git Sandbox):** Clones target repo, creates fix branch in isolated `/tmp` workspace.
- **Execute Command Node (Test Runner):** Executes `pytest` or `npm test` suite.
- **LLM Patch Generator Node:** Parses test stdout/stderr failure logs and generates targeted patch code.
- **Execute Command Node (Commit & Push):** Commits fix and pushes branch to GitHub remote.
- **GitHub Node (Open PR):** Opens pull request on GitHub repository automatically.

### D. Autonomous Multi-Platform Job Search & Aggregation Agent (1000+ Platforms Class)
- **Schedule Trigger Node:** Fires daily at scheduled hour (e.g. 9:00 AM IST).
- **HTTP Request Node (Multi-Platform API / Aggregator):** Queries 6 platform tiers (Tier 1 Portals like Naukri/LinkedIn/Indeed, Tech/Startup Portals like Instahyre/Cutshort, Enterprise ATS like Greenhouse/Lever, Global Remote Boards like Turing/Outlier, Govt/PSU Boards, Google Jobs API).
- **LLM Relevance & Anti-Scam Filter Node:** Scores match relevance against user skills/CTC and eliminates suspicious listings (demanding registration fees, unverified messaging app links).
- **Slack / Telegram / Notion Dispatch Nodes:** Posts top 5 deduplicated job alerts directly to team communication channels and mobile Notion databases.

---

## 2. Low-Cost & Free Hosting Platforms for n8n Workflows

```
+----------------------------------------------------------------------------------------------------+
|                               BEST HOSTING PLATFORMS FOR n8n WORKFLOWS                            |
+----------------------+-------------------+----------------+----------------------------------------+
| Platform             | Tier / Pricing    | Specs          | Key Advantage                          |
+----------------------+-------------------+----------------+----------------------------------------+
| Oracle Cloud (OCI)   | Always Free       | 4 vCPU, 24GB   | Best overall. 100% free forever.       |
| Render / Railway.app | $0 - $5/month     | 1 vCPU, 512MB  | 1-Click Docker deploy with volume disk |
| Hugging Face Spaces  | $0 Free           | 2 vCPU, 16GB   | Docker container hosting on free space |
| Local Docker Host    | $0 Free           | Native Host    | Zero network latency, full disk control|
+----------------------+-------------------+----------------+----------------------------------------+
```

### Docker Startup Command
To deploy n8n self-hosted with persistent data volume:

```bash
docker run -d \
  --name n8n \
  --restart always \
  -p 5678:5678 \
  -e N8N_HOST="0.0.0.0" \
  -e N8N_PORT=5678 \
  -e N8N_PROTOCOL="http" \
  -v n8n_data:/home/node/.n8n \
  docker.n8n.io/n8nio/n8n
```
