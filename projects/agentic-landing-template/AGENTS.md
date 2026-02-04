# AGENTS.md — Agentic Landing Template

Agent instructions for this project. For the Unicorn organization's master constitution, see [../../AGENTS.md](../../AGENTS.md).

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

## Container Commands

All development happens inside the container. See [../../AGENTS.md §4.2](../../AGENTS.md) for setup.

| Natural Language | CLI Command | Purpose |
|-----------------|-------------|---------|
| "Start the dev container" | `npm run docker:dev` | Dev server (port 3000) |
| "Open a shell in the container" | `npm run docker:shell` | Shell into running container |
| "Stop the containers" | `npm run docker:down` | Stop containers |
| "Run the tests" | `npm run test:run` | Vitest single run |
| "Lint the code" | `npm run lint` | ESLint |
| "Type-check the project" | `npm run typecheck` | TypeScript check |
| "Start a production preview" | `npm run docker:prod` | Production preview (port 3001) |

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
- Run `npm install`, `npm run dev`, `npm run build`, `npx`, or any Node.js execution on the host. All code runs inside Docker containers. See [../../AGENTS.md §9](../../AGENTS.md) for the full container-first policy.
- Remove accessibility attributes from HTML.
- Run blocking container commands (always use `-d` or npm scripts).
- Delete TypeScript types without replacement.

### Always
- Run quality checks inside the container (`test:run`, `lint`, `typecheck`).
- Preserve mobile responsiveness.
- Test changes before committing.
- Use `skills/` (not `.skills/`) when referencing agent skills.

## Files That Delegate Here

- `CLAUDE.md` — For Claude Code
- `GEMINI.md` — For Gemini CLI
- `AGENT.md` — For other AI coding assistants
