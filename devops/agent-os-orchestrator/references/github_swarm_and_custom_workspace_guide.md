# GitHub Swarm & Custom Agentic Workspace Integration Guide

## Overview
This reference guide details the architecture for integrating GitHub tools, 16 local cloned repositories, pre-commit code audits, and multi-agent swarm orchestration into custom Agentic Workspaces.

## Key Capabilities
1. **GitHub Tools & Local Repositories:** Leverages 16 local cloned repositories (`/data/external_repos/`) including `codebase-memory-mcp`, `goose`, `daytona`, `Scrapling`, `dyad`, `npxskillui`, `Scout`, `career-ops`, `impeccable`, `taste-skill`, `extract-design-system`, `superpowers`, and `awesome-n8n-templates`.
2. **Pre-Commit Code Audits & PR Reviews:** Automates python syntax checks, zero-division error scans, security gate reviews, and PR summary generation via `GitHub Developer Swarm Agent`.
3. **Google Gemini 2.0 Flash Integration:** Uses valid Gemini API key (`AQ.Ab8RN...`) for high-speed content generation with instant failover to Option 3 Local Engine on HTTP 429 rate limits.
4. **Bespoke Cyber Void UI Aesthetics:** Implements `#060811` void dark background, `#0E1322` cyber glass cards, `#06B6D4` cyan highlights, `#8B5CF6` violet accents, full-box functional prompt space with parameter sliders, tool toggles, and live terminal console.
