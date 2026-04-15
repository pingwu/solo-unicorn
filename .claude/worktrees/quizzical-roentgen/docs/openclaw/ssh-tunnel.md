# SSH Tunneling for OpenClaw Gateway

## Why SSH Tunnel Instead of Open Port

OpenClaw's gateway runs on port **18789**. Exposing this port publicly would allow:
- Unauthorized access to your AI gateway
- Brute-force or API abuse from the internet
- Potential data exfiltration through the gateway

**SSH tunneling solves this** — port 18789 is bound only to `localhost` on the OCI instance.
It is never listed in the OCI security list or iptables. Access is only possible through
an authenticated SSH connection.

```
INSECURE (don't do this):          SECURE (SSH tunnel):
Internet ──► port 18789 (open)     Internet ──► port 22 (SSH only)
                                               └─► tunnel ──► localhost:18789
```

---

## Security List Configuration

**Do NOT add port 18789 to the OCI security list.**

Only these ports should be open:

| Port | Protocol | Purpose |
|------|----------|---------|
| 22   | TCP | SSH (required for tunnel) |
| 80   | TCP | HTTP (optional, for future web UI) |
| 443  | TCP | HTTPS (optional, for future web UI) |
| ICMP | —  | Ping/diagnostics |

Port 18789 stays **closed** to the internet.

---

## iptables on the OCI Instance

Ensure port 18789 is NOT opened in the OS firewall.
OpenClaw should bind to `127.0.0.1:18789`, not `0.0.0.0:18789`.

Verify after OpenClaw starts:

```bash
ssh -i ~/.ssh/oci_key ubuntu@$PUBLIC_IP \
  "ss -tlnp | grep 18789"
# Should show: 127.0.0.1:18789  (local only — correct)
# NOT:         0.0.0.0:18789    (would mean exposed — bad)
```

---

## Using the SSH Tunnel

### Option A: One-time tunnel (manual)

Opens a tunnel, keeps it alive while you work:

```bash
ssh -i ~/.ssh/oci_key \
    -L 16789:localhost:18789 \
    -N -f \
    ubuntu@$PUBLIC_IP
```

| Flag | Meaning |
|------|---------|
| `-L 16789:localhost:18789` | Forward local port 18789 to remote localhost:18789 |
| `-N` | Don't execute a remote command (tunnel only) |
| `-f` | Run in background |

Then access OpenClaw at `http://localhost:16789` on your Mac.

Close the tunnel when done:
```bash
pkill -f "ssh.*16789"
```

### Option B: Persistent tunnel with autossh (recommended)

Automatically reconnects if the tunnel drops:

```bash
# Install autossh
brew install autossh

# Start persistent tunnel
autossh -M 0 \
  -i ~/.ssh/oci_key \
  -L 16789:localhost:18789 \
  -N -f \
  -o "ServerAliveInterval=30" \
  -o "ServerAliveCountMax=3" \
  ubuntu@$PUBLIC_IP
```

### Option C: SSH config shortcut (most convenient)

Add to `~/.ssh/config`:

```
Host openclaw
  HostName <PUBLIC_IP>
  User ubuntu
  IdentityFile ~/.ssh/oci_key
  LocalForward 16789 localhost:18789
  ServerAliveInterval 30
  ServerAliveCountMax 3
```

Then connect with just:
```bash
ssh -N -f openclaw          # tunnel only (background)
ssh openclaw                # interactive shell + tunnel
```

---

## Verify the Tunnel is Working

```bash
# 1. Start the tunnel
ssh -i ~/.ssh/oci_key -L 16789:localhost:18789 -N -f ubuntu@$PUBLIC_IP

# 2. Check tunnel is listening locally
lsof -i :16789
# Should show: ssh ... TCP localhost:18789 (LISTEN)

# 3. Test OpenClaw gateway
curl -s http://localhost:16789/health
```

---

## iOS / Mobile Access via Tailscale (Optional)

If you need to access OpenClaw from your phone without being on the same network:

1. Install [Tailscale](https://tailscale.com) on your Mac and phone
2. The SSH tunnel on your Mac exposes `localhost:18789`
3. Use Tailscale's subnet routing or the OpenClaw mobile app's built-in connection

This avoids exposing port 18789 even within Tailscale — your Mac acts as the secure relay.

---

## launchd Service for Auto-Start on Mac (Optional)

To start the SSH tunnel automatically when your Mac boots:

```bash
cat > ~/Library/LaunchAgents/com.openclaw.tunnel.plist << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>com.openclaw.tunnel</string>
  <key>ProgramArguments</key>
  <array>
    <string>/usr/bin/ssh</string>
    <string>-i</string>
    <string>~/.ssh/oci_key</string>
    <string>-L</string>
    <string>16789:localhost:18789</string>
    <string>-N</string>
    <string>-o</string>
    <string>ServerAliveInterval=30</string>
    <string>-o</string>
    <string>ServerAliveCountMax=3</string>
    <string>ubuntu@PUBLIC_IP_HERE</string>
  </array>
  <key>RunAtLoad</key>
  <true/>
  <key>KeepAlive</key>
  <true/>
  <key>StandardErrorPath</key>
  <string>/tmp/openclaw-tunnel.log</string>
</dict>
</plist>
EOF

# Replace PUBLIC_IP_HERE with actual IP, then load
launchctl load ~/Library/LaunchAgents/com.openclaw.tunnel.plist
```

---

## Summary

| What                            | Decision                                |
| ------------------------------- | --------------------------------------- |
| Port 18789 in OCI security list | ❌ Never open                            |
| Port 18789 in iptables          | ❌ Never open                            |
| OpenClaw bind address           | `127.0.0.1:18789` only                  |
| Access method                   | SSH tunnel (`-L 16789:localhost:18789`) |
| Recommended tunnel tool         | `autossh` for reliability               |
| Mac auto-start                  | launchd plist                           |
