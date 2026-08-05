# Pre-Configured Agentic Workflows & Multi-Phase Execution Pipelines

This reference provides production patterns for designing, orchestrating, and executing pre-configured agentic workflows that chain specialized AI agents together into automated end-to-end pipelines.

---

## 1. Core Workflow Pipeline Templates

### A. Full-Stack Product & Software Engineering SDLC
* **Goal:** Turn raw project ideas into documented, built, and verified software releases.
* **Pipeline Sequence:**
  1. **Phase 1: Requirements & Scope:** `product-product-manager` $\rightarrow$ Drafts structured PRD, user stories, and acceptance criteria.
  2. **Phase 2: System Architecture:** `engineering-software-architect` $\rightarrow$ Converts PRD into microservice architecture, DB schemas, and OpenAPI specs.
  3. **Phase 3: Code Implementation:** `engineering-backend-developer` $\rightarrow$ Writes production code and unit test coverage based on the design spec.
  4. **Phase 4: Quality Assurance:** `testing-embedded-qa-engineer` $\rightarrow$ Executes test suites, accessibility audits, and security checks.

### B. Growth Marketing & Multichannel Content Engine
* **Goal:** Automate market research, campaign copy generation, and platform-specific social formatting.
* **Pipeline Sequence:**
  1. **Phase 1: Market Strategy:** `marketing-growth-hacker` $\rightarrow$ Analyzes target demographics, positioning, and funnel channels.
  2. **Phase 2: Copywriting:** `marketing-copywriter` $\rightarrow$ Generates headline hooks, ad copy, and email campaign sequences.
  3. **Phase 3: Platform Formatting:** `marketing-xiaohongshu-specialist` (or platform equivalent) $\rightarrow$ Formats copy into viral post structures and visual tags.

### C. Enterprise Incident Response & Security Hardening
* **Goal:** Perform vulnerability audits, design containment playbooks, and apply infrastructure hardening.
* **Pipeline Sequence:**
  1. **Phase 1: Threat Audit:** `security-pentester` $\rightarrow$ Scans code and infrastructure for vulnerabilities and threat vectors.
  2. **Phase 2: Remediation Playbook:** `security-incident-responder` $\rightarrow$ Formulates step-by-step containment and fix strategies.
  3. **Phase 3: Patch Verification:** `support-infrastructure-maintainer` $\rightarrow$ Applies security patches, verifies service recovery, and updates logs.

---

## 2. Workflow Engine Architecture in Python

```python
class WorkflowStep(BaseModel):
    step_number: int
    name: str
    agent_id: str
    instruction_template: str

class WorkflowDefinition(BaseModel):
    id: str
    title: str
    category: str
    description: str
    steps: List[WorkflowStep]

class WorkflowEngine:
    def execute_workflow(self, workflow_id: str, input_goal: str) -> WorkflowExecutionResult:
        wf_def = self.workflows[workflow_id]
        accumulated_output = f"Global Goal: {input_goal}\n"

        for step in wf_def.steps:
            prompt = step.instruction_template.replace("{input_goal}", input_goal) + f"\n\nPrior Context:\n{accumulated_output}"
            exec_res = self.engine.run_agent_task(ExecutionTaskRequest(agent_id=step.agent_id, task_prompt=prompt))
            accumulated_output += f"\n\n--- [{step.name} by {step.agent_id}] ---\n" + exec_res.output_response

        return WorkflowExecutionResult(workflow_id=wf_def.id, final_deliverable_summary=accumulated_output, status="COMPLETED")
```

---

## 3. Public Zero-Interference Deployment Checklist

1. **Self-Contained Docker Environment:** Bundle FastAPI server, static dashboard SPA, and local sqlite DBs into a `docker-compose.yml`.
2. **Reverse Tunnel Exposure:** Use persistent background SSH tunnels (`localhost.run` or `pinggy.io`) to expose local ports over HTTPS instantly.
3. **Automated Testing:** Run `pytest` before public deployment to verify all agent registry paths, execution loops, and workflow routes return HTTP 200 / `COMPLETED`.
