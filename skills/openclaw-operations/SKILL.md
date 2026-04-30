---
name: openclaw-operations
description: Authoritative knowledge for deploying, monitoring, troubleshooting, and maintaining production OpenClaw environments. Triggers on requests regarding OpenClaw container setup (claw1, claw2, etc.), Docker/docker-compose management, gateway startup issues, plugin lock problems, health probes, model configuration, auth tokens, channel diagnostics (Discord, Telegram, WhatsApp, Slack), background tasks (Cron, Heartbeats, Hooks, Standing Orders), OTel/Prometheus observability, or control UI login issues.
---

# OpenClaw Operations Expert

## Core Principle
Docker-only deployment. Strictly avoid local machine binary installations. Treat channel integrations as code, prioritizing predictable restarts, stable persistence, and secrets hygiene through a security-first SRE lens.

## Assumptions This Skill Bakes In
The examples below pick concrete defaults so they can be copy-pasted. Before deviating, read [`references/host-and-defaults.md`](references/host-and-defaults.md) for the rationale and how to swap them:
- **Default model:** `moonshotai/kimi-k2.5` (262k ctx, reasoning, text+image; routed via OpenRouter)
- **Provider:** OpenRouter (`OPENROUTER_API_KEY=sk-or-v1-...`)
- **Host:** Windows + WSL2 + Docker Desktop (so `start_period: 300s`, slow first-boot npm install, host-side healthcheck flakiness on this path)
- **Topology:** single-instance per host port `18789`; bring others down before starting a new one
- **State:** project-local `./.openclaw/` is the single source of truth — back up before destroying
- **Image tag:** rolling `ghcr.io/openclaw/openclaw:latest` — pin a version for production

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

### New Instance Scaffold
To create a new named instance (e.g. `claw2`), stamp out these files under `my_projects/<name>/`:

**`docker-compose.yml`**
```yaml
services:
  openclaw-gateway:
    image: ghcr.io/openclaw/openclaw:latest
    container_name: <name>
    restart: unless-stopped
    env_file:
      - .env
    environment:
      - OPENCLAW_DISABLE_BONJOUR=1
    volumes:
      - ./.openclaw:/home/node/.openclaw
      - openclaw-plugin-runtime-deps:/var/lib/openclaw/plugin-runtime-deps
    ports:
      - "18789:18789"
    healthcheck:
      test: ["CMD", "wget", "-qO-", "http://127.0.0.1:18789/healthz"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 300s   # gateway takes 3-5 min to reach ready; 30s causes premature unhealthy

  openclaw-cli:
    image: ghcr.io/openclaw/openclaw:latest
    container_name: <name>-cli
    network_mode: "service:openclaw-gateway"
    env_file:
      - .env
    environment:
      - OPENCLAW_DISABLE_BONJOUR=1
    volumes:
      - ./.openclaw:/home/node/.openclaw
      - openclaw-plugin-runtime-deps:/var/lib/openclaw/plugin-runtime-deps
    entrypoint: ["openclaw"]
    profiles:
      - cli

volumes:
  openclaw-plugin-runtime-deps:
```

**`.env`** — minimal working config
```bash
OPENROUTER_API_KEY=sk-or-v1-...
OPENCLAW_SKIP_ONBOARDING=1
# DO NOT set OPENCLAW_GATEWAY_TOKEN here — causes auth deadlock at startup.
# DO NOT set OPENCLAW_GATEWAY_BIND here — causes gateway to hang at "starting...".
# After first boot, read token from: .openclaw/openclaw.json → gateway.auth.token
```

**`.openclaw/openclaw.json`** — do NOT pre-seed. The gateway rewrites this file on every startup. The only durable use is reading `gateway.auth.token` after first boot.

**`.gitignore`**
```
.env
.openclaw/
```

**Bring up:**
```bash
mkdir -p .openclaw && docker compose up -d
# Wait for: docker compose logs -f | grep "ready"
# Then read token:
python -c "import json; d=json.load(open('.openclaw/openclaw.json')); print(d['gateway']['auth']['token'])"
```

### Startup Sequence & Timing
First boot stages bundled npm runtime deps and is silent during the install. Duration depends on host disk and npm cache state.

```
loading configuration…        (~0s)
resolving authentication…     (~0s)
starting...                   (~0s)
[plugins] staging bundled runtime deps...   (≈20s on warm Docker / SSD; up to several minutes on cold cache or slow network)
starting HTTP server...        (ready to serve)
agent model: <provider/model>
ready (N plugins; Xs)
```

Subsequent restarts skip the install and reach `ready` in ~2–5s. If the gateway has been silent for >5 min with no progress, suspect a stale plugin-runtime lock (see §3) before assuming it is still installing.

**Login rule:** wait for `[gateway] ready` before opening the control UI. The supervisor (PID 1) serves the login page immediately, but the WebSocket handler doesn't exist until after `ready` — opening early gives `1006 disconnected`.

**Origin rule (since v2026.2.26):** when `bind=auto`, the gateway seeds `gateway.controlUi.allowedOrigins` with `http://localhost:18789` and `http://127.0.0.1:18789`. Opening the control UI on any other origin (e.g. a host-mapped non-default port like `localhost:18889`, or a LAN IP) returns `1008 origin not allowed`. Add the extra origins to `gateway.controlUi.allowedOrigins` and restart.

### Set Default Model (after gateway is ready)
```bash
# Preferred — single command:
docker compose run --rm openclaw-cli models set moonshotai/kimi-k2.5

# Discover free OpenRouter models and auto-set best available:
docker compose run --rm openclaw-cli models scan --set-default

# Or set explicitly via config path:
docker compose run --rm openclaw-cli config set agents.defaults.model.primary "moonshotai/kimi-k2.5"

# Inspect a candidate without changing config:
docker compose run --rm openclaw-cli capability model inspect --model moonshotai/kimi-k2.5
```
**Model ID resolution:** OpenClaw's catalog accepts both bare `<vendor>/<model>` (e.g. `moonshotai/kimi-k2.5`) and the explicit `openrouter/<vendor>/<model>` form — both resolve to provider `openrouter`. Use the bare form unless you need to force a specific provider for a model that exists in multiple catalogs. Verified-good model IDs for the Kimi family: `moonshotai/kimi-k2.5` (262k ctx, reasoning, text+image) and `moonshotai/kimi-k2.6`.

Most `gateway.*` config changes require a gateway restart to apply; agent/model changes apply via hot-reload without restart (you'll see `[reload] config change detected` in the logs). Verify with `docker compose logs | grep "agent model:"`. Without explicit config the gateway uses a provider default (often `openai/gpt-5.5`).

### Get Auth Token
```bash
python -c "import json; d=json.load(open('.openclaw/openclaw.json')); print(d['gateway']['auth']['token'])"
```
Token persists across restarts as long as `.openclaw/` is not wiped.

### Images & Requirements
- **Registry:** `ghcr.io/openclaw/openclaw` — tags: `latest`, `main`, `<version>` (e.g., `2026.4.25`)
- **Base image:** `node:24-bookworm-slim`
- **Node.js:** v24 recommended (v22.14+ supported)
- **RAM:** 2 GB minimum (1 GB risks OOM-kill / exit 137)
- **Docker:** Docker Desktop or Docker Engine + Compose v2

### Environment Variables
| Variable | Purpose |
| :--- | :--- |
| `OPENROUTER_API_KEY` | **Default LLM provider.** Required for inference. |
| `OPENAI_API_KEY` | Alternative provider — only if not using OpenRouter. |
| `OPENCLAW_SKIP_ONBOARDING` | Skip interactive setup. |
| `OPENCLAW_IMAGE` | Remote image override. |
| `OPENCLAW_EXTENSIONS` | Space-separated plugins to pre-install at build time. |
| `OPENCLAW_PLUGIN_STAGE_DIR` | Container path for generated bundled plugin deps. |
| `OPENCLAW_SANDBOX` | Enable sandbox (`1`, `true`, `yes`, `on`). |
| `OPENCLAW_HOME_VOLUME` | Persist `/home/node` in a named Docker volume. |
| `OPENCLAW_DISABLE_BONJOUR` | Disable mDNS — always `1` in Docker. |
| `OPENCLAW_DOCKER_SOCKET` | Override Docker socket path. |
| `OPENCLAW_DEFAULT_MODEL_ID` | Bootstrap default model id (e.g. `moonshotai/kimi-k2.5`). Optional — `openclaw models set` is the canonical path. Note: spelled `_MODEL_ID`, not `_MODEL`. |
| `OTEL_EXPORTER_OTLP_ENDPOINT` | OTLP collector endpoint. |
| `OTEL_SERVICE_NAME` | OpenTelemetry service identifier. |

**Never set in `.env` before first boot:** `OPENCLAW_GATEWAY_TOKEN` (causes auth resolution deadlock on startup — set only after gateway is running for CLI use), `OPENCLAW_GATEWAY_BIND` (has been observed to cause silent startup hangs on Windows/Docker Desktop; `bind=auto` is the safe default).

**Legacy prefixes:** older `CLAWDBOT_*` and `MOLTBOT_*` variables are not part of the current public surface — use the `OPENCLAW_*` prefix for any new configuration.

### Volume Mounts & Storage
| Mount | Purpose |
| :--- | :--- |
| `./.openclaw → /home/node/.openclaw` | Config, state, plugin-runtime-deps — project-local |
| Named volume `→ /var/lib/openclaw/plugin-runtime-deps` | Declared but unused — actual deps land in `.openclaw/plugin-runtime-deps/` |

Always use project-local `.openclaw/`, never `${HOME}/.openclaw` — keeps instances isolated. Add to `.gitignore`.

### CLI Commands
```bash
# Model — preferred shorthand
docker compose run --rm openclaw-cli models set moonshotai/kimi-k2.5
docker compose run --rm openclaw-cli models scan --set-default --probe   # discover free models

# Model — explicit config path
docker compose run --rm openclaw-cli config set agents.defaults.model.primary "moonshotai/kimi-k2.5"
docker compose run --rm openclaw-cli config get agents.defaults.model.primary

# Config — batch (field is "path", not "key"), merge, patch
docker compose run --rm openclaw-cli config set --batch-json '[{"path":"gateway.port","value":18789}]'
docker compose run --rm openclaw-cli config set agents.defaults.models '{"moonshotai/kimi-k2.5":{}}' --merge
docker compose run --rm openclaw-cli config patch   # recursive merge from JSON5 file

# Channels
docker compose run --rm openclaw-cli channels login                # WhatsApp (QR scan)
docker compose run --rm openclaw-cli channels add --channel telegram --token "<token>"
docker compose run --rm openclaw-cli channels add --channel discord --token "<token>"

# Devices
docker compose run --rm openclaw-cli devices list
docker compose run --rm openclaw-cli devices approve <requestId>

# Health & diagnostics
docker compose run -T --rm openclaw-cli gateway probe
docker compose run --rm openclaw-cli gateway status          # confirms "Runtime: running"
docker compose run --rm openclaw-cli health --verbose
docker compose exec openclaw-gateway node dist/index.js health --token "$OPENCLAW_GATEWAY_TOKEN"

# Repair
docker compose run --rm openclaw-cli doctor --fix
```

### Sandbox Configuration
```json5
{
  agents: {
    defaults: {
      sandbox: { mode: "non-main", scope: "agent" }
    }
  }
}
```
Build sandbox image: `scripts/sandbox-setup.sh`. Rootless Docker: set `OPENCLAW_DOCKER_SOCKET=/run/user/1000/docker.sock`.

## 3. Plugin Runtime Lock — Troubleshooting

The gateway holds a directory lock at:
```
.openclaw/plugin-runtime-deps/openclaw-<version>/.openclaw-runtime-mirror.lock/
```
during npm install/verify on startup. This causes **silent hang at "starting..."** when:

| Scenario | Symptom | Fix |
| :--- | :--- | :--- |
| **Stale lock** — container killed while holding lock | New boot hangs up to 300s, then logs "Timed out waiting for lock" | Delete the lock dir from host |
| **npm registry hang** — npm contacts `registry.npmjs.org`, request stalls | Gateway process in `D` state (uninterruptible sleep); lock never released | Delete lock dir; add `.npmrc` (see below) |

**Detect and remove stale lock:**
```bash
# Check for lock
ls .openclaw/plugin-runtime-deps/openclaw-*/

# Remove if stuck (gateway is unhealthy for 5+ min with no "ready" log)
rm -rf .openclaw/plugin-runtime-deps/openclaw-*/.openclaw-runtime-mirror.lock
```

**Prevent npm registry hang** — add `.npmrc` to the deps dir:
```bash
cat > .openclaw/plugin-runtime-deps/openclaw-*/`.npmrc << 'EOF'
prefer-offline=true
fetch-retry-mintimeout=1000
fetch-retry-maxtimeout=5000
fetch-retries=1
EOF
```

**Pre-seed node_modules** (eliminates npm install on boot):
```powershell
# Run once; use PowerShell on Windows to avoid path mangling
$depsPath = "$(pwd)\.openclaw\plugin-runtime-deps\openclaw-<version>"
docker run --rm -v "${depsPath}:/work" -w "/work" node:24-bookworm-slim `
  npm install --prefer-offline --cache /work/.openclaw-npm-cache
```

## 4. Observability & Health Monitoring
Implement a **5-minute validation loop** after any deployment.

### Health Probes
| Probe | Endpoint / Command | Notes |
| :--- | :--- | :--- |
| **Liveness** | `GET http://127.0.0.1:18789/healthz` | No auth required |
| **Readiness** | `GET http://127.0.0.1:18789/readyz` | No auth required |
| **Status summary** | `openclaw status` | Local diagnosis, read-only |
| **Full diagnosis** | `openclaw status --all` | Safe for debugging |
| **Live channel probe** | `openclaw status --deep` | Requests live probe from gateway |
| **Health snapshot** | `openclaw health` | Cached; returns `ok`, `ts`, `durationMs`, per-channel |
| **Live health probe** | `openclaw health --verbose` | Forces real-time assessment |
| **Machine-readable** | `openclaw health --json` | CI-friendly output |
| **Prometheus metrics** | `GET http://<host>:18789/api/diagnostics/prometheus` | Auth required; enable `diagnostics-prometheus` plugin |

Key health config: `gateway.channelHealthCheckMinutes` (default 5), `gateway.channelStaleEventThresholdMinutes` (default 30), `gateway.channelMaxRestartsPerHour` (default 10).

### Observability Stack
```bash
export OPENCLAW_EXTENSIONS="diagnostics-otel"
export OTEL_EXPORTER_OTLP_ENDPOINT="http://otel-collector:4318"
export OTEL_SERVICE_NAME="openclaw-gateway"
```
Prometheus: enable `diagnostics-prometheus` extension, scrape `http://<host>:18789/api/diagnostics/prometheus`.

## 5. Channels — Setup & Troubleshooting
Use `docker compose run -T --rm openclaw-cli gateway probe` for connectivity checks. Inspect what a channel can do before wiring it: `openclaw channels capabilities --channel <name>`.

### Telegram bridge
1. **Create the bot** — DM `@BotFather` on Telegram, send `/newbot`, follow prompts to set a display name and a unique username ending in `bot`. Copy the HTTP API token it returns.
2. **Register with the gateway** (gateway must be `ready`):
   ```bash
   docker compose run --rm openclaw-cli channels add --channel telegram --token "<BOT_TOKEN>"
   ```
   Successful registration logs `Added Telegram account "default".` and rewrites `.openclaw/openclaw.json` (verify with `channels list`).
3. **Pair your DM** — open a chat with the bot in Telegram and send a message. The gateway emits a pairing code; approve from your terminal:
   ```bash
   docker compose run --rm openclaw-cli pairing list --channel telegram
   docker compose run --rm openclaw-cli pairing approve telegram <CODE>
   # Optional: --notify to confirm to the requester on the same channel
   ```
4. **Verify** — `openclaw channels status --probe`, then send a real message; expect a turn in `openclaw sessions list`.

### Discord bridge
1. **Create the application** — Discord Developer Portal → New Application → **Bot** tab → Reset Token (copy it).
2. **Enable Privileged Intents** — under the **Bot** tab, toggle on **Message Content Intent** (and **Server Members Intent** if you need member metadata). Without Message Content the bot receives empty message bodies and looks dead.
3. **Invite the bot** — OAuth2 → URL Generator → scopes `bot` + `applications.commands` → bot permissions sized to your needs (Read/Send Messages at minimum) → open the URL and pick your server.
4. **Register with the gateway**:
   ```bash
   docker compose run --rm openclaw-cli channels add --channel discord --token "<BOT_TOKEN>"
   # Use --token (NOT --bot-token despite Discord's terminology); --bot-token is reserved for other channel types.
   ```
5. **Pair via DM or guild channel** — same flow as Telegram:
   ```bash
   docker compose run --rm openclaw-cli pairing list --channel discord
   docker compose run --rm openclaw-cli pairing approve discord <CODE>
   ```

### Channel troubleshooting
- **Discord — silent bot:** missing **Message Content Intent** is the #1 cause. Re-toggle in the Developer Portal and restart the gateway.
- **Discord — policy/allowlist:** if the bot replies in DMs but ignores guild messages, check `allowlist` and DM-vs-guild routing in agent group policies.
- **Telegram — no pairing code:** confirm you messaged the bot directly (not a group), and that `channels list` shows the account active.
- **Generic listener timeouts:** increase `read_timeout` in the channel config block.
- **Probe a channel without a real message:** `openclaw channels status --probe` (cached) or `openclaw status --deep` (live, talks to the gateway).

## Anti-Patterns

| Anti-Pattern | Why | Better Way |
| :--- | :--- | :--- |
| Local binary installation | Pollutes host, breaks reproducibility. | Always use Docker/Docker Compose. |
| Root ownership of volumes | Prevents `node` (UID 1000) from writing. | `sudo chown -R 1000:1000 .openclaw/` |
| Using `localhost` for host apps | Refers to the container, not the host. | Use `host.docker.internal`. Host service must bind `0.0.0.0`. |
| Setting `OPENCLAW_GATEWAY_TOKEN` in `.env` before first boot | Gateway tries to validate token against itself during startup → deadlock, never reaches `ready`. | Omit from `.env` on first boot. After boot, read token from `.openclaw/openclaw.json`. Set `OPENCLAW_GATEWAY_TOKEN` only for CLI tool authentication after the gateway is running. |
| Setting `OPENCLAW_GATEWAY_BIND` in `.env` | Has been observed to cause silent startup hangs on Windows/Docker Desktop. | Omit it. `bind=auto` binds to `0.0.0.0` already. |
| `start_period: 30s` in healthcheck | First boot stages bundled npm deps; 30s is shorter than even a warm install and causes premature `unhealthy`. | Use `start_period: 300s` to cover cold-cache installs. |
| Restarting container the moment logs go quiet | A normal first boot has a silent npm-install window; restarting mid-install can leave a stale plugin lock that blocks the next boot. | Check `.openclaw/plugin-runtime-deps/openclaw-*/.openclaw-runtime-mirror.lock/` for a lock dir first; remove it only if the gateway has been silent for >5 min with no `[plugins] installed` log. |
| Pre-seeding `openclaw.json` with bind/model | Gateway overwrites and renames your file to `.clobbered.*`. | Never pre-seed. Set model via CLI after boot: `models set <model>`. |
| Using a Docker Hub image like `openclaw/gateway:latest` or `openclaw/cli:latest` | Those repositories don't exist; `docker pull` returns 404. | Use `ghcr.io/openclaw/openclaw:latest` for both gateway and CLI roles. |
| Setting `OPENCLAW_DEFAULT_MODEL` in `.env` | The actual variable is `OPENCLAW_DEFAULT_MODEL_ID`; the misspelled form is silently ignored. | Skip env var entirely. Run `openclaw models set <model>` after the gateway is ready — it persists to `agents.defaults.model.primary` and hot-reloads. |
| Storing config in `${HOME}/.openclaw` | Shared across instances; breaks isolation. | Use `./.openclaw` co-located with `docker-compose.yml`. |
| Not setting `agents.defaults.model.primary` | Gateway defaults to whatever the provider returns (often `openai/gpt-5.5`). | Set via CLI: `models set moonshotai/kimi-k2.5`. Bare `<vendor>/<model>` is auto-resolved to the OpenRouter provider; the explicit `openrouter/<vendor>/<model>` form also works. |
| Wrong batch-json field name | `{"key":...}` fails with "path is required". | Use `{"path":..., "value":...}` in batch-json arrays. |
| Logging in before `[gateway] ready` | Supervisor serves login UI immediately; WebSocket fails until gateway is ready → `1006 disconnect`. | Watch logs for `[gateway] ready` before opening the control UI. |
| Opening the control UI on a non-default origin | Since v2026.2.26 the gateway only accepts the seeded origins (`localhost:18789`, `127.0.0.1:18789`); any other origin returns `1008 origin not allowed`. | Add the extra origin to `gateway.controlUi.allowedOrigins` and restart the gateway. |
| Using `--bot-token` when adding a Discord channel | OpenClaw expects `--token` for Discord; `--bot-token` is reserved for channels like Matrix/Synology and produces "Discord requires token (or --use-env)". | `channels add --channel discord --token "<BOT_TOKEN>"`. |

## Power Move
"Audit my OpenClaw production deployment. Run `openclaw status --deep` and `openclaw health --verbose`, check for stale plugin locks under `.openclaw/plugin-runtime-deps/`, verify the current model with `config get agents.defaults.model.primary`, probe all channels with `gateway probe`, and generate a `docker-compose.extra.yml` override that enables the OTel extension with a local collector."
