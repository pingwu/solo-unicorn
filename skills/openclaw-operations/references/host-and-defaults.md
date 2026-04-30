---
name: openclaw-host-and-defaults
description: Assumptions baked into the openclaw-operations skill — default model, provider/API-key choice, host requirements (Windows WSL2 caveats, RAM, ports, persistence), and what to do when those assumptions don't fit.
---

# Host & Default Assumptions

The main `SKILL.md` makes several choices for you to keep examples concrete. This file documents what those choices are and how to deviate.

## Default model: `moonshotai/kimi-k2.5`

**What's assumed:** every example uses `moonshotai/kimi-k2.5` as the agent's primary model.

**Why this default:**
- 262k token context window — fits long agent transcripts and tool histories.
- Reasoning mode supported — the gateway treats it as `reasoning: true`.
- Inputs: text + image.
- Resolved via OpenRouter (provider `openrouter`); the bare `<vendor>/<model>` form is auto-routed there.
- Often available on a free tier on OpenRouter (verify on https://openrouter.ai/models — pricing changes).

**When to deviate:**
- **Need a different cost/latency point** → use `models scan --set-default` (auto-picks a free OpenRouter model that passes a tools probe) or set explicitly: `models set <model>`.
- **Need Anthropic/OpenAI direct** instead of via OpenRouter → set `OPENAI_API_KEY` or configure another provider in `agents.defaults.models`, then `models set <provider/model>`.
- **A model with a slash-rich id collides** with another provider's catalog → use the explicit `openrouter/<vendor>/<model>` form to force the route.

## API provider: OpenRouter (`OPENROUTER_API_KEY`)

**What's assumed:** all `.env` examples set `OPENROUTER_API_KEY=sk-or-v1-...` and treat OpenRouter as the default LLM provider.

**Why:**
- One key gives access to many models (Anthropic, OpenAI, Google, Moonshot, Mistral, Meta, etc.) — easier to swap models without changing keys.
- Free-tier models exist for development (rate-limited; do not rely on for production).
- OpenClaw's catalog already maps OpenRouter as a first-class provider — no extra config needed.

**Key format:** `sk-or-v1-<hex>`. Generated at https://openrouter.ai/keys. Paid balance is per-key.

**When to deviate:**
- **Vendor lock-in or compliance requirement** → swap `OPENROUTER_API_KEY` for `OPENAI_API_KEY` / `ANTHROPIC_API_KEY` and pick a model that resolves to that provider.
- **Self-hosted Ollama** → set the Ollama endpoint and use `ollama/<model>` ids (out of scope for this skill's examples).

## Host: Windows + WSL2 + Docker Desktop

**What's assumed:** the developer is running Docker Desktop on Windows with the WSL2 backend, with the project mounted from a Windows filesystem path (e.g. `/mnt/c/...`).

**Observed pain points on this configuration:**

| Symptom | What's happening | Mitigation |
| :--- | :--- | :--- |
| First-boot plugin install takes 3–5 min (vs ~20s on native Linux) | npm install runs against a 9P-mounted volume; small-file IO is slow on WSL2 + Windows-mounted paths. | Keep `start_period: 300s` in the healthcheck. Optionally pre-seed `node_modules` with the PowerShell snippet in `SKILL.md` §3. For best results, place the project under the WSL2 native filesystem (`~/projects/...`) instead of `/mnt/c/...`. |
| `health: unhealthy` even when the Control UI works | The container's `wget http://127.0.0.1:18789/healthz` can time out on this host's networking path, even though external WS connections succeed. | Treat `unhealthy` as advisory if the WS UI is connecting and `openclaw health --verbose` returns ok. To silence: replace the `wget` healthcheck with `["CMD-SHELL", "openclaw health --json | grep -q '\"ok\":true' || exit 1"]`, or remove the healthcheck stanza if you don't need an orchestrator restart trigger. |
| `host.docker.internal` or `localhost` in env vars resolves to the container, not the host | Docker Desktop networking quirk — only the magic DNS name `host.docker.internal` reaches the host. | Use `host.docker.internal` for any host-side service (e.g. local Ollama at `http://host.docker.internal:11434`). Host service must bind `0.0.0.0`, not `127.0.0.1`. |
| Pre-seed scripts mangle paths | `bash` on WSL converts paths; PowerShell preserves them. | Run pre-seed scripts in PowerShell (see `SKILL.md` §3) with backtick line continuations. |

**RAM:** 2 GB is the hard minimum. Docker Desktop's WSL2 VM defaults vary — confirm with `docker info | grep -i memory`. 1 GB has been observed to OOM-kill the gateway during plugin install (exit code 137).

## Persistence model

**What's assumed:** every instance uses a project-local `./.openclaw/` directory. Losing this directory loses **everything** for that instance: gateway auth token, configured channels, paired devices, agent memory, sessions, and the staged plugin runtime deps.

**Implications:**
- Add `.openclaw/` to `.gitignore` (the skill's template does this) — never commit it.
- Back it up if it has paired channels or non-trivial agent state. A simple `tar czf claw4-state-$(date +%F).tgz .openclaw/` while the gateway is **stopped** (`docker compose down`) is fine.
- Don't share `.openclaw/` between instances. The gateway treats it as its own state dir; two gateways pointing at the same dir will fight over the runtime lock.

## Port & origin assumptions

**What's assumed:** every instance binds host port `18789` and the Control UI is opened at `http://localhost:18789`.

**Implication:** **only one OpenClaw instance can run at a time** with the default template. Bring others down (`docker compose down` in their dirs) before starting a new one.

**To run multiple instances in parallel**, change two things together:
1. Map a different host port — e.g. `"18790:18789"` for a second instance.
2. Add the new origin to `gateway.controlUi.allowedOrigins`:
   ```bash
   docker compose run --rm openclaw-cli config set --batch-json \
     '[{"path":"gateway.controlUi.allowedOrigins","value":["http://localhost:18789","http://127.0.0.1:18789","http://localhost:18790"]}]'
   docker compose restart openclaw-gateway
   ```
3. Keep the in-container port (`18789`) the same — only the host-side mapping changes. The healthcheck still hits `127.0.0.1:18789` inside the container.

## Image & version assumptions

**What's assumed:** examples use `ghcr.io/openclaw/openclaw:latest`.

**Implication:** `latest` follows the rolling release. Two pulls a week apart can land you on different versions with different config schemas (the v2026.2.26 origin allowlist is a recent example).

**For production**, pin a version:
```yaml
image: ghcr.io/openclaw/openclaw:2026.4.27
```
and bump deliberately. Inspect the running version with `docker compose exec openclaw-gateway openclaw --version`.

**The Docker Hub repos `openclaw/gateway` and `openclaw/cli` do not exist** — only GHCR publishes the image, and a single image is used for both gateway and CLI roles (the CLI service just sets `entrypoint: ["openclaw"]`).

## What this skill does NOT cover

These are explicitly out of scope; reach for the linked surfaces if you need them:
- **Multi-tenant gateway / SSO** — the skill assumes single-operator deployments authenticated via the bootstrap token.
- **Reverse proxy + TLS termination** — examples bind plain HTTP. Put a reverse proxy (Caddy, nginx, Cloudflare Tunnel) in front for any non-localhost exposure, and add the public origin to `gateway.controlUi.allowedOrigins`.
- **Backup/restore automation** — manual `tar` of `.openclaw/` is the recommendation; nothing scheduled.
- **CI/CD for skill or plugin updates** — `OPENCLAW_EXTENSIONS` is a build-time hint; runtime plugin upgrades need a fresh image.
- **Channels other than Telegram, Discord, WhatsApp** — the channels surface is broader (Matrix, Slack, Signal, IRC, Google Chat, etc.); see `openclaw channels add --channel <name> --help` for per-channel flags.
