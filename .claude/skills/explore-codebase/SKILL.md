---
name: explore-codebase
description: Explore an unfamiliar codebase with parallel agents and produce an onboarding report (markdown + polished HTML with diagrams and screenshots). Use when the user wants to understand, onboard onto, or map a new repo, or invokes /explore-codebase. Optional args select clusters (devloop, interfaces, architecture, domain, deploy, history) and flags (--screenshots, --update).
---

# Explore Codebase

Map an unfamiliar repo by fanning out read-only `Explore` agents, one per question cluster, then synthesize into an onboarding report.

## Arguments

- No cluster args → run all six clusters.
- Cluster names (e.g. `/explore-codebase domain deploy`) → run only those, and merge into the existing report.
- `--screenshots` → run Phase 3 (starts the app; ask before running anything that installs or boots services).
- `--update` → read the existing report first and tell each agent what is already known, asking it to confirm, correct, or extend.

## Output Location

`~/r/notes/dev/redmond/codebases/<repo-name>/`

```
<repo-name>/
  report.md          # source of truth
  report.html        # rendered, self-contained report
  screenshots/       # PNGs referenced by both
```

`<repo-name>` is the basename of the repo root. Create the directory if missing. Never write into the explored repo.

---

## Phase 1 — Recon (main agent)

Keep this to a handful of calls. Gather:

- Languages, frameworks, package managers, build system
- Single app vs monorepo (list packages/services if mono)
- Top-level directory layout (one line per dir)
- Existing docs: README, CLAUDE.md, `docs/`, ADRs, CONTRIBUTING
- `largest-files` output (top 15)
- Recent activity: `git log --oneline -20`, and `git log --format='%an' | sort | uniq -c | sort -rn | head` for top authors

Write a short **Recon Brief** (≤30 lines). It is pasted verbatim into every agent prompt.

## Phase 2 — Fan-out

Launch the selected clusters as `Explore` agents in a **single message** so they run in parallel. Each prompt contains: the Recon Brief, the repo path, the cluster's questions, and the Report Format below. Tell each agent to be "very thorough" and to stay inside its cluster.

### Clusters

**devloop — Running & testing**
- How do I install dependencies and set up a local environment?
- What env vars, secrets, or local services (DB, queue, cache) are required? Is there a docker-compose or devcontainer?
- How do I run the app locally? What URL/port does it serve on?
- How do I run unit, integration, and e2e tests? Which test frameworks?
- What lint, format, and typecheck commands exist?
- What does CI enforce before merge?

**interfaces — Endpoints & integrations**
- What inbound endpoints exist (HTTP routes, GraphQL, gRPC)? List method, path, handler `file:line`.
- What else triggers code: queue consumers, cron/scheduled jobs, webhooks, CLI commands, event listeners?
- If there is a frontend: what are its routes/pages?
- What outbound calls are made: internal services, third-party APIs, SDKs? Where are clients configured?
- How do authentication and authorization work?

**architecture — Foundational pieces**
- What are the entry points (main, server bootstrap, app factory)?
- Trace one representative request end to end through the layers.
- What are the key abstractions, base classes, shared modules, and DI/wiring?
- Which modules would break the most if changed (most imported, most central)?
- What patterns and conventions does the code follow (naming, layering, error handling)?

**domain — Business logic & data flow**
- What business problem does this solve and for whom?
- Build a glossary: domain terms in the code and what they mean. Flag terms that look like synonyms (`Account` vs `Tenant` vs `Org`).
- What are the core entities and their relationships? What data stores and schemas hold them? How are migrations done?
- Trace the 2–3 most important data flows: where data enters, how it is transformed/validated, where it is persisted, where it leaves.
- Where does the core business logic live (rules, calculations, state machines, workflows)? Which entities have lifecycles/statuses?
- What invariants does the code enforce?

**deploy — Deployment & operations**
- What CI/CD pipeline builds and ships this? What triggers a deploy?
- What environments exist and how do they differ?
- What infra-as-code, containers, or platform config exists (Terraform, Helm, k8s, serverless)?
- How is config managed per environment? Feature flags?
- What logging, metrics, tracing, and alerting exist?
- How is a deploy rolled back?

**history — Ownership & risk**
- Which files churn the most? (`git log --format= --name-only | sort | uniq -c | sort -rn | head -30`)
- Who owns what? (CODEOWNERS, top authors per top-level dir)
- How mature and active is it? Any signs of migration in progress (two ways of doing the same thing)?
- Where are the dragons: TODO/FIXME/HACK clusters, skipped tests, deprecated paths, very large files, untested core logic?
- What appears dead or abandoned?

### Report Format (include in every agent prompt)

```
## Summary
3–5 bullets a new engineer needs first.

## Findings
- <finding> — `path/to/file:line` — [confirmed | inferred]

## Diagram
One Mermaid diagram fitting the cluster (graph, sequenceDiagram, erDiagram, or stateDiagram-v2). Omit if nothing meaningful.

## Open Questions
Things the code cannot answer, phrased as a question to ask a teammate.
```

Agents are read-only: they find commands, they do not run builds, tests, or the app.

## Phase 3 — Screenshots (only with `--screenshots`)

1. From the devloop findings, show the user the exact commands needed to start the app and **ask before running them**.
2. Start the app in the background. Wait for the port to respond.
3. Choose 3–8 pages from the interfaces cluster's frontend routes (landing, main workflow, a detail view, an admin/settings page).
4. Capture each: `npx playwright screenshot --full-page --viewport-size=1440,900 <url> ~/r/notes/dev/redmond/codebases/<repo-name>/screenshots/<slug>.png`
5. Pages behind login: use the `claude-in-chrome` skill in the user's session instead, or skip and list them under Open Questions.
6. For API-only services, skip UI screenshots; note it in the report.
7. Stop the app.

## Phase 4 — Synthesis

### report.md

```
# <repo-name>
_Explored <YYYY-MM-DD> · commit <short-sha>_

## TL;DR
5–7 bullets: what it is, how to run it, where the core logic lives, biggest risk.

## Quick Start
Copy-pasteable commands: install, run, test, lint.

## Domain
Glossary table, entity diagram, key data flows, where business logic lives.

## Architecture
Entry points, request lifecycle diagram, foundational modules.

## Interfaces
Endpoint table (method, path, handler), triggers, outbound dependencies diagram, auth.

## Deployment & Ops
Pipeline diagram, environments, config, observability, rollback.

## Ownership & Risk
Owners, hot spots, dragons, dead code.

## Screenshots
Each image with a one-line caption.

## Ask a Teammate
Deduplicated open questions from every agent, grouped by cluster.
```

Resolve conflicts between agents by checking the cited code yourself. Drop findings without a citation unless marked inferred.

### report.html

A single self-contained page rendered from report.md content:

- Sticky sidebar nav linking each section; TL;DR card at top.
- Mermaid diagrams rendered via `https://cdn.jsdelivr.net/npm/mermaid@10.9.1/dist/mermaid.min.js`.
- Endpoint and glossary tables styled, with sortable headers optional.
- Screenshots in a grid with captions, click to enlarge; referenced by relative path `screenshots/<slug>.png`.
- `file:line` citations in monospace.
- Light and dark mode via `prefers-color-scheme`, CSS variables for colors.
- Readable at laptop width; no external CSS frameworks.

Open it with `xdg-open ~/r/notes/dev/redmond/codebases/<repo-name>/report.html`.

Do not publish the report as a claude.ai Artifact unless the user asks: it describes employer code.

## Done Checklist

- [ ] Recon Brief written
- [ ] All selected clusters returned reports
- [ ] Screenshots captured (if `--screenshots`)
- [ ] report.md and report.html written to `~/r/notes/dev/redmond/codebases/<repo-name>/`
- [ ] "Ask a Teammate" list shown to the user in the final reply
