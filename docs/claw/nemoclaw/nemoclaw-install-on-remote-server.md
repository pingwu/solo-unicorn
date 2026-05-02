# NemoClaw — Install on a Remote Linux Server

**NemoClaw** is NVIDIA's plugin for OpenClaw that adds sandboxed execution via OpenShell and cloud inference routing. Announced March 16, 2026.

- GitHub: https://github.com/NVIDIA/NemoClaw
- Docs: https://docs.nvidia.com/nemoclaw/latest/index.html

---

## Architecture

```
Local Machine (SSH tunnel)
    │
    ▼
Remote Linux Server (host)
    ├── OpenClaw gateway  (your existing AI assistant — Slack, browser UI)
    │
    └── NemoClaw CLI
            └── OpenShell gateway (k3s in Docker)
                    └── Sandbox: <your-sandbox> (container)
                            └── OpenClaw instance (sandboxed)
                                    └── Inference → NVIDIA Build or custom provider
```

**Key relationships:**
- **OpenClaw** is the AI agent runtime — runs both on the host and inside each sandbox
- **NemoClaw** is a launcher/wrapper — runs OpenClaw inside a secured OpenShell container
- **OpenShell** is NVIDIA's container runtime — provides Landlock + seccomp + network policy sandboxing
- The host OpenClaw and sandbox OpenClaw are **independent** — different ports, different configs
- **Inference provider** (LLM backend) is separate from the sandbox — configured at the OpenShell gateway level

**Config files:**
- `~/.nemoclaw/sandboxes.json` — sandbox registry (nemoclaw-managed)
- `~/.nemoclaw/credentials.json` — stored credentials
- Inference config managed by `openshell inference set/get`

---

## Platform Notes

| Platform | Supported |
|---|---|
| Linux Ubuntu 22.04+ (x86_64 / ARM64) | ✅ |
| macOS (Apple Silicon) | ❌ |
| Requires local NVIDIA GPU | ❌ — uses cloud inference by default |

Works on a headless remote server — no display needed. Browser UI accessed via SSH tunnel.

---

## Prerequisites

### 1. Node.js 22+ and npm 10+

```bash
node --version   # must be v20+
npm --version    # must be v10+
```

If not installed, use [nvm](https://github.com/nvm-sh/nvm):

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
source ~/.bashrc
nvm install 22
```

### 2. Docker

```bash
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker $USER
```

> Use `sudo docker` until you log back in for group membership to take effect.

**Important — cgroup v2 fix (required before onboarding):**

OpenShell runs k3s inside Docker, which requires cgroupns=host mode. Run this before onboarding:

```bash
sudo nemoclaw setup-spark
```

> `setup-spark` modifies `/etc/docker/daemon.json` and restarts Docker.
> Run with the full path if needed: `sudo ~/.npm-global/bin/nemoclaw setup-spark`

### 3. OpenShell

```bash
curl -LsSf https://raw.githubusercontent.com/NVIDIA/OpenShell/main/install.sh | sh
```

Installs to `~/.local/bin/openshell`. Add to PATH:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
```

---

## Installation

```bash
git clone https://github.com/NVIDIA/NemoClaw.git
cd NemoClaw
```

Fix npm permissions to avoid `EACCES` on `npm link`:

```bash
mkdir -p ~/.npm-global
npm config set prefix '~/.npm-global'
npm install && npm link
```

Add to PATH:

```bash
echo 'export PATH="$HOME/.npm-global/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

Verify:

```bash
nemoclaw help
```

> **Note:** `~/.bashrc` is not loaded in non-interactive SSH sessions. Always set PATH explicitly when running via remote scripts: `export PATH="$HOME/.npm-global/bin:$HOME/.local/bin:$PATH"`

---

## Onboarding

Run `setup-spark` first (one-time), then onboard. Always use a **single-line command** — multi-line backslash continuation can break in interactive shells and cause flags to be interpreted as shell commands.

### Step 1 — Fix Docker cgroup config

```bash
sudo ~/.npm-global/bin/nemoclaw setup-spark
```

### Step 2 — Run onboard (single line)

**Option A: NVIDIA Build (recommended — free credits, native integration)**

```bash
nemoclaw onboard --endpoint build --api-key <nvapi-key> --model nvidia/nemotron-3-nano-30b-a3b
```

**Option B: OpenAI-compatible provider (e.g. OpenRouter)**

```bash
nemoclaw onboard --endpoint custom --endpoint-url https://openrouter.ai/api/v1 --api-key <your-api-key> --model <model-id>
```

> For OpenRouter, model IDs use the format `moonshotai/kimi-k2.5` (no `openrouter/` prefix).

### Onboard wizard prompts

| Prompt | Notes |
|---|---|
| Sandbox name | Choose a meaningful name e.g. `my-assistant` |
| Recreate sandbox? | Say `Y` on first run; `N` only if sandbox is already healthy in OpenShell |
| Policy presets | Accept suggested (pypi, npm); add slack/discord later |

> **Gotcha:** If you answer `N` to sandbox recreation but the sandbox isn't registered in OpenShell, policy application will fail with `sandbox not found`. When in doubt, say `Y` to recreate — it's safe.

### Step 3 — Update inference provider (if needed)

If you need to change the provider after onboarding without re-running the wizard:

```bash
# Create or update provider
openshell provider create --name nvidia-ncp --type openai \
  --credential "NVIDIA_API_KEY=<key>" \
  --config "OPENAI_BASE_URL=https://openrouter.ai/api/v1"

# Set active inference route (use correct model ID format for the provider)
openshell inference set --provider nvidia-ncp --model moonshotai/kimi-k2.5

# Verify
openshell inference get
```

---

## Sandbox Management

```bash
# Check status
nemoclaw <sandbox-name> status

# Add a policy preset after onboarding (preset name as positional arg works)
nemoclaw <sandbox-name> policy-add slack
nemoclaw <sandbox-name> policy-add discord

# List active policies
nemoclaw <sandbox-name> policy-list

# Connect to sandbox shell
nemoclaw <sandbox-name> connect

# List sandboxes (via openshell)
openshell sandbox list
```

> **Note:** The correct subcommand is `policy-add` (hyphenated), not `policy add`.
> The preset name can be passed as a positional argument to avoid the interactive prompt, but the Y/n confirmation still requires a TTY.

---

## Access via SSH Tunnel

OpenShell gateway listens on port `8080`. OpenClaw host gateway on port `18789`.

From your local machine:

```bash
# NemoClaw / OpenShell gateway
ssh -i ~/.ssh/<your-key> -L 18080:localhost:8080 -N -f user@<server-ip>

# OpenClaw host gateway (if not already running)
ssh -i ~/.ssh/<your-key> -L 16789:localhost:18789 -N -f user@<server-ip>
```

| Service | Server Port | Local Port |
|---|---|---|
| OpenClaw (host) | 18789 | 18790 |
| NemoClaw / OpenShell | 8080 | 18080 |

Access in browser:
- `https://localhost:18080` — NemoClaw/OpenShell UI
- `http://localhost:18790/?token=<token>` — OpenClaw host UI

### Browser mTLS Setup (required for port 18080)

OpenShell uses **mutual TLS** — the browser must present a client certificate. One-time setup:

**Step 1 — Export client cert from server:**
```bash
ssh user@<server>
openssl pkcs12 -export -legacy \
  -out /tmp/openshell-client.p12 \
  -inkey ~/.config/openshell/gateways/nemoclaw/mtls/tls.key \
  -in ~/.config/openshell/gateways/nemoclaw/mtls/tls.crt \
  -certfile ~/.config/openshell/gateways/nemoclaw/mtls/ca.crt \
  -passout pass:nemoclaw
```

**Step 2 — Copy to local machine:**
```bash
scp -i ~/.ssh/<your-key> user@<server>:/tmp/openshell-client.p12 ~/Downloads/
```

**Step 3 — Import into macOS Keychain:**
```bash
security import ~/Downloads/openshell-client.p12 \
  -k ~/Library/Keychains/login.keychain-db \
  -P nemoclaw \
  -T "/Applications/Google Chrome.app" \
  -T "/Applications/Safari.app"
```

> Use `-legacy` flag when creating the p12 — macOS requires it for compatibility.

**Step 4 — Access in browser:**
1. Fully restart Chrome (Cmd+Q, reopen)
2. Go to `https://localhost:18080`
3. When prompted "Select a certificate" — choose the imported one
4. Enter your **macOS login password** when Keychain asks (it's the same as your Mac user password)

---

## Policy Presets

Presets control what outbound network access the sandbox is allowed. Without a preset, calls to that service are blocked.

| Preset | Allows |
|---|---|
| pypi | Python package installs |
| npm | Node package installs |
| slack | Slack API and webhooks |
| discord | Discord API and CDN |
| huggingface | HuggingFace Hub and inference |
| docker | Docker Hub and NVIDIA registry |

---

## Status Checklist

- [x] Docker installed and cgroup v2 configured (`setup-spark`)
- [x] NemoClaw cloned and npm-linked
- [x] OpenShell installed
- [x] OpenShell gateway running (port 8080)
- [x] `nemoclaw onboard` completed — sandbox created
- [x] SSH tunnel established (local port 18080)
- [x] Sandbox registered in OpenShell (`openshell sandbox list`)
- [x] Slack/Discord/pypi/npm policy presets applied
- [x] mTLS client certificate exported and imported to local Keychain
- [ ] Browser access verified at `https://localhost:18080`
- [ ] Inference provider finalized (NVIDIA Build vs OpenRouter)
