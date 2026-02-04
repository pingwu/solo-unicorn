# Setting Up Your Development Environment

> Phase 1 of your build journey: Get the project running locally with Docker.

## Why Containers?

Docker creates an isolated environment with Node.js and all dependencies. Your code runs the same way on any machine -- this is why companies use containers. No "works on my machine" issues.

## Prerequisites

- Docker Desktop installed and running
- A terminal (Terminal on macOS, PowerShell on Windows)
- A code editor (VS Code, Cursor, or similar)

## Start the Dev Server

**Tell your AI agent:**
```
"Start the dev container for the agentic-landing-template project and verify it loads at localhost:3000"
```

**CLI Reference:**
```bash
cd projects/agentic-landing-template
npm run docker:dev
```

Open [http://localhost:3000](http://localhost:3000) in your browser.

**What just happened?** Docker built an image with Node.js 20, installed all dependencies, and started the Next.js development server. Your project files are volume-mounted into the container, so edits on your machine are reflected instantly.

## Key Container Commands

| Natural Language | CLI Command | What It Does |
|-----------------|-------------|--------------|
| "Start the dev container" | `npm run docker:dev` | Start the dev container (port 3000) |
| "Open a shell in the container" | `npm run docker:shell` | Open a shell inside the running container |
| "Stop the container" | `npm run docker:down` | Stop the container |
| "Show the container logs" | `npm run docker:logs` | View container logs |
| "Check if the container is running" | `npm run docker:status` | Check container status |
| "Clean up containers and volumes" | `npm run docker:clean` | Remove containers and volumes |

## Running Commands Inside the Container

All dev tools live inside the container. Never install Node, npm, or packages directly on your host machine.

**Tell your AI agent:**
```
"Run all tests inside the container"
"Lint the code inside the container"
"Type-check the project inside the container"
```

**CLI Reference:**
```bash
# Interactive shell
npm run docker:shell

# One-off commands
docker compose run --rm --no-deps dev sh -c "npx vitest run"
docker compose run --rm --no-deps dev sh -c "npm run lint"
docker compose run --rm --no-deps dev sh -c "npx tsc --noEmit"
```

## Verification Checklist

- [ ] The landing page loads at [http://localhost:3000](http://localhost:3000)
- [ ] You can open a shell inside the container
- [ ] All tests pass inside the container

## Checkpoint

> Can you see the landing page at localhost:3000? If yes, you are ready to customize.

---

**Next:** [Customizing Your Landing Page with AI](customize.md)
