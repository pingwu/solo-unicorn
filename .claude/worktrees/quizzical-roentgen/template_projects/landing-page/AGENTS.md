---
name: landing-page-agents
description: Agent instructions for the landing page template project. Tech stack, container commands, code conventions, and constraints.
---

# AGENTS.md — Agentic Landing Template

Agent instructions for this project. For Solo Unicorn Builder's master constitution, see [../../UNICORN_CONSTITUTION.md](../../UNICORN_CONSTITUTION.md).

## Project Goals

This project is a Next.js landing page template. Maintain accessibility, test coverage, and container-first workflow.

## Tech Stack

| Technology | Version | Purpose |
|------------|---------|---------|
| Next.js | 16 | React framework (App Router, standalone output) |
| React | 19 | UI components (Server Components by default) |
| TypeScript | 5.9 | Type safety (strict mode, ES2022) |
| Tailwind CSS | 4 | Utility-first styling (dark mode) |
| Vitest | 4 | Unit and component testing |
| Docker | — | Dev container with all tools |

## Command Execution (Critical)

**All commands MUST run inside the container, never on the host.**

When asked to run any command (npm, npx, node, tests, builds), use this pattern:

```bash
docker compose exec dev <command>
```

| User says | You execute |
|-----------|-------------|
| "run the tests" | `docker compose exec dev npm run test:run` |
| "install lodash" | `docker compose exec dev npm install lodash` |
| "build the project" | `docker compose exec dev npm run build` |
| "lint the code" | `docker compose exec dev npm run lint` |
| "check types" | `docker compose exec dev npm run typecheck` |

**Never run directly:** `npm install`, `npm test`, `npx`, `node` — these would execute on the host.

## Container Lifecycle

| Natural Language | CLI Command | Purpose |
|-----------------|-------------|---------|
| "Start the dev container" | `npm run docker:dev` | Start container + dev server (port 3000) |
| "Stop the containers" | `npm run docker:down` | Stop containers |
| "Show container status" | `npm run docker:status` | Check if running |
| "View container logs" | `npm run docker:logs` | Stream logs |
| "Start production preview" | `npm run docker:prod` | Production build (port 3001) |

## Code Conventions

- **TypeScript**: Strict mode, path alias `@/*` → project root. Explicit types.
- **React/Next.js**: Server Components by default. `'use client'` only for interactivity.
- **Tailwind CSS**: Utility classes, always include `dark:` variants.
- **Accessibility**: Preserve ARIA attributes, semantic HTML, skip links, focus states.
- **Testing**: Tests live in `__tests__/`. Use `@testing-library/react` queries (role, label, text).
- **Docker**: Always detached mode (`-d`). Never install packages on the host.

## Key Files

| File | Purpose |
|------|---------|
| `app/page.tsx` | Main landing page content |
| `app/layout.tsx` | Root layout, metadata, fonts |
| `components/` | Reusable UI (Icons, MobileNav) |
| `templates/` | Alternative page templates (services, portfolio, resume, enterprise) |
| `__tests__/` | Component and page tests |
| `Dockerfile.dev` | Dev container (Node 20, gh, aws, gcloud, az) |
| `docker-compose.yml` | Container orchestration |
| `docs/reference/` | Tech stack, AWS glossary, AWS pricing guide, GCP glossary, GCP pricing guide |
| `docs/guides/` | Deployment roadmap, AWS deployment guide, GCP deployment guide, GCP deployment roadmap |
| `docs/prompts/` | Prompt library, content templates |
| `docs/product/` | PRD, PRD templates |

## Constraints

### Do Not
- Run `npm install`, `npm run dev`, `npm run build`, `npx`, or any Node.js execution on the host. All code runs inside Docker containers. See [../../UNICORN_CONSTITUTION.md §9](../../UNICORN_CONSTITUTION.md) for the full container-first policy.
- Remove accessibility attributes from HTML.
- Run blocking container commands (always use `-d` or npm scripts).
- Delete TypeScript types without replacement.

### Always
- Run quality checks inside the container (`test:run`, `lint`, `typecheck`).
- Preserve mobile responsiveness.
- Test changes before committing.
- Use `skills/` (not `.skills/`) when referencing agent skills.

