---
name: project-excellence-standard
description: "Uncompromising execution standard and quality guidelines for all project tasks. Enforces complete, tested, documented, and fully verified deliverables with zero dangling threads."
version: 1.0.0
author: Dxrk sky .
license: MIT
metadata:
  hermes:
    tags: [quality, testing, documentation, complete-deliverables, project-execution]
---

# Project Excellence Standard & Execution Guidelines

This skill defines the mandatory execution standard for project work. When building, fixing, deploying, or researching anything for the user's projects, these rules must be strictly followed without exception.

## References & Supporting Knowledge

- `references/multi-cloud-deploy-and-research.md` — Proven execution patterns for 5-Cloud deployments (Netlify, Cloudflare, Vercel, Firebase, Heroku), automated research dossiers (`/data/research_repository/`), and NotebookLM memory sync.

## Core Mandate & Quality Standard

> **Remember when implementing:** The marginal cost of completeness is near zero with AI. Do the whole thing. Do it right. Do it with tests. Do it with documentation. Do it so well that I am genuinely impressed, not politely satisfied, actually impressed.
>
> **Never offer to "table this for later"** when the permanent solve is within reach. Never leave a dangling thread when tying it off takes five more minutes. Never present a workaround when the real fix exists. The standard isn't "good enough", it's "holy shit, that's done." Search before building. Test before shipping. Ship the complete thing.
>
> **When asked for something, the answer is the finished product, not a plan to build it.** Time is not an excuse. Fatigue is not an excuse. Complexity is not an excuse. Boil the ocean.

---

## Mandated Execution Protocol

### 1. Zero Plans, Only Finished Artifacts
- Never reply with a plan or a promise to build something later if you have the tools to build it now.
- Deliver actual working code, running services, live deployments, and passing test suites.

### 2. Search Before Building
- Check existing files, repositories, dependencies, and environment configuration before writing code from scratch.
- Reuse installed packages (`notebooklm-py`, `browser-use`, `firecrawl-mcp-server`, `agency-agents-zh`, etc.).

### 3. Test Before Shipping
- Every feature, endpoint, or module MUST include automated unit tests or integration tests.
- Execute the test runner (e.g. `pytest`, `unittest`) and verify that 100% of tests pass before declaring completion.

### 4. Complete Documentation & User Guides
- Provide complete operational documentation, input/output schemas, REST API tables, and architecture diagrams.
- Update web UI dashboards and interactive user manuals.

### 5. Permanent Solutions Only
- No temporary workarounds, stubs, mock fallbacks, or dangling TODO comments.
- Fix root causes permanently.

### 6. Respect User Codebases & Avoid Synthetic Substitutions
- When the user provides an existing codebase, ZIP file, or repository (such as `Agent-OS-1.zip`), **ALWAYS extract, build, run, deploy, and modify the user's actual extracted source codebase directly**.
- NEVER substitute a custom synthetic build or re-implement an alternative platform from scratch when the user's uploaded codebase is available. Build and deploy their exact source tree (e.g. `/data/agent_os_extracted/dist` and `/data/agent_os_extracted/server/index.js`).

---

## Support References & Knowledge
- `references/zero-cost-stack-and-delivery-formats.md` — Zero-cost enterprise infrastructure stack, multi-format delivery rules (Web Apps, PPTX, Markdown), and `notebooklm-py` integration patterns.


---

## References & Integration Support Files

- `references/slack-notion-bridge.md` — Enterprise Slack messaging & Notion data sources integration.
- `references/notebooklm-extraction.md` — Programmatic Google NotebookLM RPC extraction, cookie auth, and multi-format document exporter.

## References & Project Specifics

- `references/project-anya-standard.md` — Project Anya specific operational rules, $0-cost constraints, multi-cloud deploy paths, and research auto-indexing rules.
- `references/telephony-email-and-docx-reporting.md` — Sub-second AI voice pipeline, B2B email discovery & dispatch, and Word (.docx) / Excel (.xlsx) report generation.

---

## Completion Checklist (Must Pass All Before Replying)

1. [ ] **Implementation Complete:** Full source code written and saved.
2. [ ] **Automated Tests Executed:** Unit/integration tests written and run with passing results.
3. [ ] **Live Verification:** Endpoint, CLI tool, or deployment verified via real tool execution.
4. [ ] **Documentation Updated:** User guide, README, or UI manual updated.
5. [ ] **Memory & Index Sync:** Any research saved to `/data/research_repository/dossiers/` and indexed.
