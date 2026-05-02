# OpenClaw on OCI — Documentation

Deployment, configuration, and integration documentation for running OpenClaw on OCI Always Free A1 ARM.

Tested on us-chicago-1 (ORD), VM.Standard.A1.Flex 4 OCPU / 24 GB.

## Files

| File | Contents |
|---|---|
| `openclaw-deploy-to-oci-instructions.md` | **Primary runbook** — Phases 1–9, environment-labelled, all gotchas included |
| `ssh-tunnel.md` | SSH tunnel guide — why the gateway port is never exposed, how to set up secure local access |
| `product/solo-unicorn-product-brief.md` | Solo-Unicorn platform concept + WRITITATION™ positioning |
| `product/proposal-evaluation.md` | OpenClaw security scanner proposals — evaluation by business/tech/security merit |

## Key Lessons Learned

- A1 capacity: us-chicago-1 (ORD) tends to have more availability than other regions
- Free Trial accounts can only subscribe to 1 region via CLI — use Console UI or upgrade to PAYG first
- `groupPolicy` defaults to `allowlist` (empty) — must set to `open` or the bot silently ignores all messages
- Bot token needs `im:write` + `im:read` + `im:history` or DM replies fail with `missing_scope`
- Set `requireMention: false` for the bot to respond without an @mention
- If the gateway port is already in use locally, use a different local port for the SSH tunnel (e.g. `16789` instead of `18789`)
