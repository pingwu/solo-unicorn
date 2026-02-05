# CLAUDE.md

Claude Code system prompt for the Unicorn Project root.

Read **`AGENTS.md`** for the master constitution: vision, Office structure, getting started, development conventions, and skills reference.

## Command Execution (Critical)

**All commands MUST run inside the container, never on the host.**

```bash
# CORRECT — runs inside container
docker compose exec dev npm run test:run
docker compose exec dev npm install lodash

# WRONG — runs on host (forbidden)
npm install
npm test
```

When asked to run tests, install packages, build, lint, or any Node.js command, always prefix with `docker compose exec dev`.

## Setup After Cloning

See **AGENTS.md §4** for the full post-clone workflow (symlink skills, start dev container). All dev tools live inside the template container — never install on the host.

## Quick Reference — Agentic Landing Template

Project location: `projects/agentic-landing-template/`

```bash
# Container lifecycle
npm run docker:dev          # Start dev container (port 3000)
npm run docker:down         # Stop containers
npm run docker:status       # Check if running

# Execute commands inside container
docker compose exec dev npm run test:run
docker compose exec dev npm run lint
docker compose exec dev npm run typecheck
docker compose exec dev npm run build
```

### Code Conventions

- **TypeScript**: Strict mode, ES2022, path alias `@/*` → project root.
- **React/Next.js**: Server Components by default. `'use client'` only when needed.
- **Tailwind CSS 4**: Utility classes, dark mode compatible.
- **Docker**: Always detached mode (`-d`). Node 20 Alpine, non-root user.
