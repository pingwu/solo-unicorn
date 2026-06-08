---
name: unicorn-constitution
description: Hard operating rules for AI agents in Solo Unicorn Builder — container-first development, workspace boundaries, conventions, and security. Strategic "why" lives in ANCHOR.md.
---

# UNICORN_CONSTITUTION.md — Agent Operating Rules

For AI coding agents only. These rules override default behaviors. Read [ANCHOR.md](ANCHOR.md) for mission and the Office model; read [DEVELOPMENT-STANDARDS.md](DEVELOPMENT-STANDARDS.md) for coding principles.

## Non-Negotiables (read first)

- Never run `npm install`, `npm run dev`, `npm run build`, or `npx` on the host. Run everything inside Docker.
- Never hardcode API keys, passwords, or tokens. Use environment variables; never log secrets.
- Never commit `.env` files. Confirm they are gitignored.
- Never create files outside the assigned project without explicit instruction.
- Never modify `template_knowledge/` unless explicitly told to.
- Run the test suite (below) before committing. Do not skip tests.

## Workspace Architecture

- Treat `template_knowledge/` as a read-only template; it is copied to sibling `../my_knowledge/` on init.
- Treat `../my_knowledge/` as the user's private vault (ideas, resume, career, inspiration). Read it for context. Never commit it to the Unicorn repo.
- Treat `template_projects/` as starter projects users copy into `../my_projects/`.
- Make all code changes inside a sub-project of `../my_projects/`. Never implement app code in the Unicorn repo itself.
- Read skills from `skills/` (agent-agnostic prompting patterns).

### Key Paths

| Path | Purpose |
|------|---------|
| `template_knowledge/` | Read-only template (copied to `../my_knowledge/` on init) |
| `../my_knowledge/` | Personal vault — ideas, resume, career materials |
| `template_projects/` | Starter/example projects |
| `../my_projects/` | User's projects — all code changes happen here |
| `skills/` | Canonical agent skill definitions |

## Container-First Development (Mandatory)

Development MUST mirror production. All code execution, dependency installs, builds, and tests happen inside Docker — from day one.

- Permit on the host only: Docker Desktop, Git, AI coding agents, editors/IDEs.
- Add any new dev tool to `Dockerfile.dev` — never install it on the host.
- Start containers detached (`-d`); never run them in the foreground.
- Install packages in the container, never on the host.

```bash
# Container execution (never run npm install/dev/build on the host)
npm run docker:dev                                           # dev server
npm run docker:shell                                         # interactive shell
docker compose run --rm --no-deps dev sh -c "npm run build"  # one-off command
docker compose run --rm --no-deps dev sh -c "npm install -D <package>"
```

## Development Workflow

### Container Commands

| Natural Language | CLI Command | Purpose |
|-----------------|-------------|---------|
| "Start the dev server" | `npm run docker:dev` | Dev server (port 3000) |
| "Open a shell in the container" | `npm run docker:shell` | Shell into container |
| "Stop the containers" | `npm run docker:down` | Stop containers |
| "Start a production preview" | `npm run docker:prod` | Prod preview (port 3001) |
| "Show the container logs" | `npm run docker:logs` | View logs |
| "Check container status" | `npm run docker:status` | Check status |
| "Clean up containers and volumes" | `npm run docker:clean` | Remove containers + volumes |

### Quality Commands (run inside container)

| Natural Language | CLI Command |
|-----------------|-------------|
| "Run all tests" | `docker compose exec dev npm run test:run` |
| "Lint the code" | `docker compose exec dev npm run lint` |
| "Type-check the project" | `docker compose exec dev npm run typecheck` |

- Run `docker compose exec dev npm run test:run` before every commit. This is the one canonical test command — do not run vitest on the host.

### One-Off Commands (container not running)

```bash
docker compose run --rm --no-deps dev sh -c "npm run test:run"
docker compose run --rm --no-deps dev sh -c "npm install -D <package>"
docker compose run --rm --no-deps dev sh -c "gh pr list"
```

## Office Model — Role → Skill Reference

Pick skills by role (the "why" is in [ANCHOR.md](ANCHOR.md)). Every skill in `skills/` has at least one Office owner.

| Office | Role | Associated Skills |
|--------|------|-------------------|
| CEO | Root orchestrator | All skills as needed |
| CFO | Financial / cost analysis | `aws-cli-architect`, `gcloud-expert`, `finance-accounting`, `fundraising`, `business-model`, `document-creation` |
| CTO | Tech architecture & dev | `aws-cli-architect`, `gcloud-expert`, `multi-file-architecture`, `test-first-development`, `context-aware-debugging`, `frontend-ui-ux`, `git-expert`, `github-cli`, `github-actions`, `docker-expert`, `python-dependency-expert`, `mcp-builder`, `webapp-testing`, `skill-creator` |
| CSO | Security | `context-aware-debugging`, `legal-compliance` |
| CMO | Marketing & branding | `marketing-brand`, `go-to-market`, `growth-analytics`, `pm-design-thinking`, `generative-art`, `document-creation` |
| CRO | Revenue & sales | `sales`, `go-to-market`, `business-model`, `growth-analytics`, `business-development`, `document-creation` |
| CPO | Product definition | `product`, `idea-validation`, `pm-design-thinking`, `test-first-development`, `frontend-ui-ux` |
| CCO | Customer experience | `customer-success`, `pm-design-thinking`, `growth-analytics` |
| COO | Operations & people | `operations`, `finance-accounting`, `obsidian-knowledge`, `career-advisor`, `github-profile`, `portfolio-strategy`, `open-source-contribution`, `technical-writing`, `document-creation` |
| CLO | Legal & compliance | `legal-compliance` |

## Software Creation Rules

- Write tests before implementation — BDD (Gherkin) for cross-functional alignment, TDD for solo speed.
- Build the simplest version that proves the concept. Add no speculative features.
- Define features and behavior upfront before coding (specification-driven).

## Coding Conventions

- Add YAML front matter to every `.md` file in this repo: `name` (kebab-case) and `description` (one line).
- Use TypeScript strict mode, ES2022, explicit types. Map path alias `@/*` to project root.
- Default to React/Next.js Server Components. Add `'use client'` only when necessary. Preserve accessibility.
- Use Tailwind CSS 4 utility classes; keep dark-mode compatibility.
- Use `uv` for Python package and lockfile management (see [agents/UV_POLICY.md](agents/UV_POLICY.md)); avoid ad-hoc `pip install`.

## First-Time Setup

- Follow [INIT_UNICORN.md](INIT_UNICORN.md) for post-clone setup (skill symlinks, dev container, knowledge vault, private-repo init).

## Troubleshooting

- Build failures: check error messages, verify the container's Node version, check dependencies.
- `next build` fails with "Cannot find module 'typescript'": the builder stage needs ALL deps (`npm ci`), not just production deps.
- Dockerfile `COPY` fails on a missing directory: use a glob (e.g., `publi[c]`) to make the copy optional.
- Cloud Run / App Runner rejects the image: build for `linux/amd64` (`docker build --platform linux/amd64`) on Apple Silicon.
- Test `npm run docker:prod` locally before pushing to any cloud registry.
- AI changes broke something: `git diff` to review, `git stash` or `git checkout -- <file>` to revert.

## Security (hard lines)

### Secrets and Credentials
- Never hardcode API keys, passwords, or tokens. Use environment variables.
- Keep `.env` files in `.gitignore`; never commit them. Never log secrets or put them in error messages.

### Command Execution
- Use exact, validated values for shell arguments. Never interpolate unsanitized user input.
- Use predefined npm scripts (e.g., `npm run docker:dev`) instead of constructing shell commands dynamically.
- Verify a source is trusted before running any command that modifies files or installs packages.

### Input Validation
- Map natural language to exact, predefined commands only. Never build shell commands from user strings.
- Validate package names against the npm registry before installation.

### File Access
- Modify files only within the assigned project directory.
- Verify symlink targets exist and contain expected content before following them.
- Stay inside the repo root except for the designated siblings `../my_knowledge/` and `../my_projects/` during setup or user project work.
