---
name: claw-index
description: Index of open-source AI agent frameworks — OpenClaw, NemoClaw, and Hermes Agent — covering gateway-first, security-first, and agent-first approaches.
---

# Claw — Open-Source AI Agent Frameworks

This folder documents the three major open-source AI agent frameworks in the 2026 landscape. Each takes a different approach to the same problem: giving individuals and small teams autonomous AI agents that run on their own infrastructure.

## The Three Frameworks

| Framework | Approach | Created by | Best for |
|-----------|----------|------------|----------|
| [**OpenClaw**](openclaw/) | Gateway-first | Open-source community | Channel routing, integrations, rapid deployment |
| [**NemoClaw**](nemoclaw/) | Security-first | NVIDIA | Enterprise security, sandboxed execution, policy guardrails |
| [**Hermes Agent**](hermes-agent/) | Agent-first | Nous Research | Self-improving agents, persistent skill memory, learning loops |

## How They Relate

```
                    ┌─────────────────┐
                    │  Hermes Agent   │
                    │  (agent-first)  │
                    │  Self-improving  │
                    │  skill memory    │
                    └────────┬────────┘
                             │ planned integration
                             ▼
┌─────────────┐    ┌─────────────────┐
│  OpenClaw   │───▶│   NemoClaw      │
│  (gateway)  │    │  (security      │
│  Routing,   │    │   wrapper)      │
│  channels   │    │  NVIDIA NIM     │
└─────────────┘    └─────────────────┘
```

- **OpenClaw** is the foundation — a gateway that routes messages across channels (Slack, Discord, CLI) to LLM providers
- **NemoClaw** wraps OpenClaw with NVIDIA's security layer — deny-by-default egress, sandboxed config, policy-based guardrails, managed inference via Nemotron
- **Hermes Agent** is agent-first — it autonomously plans, executes, learns, and builds a persistent skill library. NemoClaw has announced plans to integrate it as an additional agent type

## Which One to Use

| You want... | Use |
|-------------|-----|
| Quick deployment on cheap infrastructure (OCI Always Free, $5 VPS) | **OpenClaw** |
| Enterprise-grade security with NVIDIA infrastructure | **NemoClaw** |
| An agent that learns from experience and improves over time | **Hermes Agent** |
| All three — gateway routing + security + self-improvement | **NemoClaw + Hermes Agent** (when integration ships) |

## Solo Unicorn Builder Context

This project uses **OpenClaw on OCI Always Free** (A1 ARM64, 4 OCPU / 24 GB) with Slack Socket Mode as the primary agent deployment. See [openclaw/](openclaw/) for deployment guides, SSH tunnel setup, and production configuration.

Hermes Agent's 4 GB minimum RAM fits within the same OCI allocation, making it a viable complement or alternative for users who want self-improving agent behavior on free-tier infrastructure.

## Contents

- [`openclaw/`](openclaw/) — Deployment guides, OCI instructions, SSH tunnel setup, product docs
- [`nemoclaw/`](nemoclaw/) — Remote server installation guide
- [`hermes-agent/`](hermes-agent/) — Framework overview, architecture, comparison with OpenClaw/NemoClaw
