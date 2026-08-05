# Agent OS API Routes & Architecture Reference

## Complete 138 API Routes

```
ADMIN & AUTHENTICATION
  GET  /api/admin/session
  POST /api/admin/login
  POST /api/admin/logout
  GET  /api/execution-gate
  POST /api/admin/execution-gate

KERNEL & HEALTH
  GET  /api/health
  GET  /api/os/status
  GET  /api/os/foundation
  GET  /api/os/kernel
  GET  /api/os/readiness
  GET  /api/os/audit

SETUP WIZARD & PROVIDERS
  GET  /api/setup
  POST /api/setup
  POST /api/setup/start-first-workflow
  GET  /api/setup/providers
  POST /api/setup/providers/:id/configure
  POST /api/setup/providers/:id/test
  GET  /api/setup/providers/ollama/doctor
  GET  /api/setup/providers/:id/models
  POST /api/setup/providers/:id/pull-model

PROVIDER ROUTER
  GET  /api/router/status
  GET  /api/router
  POST /api/router/configure
  POST /api/router/run
  GET  /api/router/health

USAGE & BILLING RECONCILIATION
  GET  /api/usage
  POST /api/usage/budget
  POST /api/usage/record
  POST /api/usage/import/preview
  POST /api/usage/import
  GET  /api/usage/reconciliation
  POST /api/usage/reconciliation/run

SCHEDULER & CRON
  GET  /api/scheduler
  POST /api/scheduler/jobs
  GET  /api/scheduler/jobs/:id
  PUT  /api/scheduler/jobs/:id
  POST /api/scheduler/jobs/:id/pause
  POST /api/scheduler/jobs/:id/resume
  POST /api/scheduler/jobs/:id/approve
  POST /api/scheduler/jobs/:id/reject
  POST /api/scheduler/jobs/:id/run
  GET  /api/scheduler/jobs/:id/history
  POST /api/scheduler/tick

HYBRID MEMORY & VECTOR STORE
  GET  /api/memory
  POST /api/memory/items
  PATCH /api/memory/items/:id
  GET  /api/memory/search
  POST /api/memory/vector/config
  POST /api/memory/vector/rebuild
  POST /api/memory/import
  POST /api/memory/export

SIGNED SKILL REGISTRY & MARKETPLACE
  GET  /api/skills
  POST /api/skills/import
  GET  /api/skills/marketplace
  POST /api/skills/marketplace/feeds
  POST /api/skills/marketplace/feeds/:id/fetch
  POST /api/skills/marketplace/feeds/:feedId/import/:skillId
  GET  /api/skills/publishers
  POST /api/skills/publishers/policy
  POST /api/skills/publishers/:fingerprint/reputation
  POST /api/skills/publishers/:fingerprint/allow
  POST /api/skills/publishers/:fingerprint/allow/remove
  POST /api/skills/publishers/:fingerprint/block
  POST /api/skills/publishers/:fingerprint/block/remove
  POST /api/skills/trust/:fingerprint
  POST /api/skills/trust/:fingerprint/remove
  GET  /api/skills/:id
  POST /api/skills/:id/install
  POST /api/skills/:id/dependencies/prepare
  POST /api/skills/:id/configure
  POST /api/skills/:id/update
  POST /api/skills/:id/enable
  POST /api/skills/:id/disable
  POST /api/skills/:id/uninstall
  POST /api/skills/:id/test
  GET  /api/skills/:id/logs

AGENT MODULES & RUNTIMES
  GET  /api/modules
  GET  /api/modules/:id
  POST /api/modules/:id/test
  POST /api/modules/:id/run
  GET  /api/modules/:id/logs
  GET  /api/modules/:id/runs
  GET  /api/agent-runs
  GET  /api/modules/:id/sessions
  POST /api/modules/:id/sessions
  GET  /api/modules/:id/sessions/:sessionId
  POST /api/modules/:id/sessions/:sessionId/stop
  POST /api/modules/:id/sessions/:sessionId/messages
  GET  /api/installers
  POST /api/modules/:id/install

SELF MODULES (Goals, SEO, Video)
  GET  /api/self/:id
  POST /api/self/:id/items
  POST /api/self/goals/:goalId/loop
  POST /api/self/seo/:briefId/audit
  POST /api/self/seo/:briefId/discover
  POST /api/self/seo/:briefId/rank
  GET  /api/self/video/worker
  POST /api/self/video/:jobId/run
  POST /api/self/video/:jobId/queue
  GET  /api/self/video/runs/:runId
  POST /api/self/video/runs/:runId/cancel
  GET  /api/self/video/runs/:runId/download/:fileName

CONNECTIONS & CODEX INTELLIGENCE
  GET  /api/connections
  POST /api/connections/:id/configure
  POST /api/connections/:id/test
  GET  /api/agent-os/codex/status
  POST /api/agent-os/codex/test
  POST /api/agent-os/codex/preview
  GET  /api/agent-os/api-integrations
  POST /api/agent-os/api-integrations/:id/configure
  POST /api/agent-os/api-integrations/:id/test

VISUAL WORKFLOW GRAPH ENGINE
  GET  /api/workflows
  POST /api/workflows
  POST /api/agent-os/workflows/generate
  POST /api/agent-os/workflows/refine
  GET  /api/workflows/:id
  PUT  /api/workflows/:id
  DELETE /api/workflows/:id
  POST /api/workflows/:id/run
  GET  /api/workflows/:id/runs/:runId
  GET  /api/workflows/:id/runs/:runId/events
  GET  /api/workflows/:id/runs/:runId/replay
  POST /api/workflows/:id/runs/:runId/resume

BUILDER SUPERVISOR & EXPORT
  POST /api/admin/export/prepare
  GET  /api/builder/status
  GET  /api/builder/bootstrap
  POST /api/builder/bootstrap/prepare
  POST /api/builder/smoke-test
  POST /api/builder/start
  POST /api/builder/stop
  GET  /api/builder/logs
  GET  /api/builder/replay-overlay
  GET  /api/integrations
  GET  /api/connections/templates
  POST /api/integrations/:id/test
  POST /api/agents/:id/message
```
