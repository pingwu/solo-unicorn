# Setting Up Your Development Environment

> Phase 1 of your build journey: Get the project running locally with Docker.

## Why Containers?

Docker creates an isolated environment with Node.js and all dependencies. Your code runs the same way on any machine -- this is why companies use containers. No "works on my machine" issues.

## Prerequisites

Install these on your machine (the ONLY things you'll install):

| Tool | Purpose | Install |
|------|---------|---------|
| Docker Desktop | Runs containers | [docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop/) |
| Git | Version control | [git-scm.com](https://git-scm.com/) |
| AI Coding Agent | Your development partner | [Claude Code](https://docs.anthropic.com/en/docs/claude-code) or [Gemini CLI](https://github.com/google-gemini/gemini-cli) |

**Do NOT install:** Node.js, npm, Python, or any other development tools. Everything else runs inside the Docker container.

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

## Configure Your AI Agent (Optional but Recommended)

For Claude Code, allow Docker commands so it can execute inside containers:

**Tell Claude Code:**
```
"Allow docker and docker-compose commands permanently"
```

Or manually add to `~/.claude/settings.json`:
```json
{
  "permissions": {
    "allow": [
      "Bash(docker *)",
      "Bash(docker-compose *)",
      "Bash(npm run docker:*)"
    ]
  }
}
```

This tells Claude Code to automatically approve Docker-related commands, which is safe since all execution happens inside the isolated container.

## Verification Checklist

- [ ] Docker Desktop is running
- [ ] The landing page loads at [http://localhost:3000](http://localhost:3000)
- [ ] You can open a shell inside the container (`npm run docker:shell`)
- [ ] Your AI agent can run commands like "run the tests"

## Checkpoint

> Can you see the landing page at localhost:3000? If yes, you are ready to customize.

---

**Next:** [Customizing Your Landing Page with AI](customize.md)
