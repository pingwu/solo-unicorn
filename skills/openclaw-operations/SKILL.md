---
name: openclaw-operations
description: Authoritative knowledge for deploying, monitoring, troubleshooting, and maintaining production OpenClaw environments. Triggers on requests regarding background tasks (Cron, Heartbeats, Hooks, Standing Orders), Docker/ClawDock management, health probes, OTel/Prometheus observability, or channel diagnostics (Discord intents, routing, status probes).
---

# OpenClaw Operations Expert

## Core Principle
Docker-only deployment. Strictly avoid local machine binary installations. Treat channel integrations as code, prioritizing predictable restarts, stable persistence, and secrets hygiene through a security-first SRE lens.

## 1. Automation & Task Orchestration
OpenClaw utilizes five core background mechanisms. Use `docker compose exec openclaw-gateway openclaw tasks list` and `audit` to inspect detached work and execution history.

| Mechanism | Purpose | Characteristics |
| :--- | :--- | :--- |
| **Scheduled Tasks (Cron)** | Precise timing | Isolated executions for recurring time-based work. |
| **Heartbeats** | Batched routine checks | Routine system/agent checks every 30 minutes. |
| **Hooks** | Event-driven scripts | Triggered by lifecycle events (e.g., post-start, message-received). |
| **Standing Orders** | Persistent authority | Long-running operational mandates for agents. |
| **Task Flows** | Multi-step orchestration | Coordinated logic spanning multiple tools or agents. |

## 2. Deployment & Container Management
Deploy exclusively using Docker Compose. The `openclaw-gateway` is the primary entry point.

### Environment & Configuration
| Variable | Purpose |
| :--- | :--- |
| **`OPENCLAW_IMAGE`** | Specify remote image (e.g., `ghcr.io/openclaw/openclaw:latest`). |
| **`OPENCLAW_EXTENSIONS`** | Pre-install plugin dependencies at build time. |
| **`OPENCLAW_EXTRA_MOUNTS`** | Comma-separated `source:target` for extra host bind mounts. |
| **`OPENCLAW_SANDBOX`** | Set to `1` to opt-in to agent sandbox bootstrap. |
| **`OPENCLAW_DISABLE_BONJOUR`** | Set to `1` (default in Docker) to prevent bridge networking multicast issues. |
| **`OPENROUTER_API_KEY`** | LLM provider API key for Openrouter. Required for agent model inference. |
| **`OPENAI_API_KEY`** | LLM provider API key for OpenAI. Alternative to Openrouter. |

### Production-Ready Principles
- **Container Isolation:** Never install `openclaw` on the host. Build with 2GB+ RAM to avoid OOM errors.
- **Permissions:** The container runs as user `node` (**UID 1000**). Host folders must be owned by UID 1000: `sudo chown -R 1000:1000 config/`.
- **Host Connectivity:** Access host services (Ollama, LM Studio) via `http://host.docker.internal:<port>`.
- **Secrets Hygiene:** Use `.env` files mapped to `OPENCLAW_CONFIG_DIR`. Never bake keys into images.
- **LLM Configuration (Critical):** OpenClaw requires an LLM API key to function. Without a valid key, the container starts but health checks may fail or respond slowly. Pass `OPENROUTER_API_KEY` or `OPENAI_API_KEY` via environment variables at container startup. Load keys from `.env` files (e.g., `projects/openclaw-instance/.env`) and pass via `docker run -e` flags or Docker Compose `env_file:` directive. Example: `docker run -e OPENROUTER_API_KEY="sk-or-v1-..." ghcr.io/openclaw/openclaw:latest`. Verify successful configuration by checking logs for `[gateway] agent model:` line confirming the configured LLM provider.
- **Sandboxes:** Execute untrusted tool code in isolated **Docker Sandboxes**. Run `scripts/sandbox-setup.sh` to initialize.

### Tooling & Management
- **CLI Operations:** Use `docker compose run --rm openclaw-cli [command]` for one-off admin tasks (e.g., `channels login`, `devices approve`).
- **Gateway Access:** Use `docker compose exec openclaw-gateway ...` for inspecting running state.
- **Browser Tools:** If using Playwright, install browsers inside the container: `docker compose run --rm openclaw-cli node /app/node_modules/playwright-core/cli.js install chromium`.

## 3. Observability & Health Monitoring
Implement a **5-minute validation loop** after any deployment.

### Health Probes & Metrics
- **Liveness:** `GET http://127.0.0.1:18789/healthz` (Process status).
- **Readiness:** `GET /readyz` (Plugin/Channel initialization).
- **Deep Snapshot:** `docker compose exec openclaw-gateway node dist/index.js health --token "$OPENCLAW_GATEWAY_TOKEN"`.
- **Observability:** Use **OpenTelemetry** for tracing and **Prometheus** plugin for metrics.

### Validation Workflow
1. **Probe:** Confirm `/healthz` and `/readyz` return 200.
2. **Signal:** Send a test message via a configured channel.
3. **Execute:** Trigger a low-impact tool via an agent.
4. **Audit:** Verify Request IDs in the logs to confirm end-to-end flow.

## 4. Channel Troubleshooting & Diagnostics
Use `docker compose run --rm openclaw-cli channels status --probe` for connectivity checks.

### Discord Troubleshooting Path
- **Privileged Intents:** Enable **Message Content** and **Server Members** in Discord Developer Portal.
- **Policy Allowlists:** Verify the `allowlist` in group policies if the agent is unresponsive.
- **Timeouts:** Increase `read_timeout` in channel config if encountering listener timeouts.
- **Routing:** Configure DM policies and channel-to-guild routing for correct message delivery.

## Anti-Patterns

| Anti-Pattern | Why | Better Way |
| :--- | :--- | :--- |
| Local binary installation | Pollutes host, breaks reproducibility. | Always use Docker/Docker Compose. |
| Root ownership of volumes | Prevents the `node` user (UID 1000) from writing logs/config. | `chown -R 1000:1000` on host directories. |
| Using `localhost` for host apps | Refers to the container, not the host machine. | Use `host.docker.internal`. |
| Manual CLI config in prod | Not reproducible or auditable. | Use Hooks or Task Flows for post-start setup. |
| Running tools without Sandboxes | System compromise risk. | Always use isolated Docker Sandboxes for tool execution. |
| Missing LLM API key at startup | Container starts but health checks fail; no inference possible. | Load API key from `.env` file and pass via `docker run -e OPENROUTER_API_KEY="..."` or Docker Compose `env_file:`. Verify with logs check for `[gateway] agent model:`. |

## Power Move
"Audit my OpenClaw production deployment. Run a channel probe on 'Discord-Prod', verify the UID 1000 ownership of the config volume, and generate a Docker Compose override that enables a Playwright sandbox with Chromium pre-installed."
