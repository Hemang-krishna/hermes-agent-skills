---
name: master-prompt-skillset
description: Master Prompt Engineering Skillset & Frameworks for AI Agents, Tool-Calling, UI Design, Code Audits, and Workflow Orchestration.
category: software-development/prompt-engineering
---

# Master Prompt Engineering Skillset & Frameworks

## 🏛️ 1. Core Prompt Architecture Frameworks

### Framework A: Structural XML & Markdown Scaffolding
Always structure complex multi-step prompts using clean XML or Markdown blocks:
```xml
<context>
  High-level goal and background knowledge.
</context>

<constraints>
  Strict boundaries, zero-cost rules, non-interactive flags.
</constraints>

<instructions>
  Step-by-step numbered execution path.
</instructions>

<output_format>
  Pydantic JSON schema or Markdown specification.
</output_format>
```

### Framework B: ReAct (Reasoning + Action) & Chain-of-Thought
Enforce explicit reasoning before executing tool actions:
```
1. <thought> Analyze the user ask, identify required tool calls, check for errors. </thought>
2. Execute tool call.
3. Inspect output.
4. <thought> Did tool output satisfy objective? If error, reflect and self-correct. </thought>
5. Deliver verified result.
```

---

## 🎨 2. Frontend & UI Design Prompting Techniques

To avoid generic "AI slop" UI aesthetics and produce high-end interfaces:
1. **Design Token Injection:** Explicitly supply color hex codes (`#0B0F17`, `#151C28`), border styles (`border border-slate-800`), and typography families.
2. **Component Specification:** Instruct the model to use specific component architectures (e.g. Bento Grid, Aurora Background, Tactile Toggles, Glassmorphism).
3. **Deterministic Verification:** Audit outputs against 59 design rules (contrast ratios, padding alignment, mobile flex wraps).

---

## 💻 3. Code Audit & TDD Execution Prompting

When assigning coding or refactoring tasks:
1. **Plan Before Edits:** Require the agent to audit the codebase first and output a numbered implementation plan (`plans/001.md`).
2. **Red-Green-Refactor:** Force writing a failing unit test (`test_X.py`) BEFORE writing implementation code.
3. **Verification:** Never report a task complete until `pytest` or `unittest` returns exit code 0.

---

## 🕵️ 4. Data Extraction & Web Scraping Prompting

For web scraping and lead generation:
1. **Fallback Waterfalls:** Search API -> Direct Scrape -> Stealth Headless Browser (`Scrapling` / `browser-use`).
2. **Anti-Scam & Deduplication:** Filter out fake listings, hash unique records using `Title + Company + Location`, and output verified structured JSON.
