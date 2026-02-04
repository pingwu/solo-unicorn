# CLAUDE.md

Claude Code system prompt for the Unicorn Project root.

Read **`AGENTS.md`** for the master constitution: vision, Office structure, getting started, development conventions, and skills reference.

## Setup After Cloning

See **AGENTS.md §4** for the full post-clone workflow (symlink skills, start dev container). All dev tools live inside the template container — never install on the host.

## Quick Reference — Agentic Landing Template

Project location: `projects/agentic-landing-template/`

```bash
# Container lifecycle
npm run docker:dev          # Start dev container (port 3000)
npm run docker:shell        # Shell into running container
npm run docker:down         # Stop containers

# Quality (run inside container)
npm run test:run            # Vitest single run
npm run lint                # ESLint
npm run typecheck           # TypeScript strict mode

# One-off container commands
docker compose run --rm --no-deps dev sh -c "<command>"
```

### Code Conventions

- **TypeScript**: Strict mode, ES2022, path alias `@/*` → project root.
- **React/Next.js**: Server Components by default. `'use client'` only when needed.
- **Tailwind CSS 4**: Utility classes, dark mode compatible.
- **Docker**: Always detached mode (`-d`). Node 20 Alpine, non-root user.
