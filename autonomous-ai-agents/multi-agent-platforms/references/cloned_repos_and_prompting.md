# External Repository Ecosystem & Master Prompting Reference

This document indexes 16 specialized developer repositories integrated into the multi-agent workspace, detailing their core capabilities and exact prompting patterns.

---

## 1. Repository Capabilities Matrix

1. **codebase-memory-mcp** (`/data/external_repos/codebase-memory-mcp`)
   - *Capability:* AST Code Indexing, memory graph building, function dependency lookup.
   - *Prompt Pattern:* "Index the Python files in /path/to/dir and build a function dependency graph."

2. **Scrapling** (`/data/external_repos/Scrapling`)
   - *Capability:* Anti-bot bypass, stealth web scraping, CSS/XPath extraction.
   - *Prompt Pattern:* "Scrape structured data from anti-bot URL X using Scrapling stealth scraper."

3. **daytona** (`/data/external_repos/daytona`)
   - *Capability:* Standardized development environment containers & sandboxes.
   - *Prompt Pattern:* "Provision an isolated dev environment container with Python 3.12 and Node.js 22."

4. **deer-flow** (`/data/external_repos/deer-flow`)
   - *Capability:* Multi-agent workflow execution DAGs and parallel consensus.
   - *Prompt Pattern:* "Execute a DeerFlow multi-agent pipeline to aggregate market intelligence on topic X."

5. **goose** (`/data/external_repos/goose`)
   - *Capability:* Open source CLI code & workflow agent.
   - *Prompt Pattern:* "Run Goose agent to refactor directory X following TDD red-green rules."

6. **dyad** (`/data/external_repos/dyad`)
   - *Capability:* Local open source AI web application builder.
   - *Prompt Pattern:* "Generate a full-stack local React + Tailwind web app using Dyad local AI builder."

7. **npxskillui** (`/data/external_repos/npxskillui`)
   - *Capability:* Reverse-engineers design systems into Claude-ready SKILL.md specs.
   - *Prompt Pattern:* "Reverse-engineer design tokens from URL X into a reusable SKILL.md design system."

8. **Scout** (`/data/external_repos/Scout`)
   - *Capability:* CRM lead scanner, tech stack keyword discovery.
   - *Prompt Pattern:* "Run Scout scanner on domain X to identify tech stack and contact info."

9. **career-ops** (`/data/external_repos/career-ops`)
   - *Capability:* Resume & cover letter AI optimizer, job application tracker.
   - *Prompt Pattern:* "Optimize resume and draft cover letter tailored for Job Description X."

10. **impeccable** (`/data/external_repos/impeccable`)
    - *Capability:* 59 deterministic rules for auditing AI-generated frontend UI.
    - *Prompt Pattern:* "Audit frontend UI in directory X against 59 design rules using `/impeccable init`."

11. **taste-skill** (`/data/external_repos/taste-skill`)
    - *Capability:* Anti-slop frontend framework for premium UI aesthetics.
    - *Prompt Pattern:* "Apply Taste-Skill anti-slop design framework to eliminate generic AI UI tropes."

12. **improve** (`/data/external_repos/improve`)
    - *Capability:* Codebase audit agent that generates actionable plan files in `plans/`.
    - *Prompt Pattern:* "Audit codebase X and output a step-by-step implementation plan in plans/001.md."

13. **extract-design-system** (`/data/external_repos/extract-design-system`)
    - *Capability:* Extracts design system tokens, CSS variables, and fonts from live websites.
    - *Prompt Pattern:* "Extract complete design system tokens from live URL X and save as Tailwind config."

14. **superpowers** (`/data/external_repos/superpowers`)
    - *Capability:* Composible skill suite for software development & TDD workflows.
    - *Prompt Pattern:* "Activate Superpowers TDD workflow: write failing unit test, code to pass, refactor."

15. **awesome-n8n-templates** (`/data/external_repos/awesome-n8n-templates`)
    - *Capability:* 280+ open-source n8n automation workflow templates.
    - *Prompt Pattern:* "Search 280+ n8n open-source templates for Telegram + OpenAI workflow and return JSON."

16. **Google-Maps-Scrapper** (`/data/external_repos/Google-Maps-Scrapper`)
    - *Capability:* Scrapes local business listings (name, phone, rating, website) from Google Maps.
    - *Prompt Pattern:* "Scrape local business leads for 'Chartered Accountants in Gurgaon' from Google Maps into CSV."

---

## 2. UI Component Skills Matrix (7 Target Resources)

1. **reactbits-dev** (`/data/skills/ui-components/reactbits-dev`)
   - *Capability:* 60+ Animated React components (AuroraBackground, ShinyButton, SplitText).
   - *Prompt Pattern:* "Build a hero card using ReactBits AuroraBackground and ShinyButton."

2. **refero-design** (`/data/skills/ui-components/refero-design`)
   - *Capability:* 10,000+ Real-world UI screenshot references for SaaS dashboards & pricing tables.
   - *Prompt Pattern:* "Design a pricing table component using Refero SaaS design reference patterns."

3. **aceternity-ui** (`/data/skills/ui-components/aceternity-ui`)
   - *Capability:* Copy-paste Tailwind CSS & Framer Motion blocks (BentoGrid, HoverEffect, Spotlight).
   - *Prompt Pattern:* "Create a Bento Grid layout for Project Anya using Aceternity UI style."

4. **21st-dev** (`/data/skills/ui-components/21st-dev`)
   - *Capability:* 12,000+ React & Tailwind component registry for shadcn/ui.
   - *Prompt Pattern:* "Build a command palette component following 21st.dev registry design."

5. **componentry-dev** (`/data/skills/ui-components/componentry-dev`)
   - *Capability:* Accessible, animated enterprise React UI primitives.
   - *Prompt Pattern:* "Build an accessible form container using Componentry layout primitives."

6. **toggle-supply** (`/data/skills/ui-components/toggle-supply`)
   - *Capability:* Hand-coded UI micro-interactions, spring sliders, and tactile switches.
   - *Prompt Pattern:* "Add a custom tactile toggle switch using Toggle Supply interaction patterns."

7. **motion-dev** (`/data/skills/ui-components/motion-dev`)
   - *Capability:* Framer Motion animation engine for layout morphing and gestures.
   - *Prompt Pattern:* "Animate this card list with Motion layout morphing on click."

---

## 3. Design Spec Integration (`design.md`)
- Extracted design rules from getdesign.md, designmd.supply, designmd.me, designmd.cc, and designmd.ai compiled into `/data/design.md`.
- Features dark slate container styling (`#0B0F17`), glassmorphism cards (`#151C28`), electric blue/emerald green highlights, and interactive capability toggles.

