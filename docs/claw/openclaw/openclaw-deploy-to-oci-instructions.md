---
title: Deploy OpenClaw to OCI Always Free A1 ARM — Instructions
type: runbook
status: active
date: 2026-03-13
---

# Deploy OpenClaw to OCI Always Free A1 ARM

Repeatable instructions to provision a fresh OpenClaw instance on OCI's Always Free
A1 ARM tier and connect it to Slack. Tested 2026-03-13 on us-chicago-1.

### Environment Key

Every step is labelled with where it runs:

| Label | Where |
|---|---|
| 💻 **Local terminal** | Your Mac or Windows (WSL2) terminal |
| 🌐 **Browser** | Any browser — OCI Console or Slack web UI |
| 🔒 **Remote SSH** | Inside an SSH session on the OCI server |
| 🔒🖥️ **Remote SSH (live terminal)** | SSH with interactive TUI — must be a real terminal, not a script |

---

## Prerequisites

### Accounts

| Account | Purpose | Notes |
|---|---|---|
| Oracle OCI | Cloud infrastructure | PAYG upgrade recommended — needed for multi-region |
| OpenRouter | AI model API | Get API key from openrouter.ai |
| | | **Workshop prep:** Warn participants to register 24h early; shared WiFi may trigger rate limits |
| GitHub | Fork solo-unicorn repo | Free account sufficient |
| Slack | Bot integration | Free workspace works for demo |

### Local Tools (Mac)

```bash
brew install oci-cli      # OCI CLI
brew install autossh      # Persistent SSH tunnel
brew install gh           # GitHub CLI
# openssl, ssh, git — pre-installed on Mac
# Claude Code or Gemini CLI — install separately
```

### Local Tools (Windows)

All CLI commands run inside **WSL2 (Ubuntu)**. Browser steps (OCI Console, Slack, OpenClaw UI) run natively in Windows.

**Step 1 — Install WSL2 with Ubuntu**

Open PowerShell as Administrator:
```powershell
wsl --install
# Reboot when prompted, then open "Ubuntu" from Start menu
# Set a Unix username and password when asked
```

> If WSL2 is already installed but you need Ubuntu: `wsl --install -d Ubuntu`

**Step 2 — Install tools inside WSL2 (Ubuntu terminal)**

```bash
# OCI CLI
bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"
# Accept all defaults — adds to ~/.bashrc automatically

# autossh (persistent SSH tunnel)
sudo apt-get install -y autossh

# GitHub CLI
type -p curl >/dev/null || sudo apt-get install -y curl
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt-get update && sudo apt-get install -y gh

# openssl, ssh, git — already included in Ubuntu WSL2
```

**Step 3 — Reload shell**
```bash
source ~/.bashrc
oci --version   # should print version number
```

> **WSL2 file tip:** Keep all project files inside WSL2 (`~/`) not on the Windows drive (`/mnt/c/`). Performance and SSH key permissions (`chmod 600`) work correctly only inside WSL2.

---

## Phase 1 — Configure OCI CLI

### 1.1 Gather OCIDs from OCI Console
🌐 **Browser** → console.oracle.com

| Item         | Location                                                                                                                |
| ------------ | ----------------------------------------------------------------------------------------------------------------------- |
| User OCID    | Profile → My Profile → copy OCID                                                                                        |
| Tenancy OCID | Profile → Tenancy Details → copy OCID                                                                                   |
| Home Region  | Top-right region selector (recommend use us-chicago-1 as home region because less busy/more free A1 available possible) |

### 1.2 Generate OCI API key pair
💻 **Local terminal**

```bash
mkdir -p ~/.oci
openssl genrsa -out ~/.oci/oci_api_key.pem 2048
chmod 600 ~/.oci/oci_api_key.pem
openssl rsa -pubout -in ~/.oci/oci_api_key.pem -out ~/.oci/oci_api_key_public.pem

# Get fingerprint — copy this output
openssl rsa -pubout -outform DER -in ~/.oci/oci_api_key.pem | openssl dgst -md5 -c
```

### 1.3 Create ~/.oci/config
💻 **Local terminal**

```ini
[DEFAULT]
user=<your-user-ocid>
fingerprint=<fingerprint-from-above>
tenancy=<your-tenancy-ocid>
region=us-chicago-1
key_file=~/.oci/oci_api_key.pem
```

```bash
chmod 600 ~/.oci/config
```

### 1.4 Upload public key to OCI Console
🌐 **Browser** → console.oracle.com

1. Profile → **Tokens and keys** → **Add API key**
2. Select **Paste a public key**
3. Paste contents of `~/.oci/oci_api_key_public.pem`
4. Confirm fingerprint matches

### 1.5 Verify CLI
💻 **Local terminal**

```bash
oci iam region list --output table
```

---

## Phase 2 — Subscribe to us-chicago-1 (skip if already home region)

### 2.1 Check subscription status
💻 **Local terminal**

```bash
export TENANCY=<your-tenancy-ocid>

oci iam region-subscription list \
  --tenancy-id $TENANCY \
  --output table
```

### 2.2 Subscribe if not listed
🌐 **Browser** → console.oracle.com

> CLI subscription fails on Free Trial accounts — use Console UI.

Console → Profile → Tenancy → **Subscribed Regions** → Manage → Subscribe **ORD (us-chicago-1)**

### 2.3 Verify READY
💻 **Local terminal** — wait 2–5 minutes then:

```bash
oci iam region-subscription list --tenancy-id $TENANCY --output table
# us-chicago-1 status must show READY before proceeding
```

---

## Phase 3 — Provision Network Stack

💻 **Local terminal** — all steps in this phase

Set variables once for the session:

```bash
export TENANCY=<your-tenancy-ocid>

export AD=$(oci iam availability-domain list \
  --compartment-id $TENANCY \
  --query 'data[0].name' --raw-output)
echo "AD: $AD"
```

### 3.1 VCN

```bash
export VCN=$(oci network vcn create \
  --compartment-id $TENANCY \
  --cidr-block "10.0.0.0/16" \
  --display-name "openclaw-vcn" \
  --dns-label "openclawvcn" \
  --wait-for-state AVAILABLE \
  --query 'data.id' --raw-output)
echo "VCN: $VCN"
```

### 3.2 Internet Gateway

```bash
export IGW=$(oci network internet-gateway create \
  --compartment-id $TENANCY \
  --vcn-id $VCN \
  --display-name "openclaw-igw" \
  --is-enabled true \
  --wait-for-state AVAILABLE \
  --query 'data.id' --raw-output)
echo "IGW: $IGW"
```

### 3.3 Default route → Internet Gateway

```bash
export RT=$(oci network route-table list \
  --compartment-id $TENANCY \
  --vcn-id $VCN \
  --query 'data[0].id' --raw-output)

oci network route-table update \
  --rt-id $RT \
  --route-rules "[{\"destination\":\"0.0.0.0/0\",\"destinationType\":\"CIDR_BLOCK\",\"networkEntityId\":\"$IGW\"}]" \
  --force \
  --wait-for-state AVAILABLE
```

### 3.4 Security List (SSH + HTTP + HTTPS + ICMP)

> Port 18789 (OpenClaw gateway) is intentionally excluded — accessed via SSH tunnel only.

```bash
export SL=$(oci network security-list list \
  --compartment-id $TENANCY \
  --vcn-id $VCN \
  --query 'data[0].id' --raw-output)

oci network security-list update \
  --security-list-id $SL \
  --ingress-security-rules '[
    {"protocol":"6","source":"0.0.0.0/0","tcpOptions":{"destinationPortRange":{"min":22,"max":22}},"isStateless":false,"description":"SSH"},
    {"protocol":"6","source":"0.0.0.0/0","tcpOptions":{"destinationPortRange":{"min":80,"max":80}},"isStateless":false,"description":"HTTP"},
    {"protocol":"6","source":"0.0.0.0/0","tcpOptions":{"destinationPortRange":{"min":443,"max":443}},"isStateless":false,"description":"HTTPS"},
    {"protocol":"1","source":"0.0.0.0/0","isStateless":false,"description":"ICMP"}
  ]' \
  --force \
  --wait-for-state AVAILABLE
```

### 3.5 Public Subnet

```bash
export SUBNET=$(oci network subnet create \
  --compartment-id $TENANCY \
  --vcn-id $VCN \
  --cidr-block "10.0.0.0/24" \
  --display-name "openclaw-subnet" \
  --dns-label "openclawsub" \
  --availability-domain "$AD" \
  --wait-for-state AVAILABLE \
  --query 'data.id' --raw-output)
echo "SUBNET: $SUBNET"
```

---

## Phase 4 — Launch A1 ARM Instance

💻 **Local terminal** — all steps in this phase

### 4.1 Generate SSH key (skip if exists)

```bash
ssh-keygen -t rsa -b 4096 -f ~/.ssh/oci_key -N "" -C "openclaw@oci"
```

### 4.2 Get Ubuntu 24.04 ARM image

```bash
export IMAGE=$(oci compute image list \
  --compartment-id $TENANCY \
  --shape VM.Standard.A1.Flex \
  --operating-system "Canonical Ubuntu" \
  --operating-system-version "24.04" \
  --query 'data[0].id' --raw-output)
echo "IMAGE: $IMAGE"
```

### 4.3 Launch instance (full Always Free: 4 OCPU / 24 GB)

```bash
export SSH_KEY=$(cat ~/.ssh/oci_key.pub)

export INSTANCE=$(oci compute instance launch \
  --compartment-id $TENANCY \
  --availability-domain "$AD" \
  --display-name "openclaw" \
  --shape "VM.Standard.A1.Flex" \
  --shape-config '{"ocpus":4,"memoryInGBs":24}' \
  --image-id $IMAGE \
  --subnet-id $SUBNET \
  --assign-public-ip true \
  --metadata "{\"ssh_authorized_keys\":\"$SSH_KEY\"}" \
  --boot-volume-size-in-gbs 50 \
  --query 'data.id' --raw-output)
echo "INSTANCE: $INSTANCE"
```

> If you get `Out of host capacity`: try off-peak hours or a different availability domain.

> **🚨 WORKSHOP RISK:** Always Free A1 instances have limited capacity per region. For workshops with 20+ participants:
> - **Prepare backup regions:** us-ashburn-1, eu-frankfurt-1, ap-tokyo-1
> - **Test 24h before:** Run `oci compute instance launch --dry-run` to verify capacity
> - **Fallback plan:** Have participants share instances (2-3 people per A1) or use Cloudflare Tunnel demo mode

### 4.4 Wait for RUNNING

```bash
for i in {1..12}; do
  STATE=$(oci compute instance get \
    --instance-id $INSTANCE \
    --query 'data."lifecycle-state"' --raw-output)
  echo "$(date +%H:%M:%S) $STATE"
  [ "$STATE" = "RUNNING" ] && break
  sleep 10
done
```

### 4.5 Get public IP

```bash
export PUBLIC_IP=$(oci compute instance list-vnics \
  --instance-id $INSTANCE \
  --query 'data[0]."public-ip"' --raw-output)
echo "Public IP: $PUBLIC_IP"
```

### 4.6 Verify SSH access

```bash
ssh -i ~/.ssh/oci_key -o StrictHostKeyChecking=no ubuntu@$PUBLIC_IP \
  "uname -m && cat /etc/os-release | grep PRETTY"
# Expected: aarch64 / Ubuntu 24.04
```

---

## Phase 5 — Install OpenClaw

### 5.1 System update
💻 **Local terminal**

```bash
ssh -i ~/.ssh/oci_key ubuntu@$PUBLIC_IP \
  "sudo apt-get update && sudo apt-get upgrade -y"
```

### 5.2 Install Node.js 22
💻 **Local terminal**

```bash
ssh -i ~/.ssh/oci_key ubuntu@$PUBLIC_IP << 'EOF'
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt-get install -y nodejs
node --version && npm --version
EOF
```

### 5.3 Configure npm user-local prefix (no sudo needed)
💻 **Local terminal**

```bash
ssh -i ~/.ssh/oci_key ubuntu@$PUBLIC_IP << 'EOF'
mkdir -p ~/.npm-global
npm config set prefix ~/.npm-global
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc
# Reload PATH for current session
export PATH=~/.npm-global/bin:$PATH
EOF
```

> Note: `~/.bashrc` changes only take effect on next login. We export PATH manually for the current session.

### 5.4 Install OpenClaw
💻 **Local terminal**

```bash
ssh -i ~/.ssh/oci_key ubuntu@$PUBLIC_IP \
  "npm install -g openclaw@latest"
```

### 5.5 Run onboarding wizard
🔒🖥️ **Remote SSH (live terminal)** — interactive TUI, cannot be scripted

```bash
# SSH in directly — must be a real terminal session
ssh -i ~/.ssh/oci_key ubuntu@$PUBLIC_IP

# Then on the remote server:
openclaw onboard --install-daemon
```

During the wizard:
- Select AI provider → **OpenRouter**
- Enter your OpenRouter API key → saved automatically to `~/.openclaw/gateway.env`
- Select **install as daemon** → registers the systemd user service

### 5.6 Verify gateway binding
💻 **Local terminal**

```bash
ssh -i ~/.ssh/oci_key ubuntu@$PUBLIC_IP "ss -tlnp | grep 18789"
# Must show 127.0.0.1:18789 — NOT 0.0.0.0:18789

ssh -i ~/.ssh/oci_key ubuntu@$PUBLIC_IP \
  "systemctl --user status openclaw-gateway --no-pager"
```

### 5.7 Get your gateway token
💻 **Local terminal**

```bash
ssh -i ~/.ssh/oci_key ubuntu@$PUBLIC_IP \
  "python3 -c \"import json; d=json.load(open('/home/ubuntu/.openclaw/openclaw.json')); print(d['gateway']['auth']['token'])\""
```

Save this token — needed to access the OpenClaw UI.

---

## Phase 6 — SSH Tunnel (local browser access)

💻 **Local terminal**

Port 18789 is never exposed to the internet. All access goes through SSH tunnel.

```bash
# Open tunnel
# Local 16789 → remote 18789
# (use 16789 if 18789 is already in use locally)
ssh -i ~/.ssh/oci_key \
  -L 16789:localhost:18789 \
  -N -f \
  ubuntu@$PUBLIC_IP
```

🌐 **Browser** → open:
```
http://localhost:16789/?token=<your-gateway-token>
```

### Persistent tunnel with autossh (recommended)
💻 **Local terminal**

```bash
autossh -M 0 \
  -i ~/.ssh/oci_key \
  -L 16789:localhost:18789 \
  -N -f \
  -o "ServerAliveInterval=30" \
  -o "ServerAliveCountMax=3" \
  ubuntu@$PUBLIC_IP
```

### SSH config shortcut
💻 **Local terminal** — add to `~/.ssh/config`:

```
Host openclaw-oci
  HostName <PUBLIC_IP>
  User ubuntu
  IdentityFile ~/.ssh/oci_key
  LocalForward 16789 localhost:18789
  ServerAliveInterval 30
```

Then just run: `ssh -N -f openclaw-oci`

---

## Phase 7 — OS Firewall

💻 **Local terminal**

```bash
ssh -i ~/.ssh/oci_key ubuntu@$PUBLIC_IP << 'EOF'
sudo iptables -I INPUT 6 -m state --state NEW -p tcp --dport 80 -j ACCEPT
sudo iptables -I INPUT 6 -m state --state NEW -p tcp --dport 443 -j ACCEPT
sudo netfilter-persistent save
EOF
```

---

## Phase 8 — Slack Integration

Two options depending on your use case:

| Mode | Best for | How |
|---|---|---|
| **Socket Mode** | Production — no public URL needed | Slack connects outbound to your server |
| **Cloudflare Tunnel** | Demo — quick setup, free | Exposes a public URL without opening ports |

### Option A: Slack Socket Mode (recommended for production)

> **Before you start:** After completing 8.1–8.6, run the post-setup fix in 8.7 immediately.
> Skipping it means the bot will appear connected but silently ignore all messages.

#### 8.1 Create Slack App
🌐 **Browser** → api.slack.com/apps → **Create New App** → **From scratch**

- App Name: `OpenClaw`
- Pick your Slack workspace

#### 8.2 Enable Socket Mode
🌐 **Browser** → Your app → **Socket Mode** → Enable → Generate app-level token
- Token name: `openclaw-socket`
- Scope: `connections:write`
- Copy the `xapp-...` token

#### 8.3 Add Bot Token Scopes
🌐 **Browser** → Your app → **OAuth & Permissions** → Bot Token Scopes → Add:

```
chat:write
app_mentions:read
channels:history
groups:history
im:history
im:read
im:write
```

> **Why `im:write` and `im:read`?** Without these, the bot silently fails on DM replies with `missing_scope` errors.
> Always add the full list above — adding scopes later requires reinstalling the app and getting a new `xoxb-` token.

#### 8.4 Enable Event Subscriptions
🌐 **Browser** → Your app → **Event Subscriptions** → Enable

Subscribe to bot events:
```
app_mention
message.channels
message.im
```

#### 8.5 Install app to workspace
🌐 **Browser** → Your app → **OAuth & Permissions** → **Install to Workspace**

Copy the **Bot User OAuth Token** (`xoxb-...`)

#### 8.6 Configure OpenClaw with Slack credentials
🔒 **Remote SSH**

```bash
ssh -i ~/.ssh/oci_key ubuntu@$PUBLIC_IP

# Add tokens to gateway env
echo 'SLACK_BOT_TOKEN=xoxb-<your-bot-token>' >> ~/.openclaw/gateway.env
echo 'SLACK_APP_TOKEN=xapp-<your-app-token>' >> ~/.openclaw/gateway.env

# Restart gateway to pick up new env
systemctl --user restart openclaw-gateway
sleep 2

# Verify restart success
systemctl --user is-active openclaw-gateway || echo "⚠️ Restart failed! Check logs: journalctl --user -u openclaw-gateway"
```

#### 8.7 Post-setup fix — open groupPolicy and enable allowBots
🔒 **Remote SSH**

> **Critical step.** Without this, the bot connects successfully but ignores all messages.
> OpenClaw defaults to `groupPolicy: allowlist` (empty) which silently drops everything.

```bash
ssh -i ~/.ssh/oci_key ubuntu@$PUBLIC_IP

python3 -c "
import json

with open('/home/ubuntu/.openclaw/openclaw.json', 'r') as f:
    config = json.load(f)

config['channels']['slack']['accounts']['default']['groupPolicy'] = 'open'
config['channels']['slack']['accounts']['default']['allowBots'] = True
config['channels']['slack']['accounts']['default']['requireMention'] = False

with open('/home/ubuntu/.openclaw/openclaw.json', 'w') as f:
    json.dump(config, f, indent=4)

print('Done')
"

systemctl --user restart openclaw-gateway
sleep 5
openclaw channels status --probe
```

Expected output:
```
- Slack default: enabled, configured, running, bot:config, app:config, works
```

> **groupPolicy values:** `open` (anyone in workspace) | `allowlist` (specific users only) | `disabled`
> Do NOT use `allowall` — it is not a valid value and will break the config.

#### 8.8 Run doctor to fix any config structure issues
🔒 **Remote SSH**

> OpenClaw may migrate config structure after `channels add`. Run doctor to clean it up.

```bash
openclaw doctor --fix
```

#### 8.9 Invite bot to channel
🌐 **Browser / Slack app**

In your Slack workspace, in the target channel:
```
/invite @<your-bot-name>
```

#### 8.10 Verify
🌐 **Browser / Slack app**

Mention the bot in the channel:
```
@<your-bot-name> hello
```

---

### Option B: Cloudflare Tunnel (demo / quick setup)

🔒 **Remote SSH**

```bash
ssh -i ~/.ssh/oci_key ubuntu@$PUBLIC_IP

# Install cloudflared
curl -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64 \
  -o /usr/local/bin/cloudflared
chmod +x /usr/local/bin/cloudflared

# Start tunnel — gives you a public HTTPS URL
cloudflared tunnel --url http://localhost:18789
# Copy the https://xxx.trycloudflare.com URL
```

🌐 **Browser** → Your Slack App → **Event Subscriptions** → Request URL:
```
https://xxx.trycloudflare.com/slack/events
```

> Note: Cloudflare Tunnel URL changes every time. Use Socket Mode for anything persistent.

---

## Phase 9 — Enterprise Operations (Optional but Recommended)

For production or long-running deployments, add these operational safeguards.

### 9.1 Monitoring & Logs
🔒 **Remote SSH**

```bash
# View OpenClaw gateway logs in real-time
ssh -i ~/.ssh/oci_key ubuntu@$PUBLIC_IP \
  "journalctl --user -u openclaw-gateway -f"

# Check last 100 lines of logs
ssh -i ~/.ssh/oci_key ubuntu@$PUBLIC_IP \
  "journalctl --user -u openclaw-gateway --no-pager -n 100"
```

### 9.2 Backup Strategy
💻 **Local terminal** — backup to your machine

```bash
# Create timestamped backup directory
BACKUP_DIR="~/openclaw-backups/$(date +%Y%m%d-%H%M%S)"
mkdir -p $BACKUP_DIR

# Backup OpenClaw config and memory
scp -i ~/.ssh/oci_key -r \
  ubuntu@$PUBLIC_IP:~/.openclaw/* \
  $BACKUP_DIR/

echo "Backed up to: $BACKUP_DIR"
```

🔒 **Remote SSH** — automated daily backup on server

```bash
ssh -i ~/.ssh/oci_key ubuntu@$PUBLIC_IP << 'EOF'
# Create backup script
mkdir -p ~/backups
cat > ~/backup-openclaw.sh << 'BACKUP_EOF'
#!/bin/bash
BACKUP_DIR="$HOME/backups/$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"
cp -r ~/.openclaw/* "$BACKUP_DIR/" 2>/dev/null || true
# Keep only last 10 backups
ls -t ~/backups | tail -n +11 | xargs -r rm -rf
BACKUP_EOF

chmod +x ~/backup-openclaw.sh

# Add to crontab (daily at 2 AM)
(crontab -l 2>/dev/null; echo "0 2 * * * ~/backup-openclaw.sh") | crontab -
EOF
```

### 9.3 Auto Security Updates
🔒 **Remote SSH**

```bash
ssh -i ~/.ssh/oci_key ubuntu@$PUBLIC_IP << 'EOF'
# Install unattended-upgrades
sudo apt-get install -y unattended-upgrades

# Configure automatic security updates
sudo dpkg-reconfigure -plow unattended-upgrades

# Verify configuration
cat /etc/apt/apt.conf.d/50unattended-upgrades | grep -A5 "Unattended-Upgrade::Allowed-Origins"
EOF
```

> **Note:** OpenClaw updates must be done manually: `npm update -g openclaw`

### 9.4 Slack Token Rotation (Security Best Practice)
🔒 **Remote SSH**

When you need to rotate compromised or expired tokens:

```bash
ssh -i ~/.ssh/oci_key ubuntu@$PUBLIC_IP

# 1. Generate new tokens in Slack App (api.slack.com/apps)
# 2. Update environment variables
sed -i 's/SLACK_BOT_TOKEN=.*/SLACK_BOT_TOKEN=xoxb-<new-token>/' ~/.openclaw/gateway.env
sed -i 's/SLACK_APP_TOKEN=.*/SLACK_APP_TOKEN=xapp-<new-token>/' ~/.openclaw/gateway.env

# 3. Restart gateway
systemctl --user restart openclaw-gateway

# 4. Verify new tokens are active
systemctl --user status openclaw-gateway --no-pager
```

### 9.5 Capacity Planning — Always Free Limits
| Resource | Free Tier Limit | Warning Threshold |
|----------|----------------|-------------------|
| A1 ARM OCPUs | 4 total | Monitor with: `oci compute instance list` |
| Memory | 24 GB total | Check: `free -h` |
| Storage | 200 GB boot volumes | Monitor: `df -h` |
| Network | 10 TB/month | Usually not a concern for bots |

**Monitor usage:**
```bash
ssh -i ~/.ssh/oci_key ubuntu@$PUBLIC_IP "free -h && df -h"
```

---

## Known Gotchas

| Issue | Fix |
|---|---|
| `--wait-for-state` not available on `instance get` | Poll with a loop — see Phase 4.4 |
| `--ssh-authorized-keys` flag doesn't exist | Use `--metadata '{"ssh_authorized_keys":"..."}'` |
| Region subscription via CLI fails | Use OCI Console UI — see Phase 2.2 |
| `systemctl status openclaw` fails | User-level service: `systemctl --user status openclaw-gateway` |
| npm install with sudo | Unnecessary — configure user-local prefix first (Phase 5.3) |
| API key not reaching gateway | Check `~/.openclaw/gateway.env` — onboarding writes it there |
| Gateway token not shown during onboarding | Read from `~/.openclaw/openclaw.json` → `gateway.auth.token` (Phase 5.7) |
| Local port 18789 already in use | Use a different local port: `-L 16789:localhost:18789` |
| Onboarding is TUI-only | Must SSH in with a live terminal — cannot use heredoc or script |
| Bot connected but no response in Slack | Default `groupPolicy` is `allowlist` (empty) — silently drops all messages. Fix: set to `open` in `openclaw.json` and restart gateway (Phase 8.7) |
| `--group-policy` flag doesn't exist on `channels add` | Edit `groupPolicy` directly in `~/.openclaw/openclaw.json` — valid values: `open`, `allowlist`, `disabled` |
| Slack Accounts empty in web UI after `channels add` | Run `openclaw doctor --fix` — it migrates the config structure to `accounts.default` automatically |
| App name doesn't matter | Slack app display name can be anything (e.g. `<your-app-name>`). OpenClaw only uses the tokens, not the name. Use `@<bot-username>` to mention it in Slack |
| `missing_scope` error in logs — bot connects but DMs get no reply | Bot token is missing `im:write`, `im:read`, and/or `im:history`. Add all scopes from Phase 8.3, then **reinstall the app** in OAuth & Permissions → Install to Workspace to get a fresh `xoxb-` token. Update `openclaw.json` botToken directly and restart: `systemctl --user restart openclaw-gateway` |
| Bot only responds when @mentioned, ignores DMs and channel messages | `requireMention` defaults to `true`. Set it to `false` in the Phase 8.7 fix (already included in the script above) |

---

## Cleanup

💻 **Local terminal**

**⚠️ Deletion order matters!** Dependencies must be removed before parents.

```bash
# Step 1: Terminate the VM (releases boot volume, VNIC, public IP)
oci compute instance terminate --instance-id $INSTANCE --force

# Wait for instance to fully terminate (usually 30-60 seconds)
sleep 30

# Step 2: Delete subnet (depends on: instance VNIC, route table association)
oci network subnet delete --subnet-id $SUBNET --force

# Step 3: Delete Internet Gateway (depends on: route table rules)
oci network internet-gateway delete --ig-id $IGW --force

# Step 4: Delete VCN (depends on: all child resources removed above)
oci network vcn delete --vcn-id $VCN --force

# Verify cleanup
oci compute instance get --instance-id $INSTANCE 2>&1 | grep -i "not found"
echo "Cleanup complete if you see 'NotAuthorizedOrNotFound' above"
```

> **Workshop Tip:** If cleanup fails due to dependencies, run `oci network vcn delete --vcn-id $VCN --force --wait-for-state TERMINATED` and it will cascade-delete remaining resources.
