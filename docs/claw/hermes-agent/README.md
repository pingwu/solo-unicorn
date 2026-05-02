---
name: hermes-agent
description: Overview of Hermes Agent — Nous Research's self-improving open-source AI agent framework with persistent skill memory and multi-platform messaging.
---

# Hermes Agent

Hermes Agent is an open-source, self-improving AI agent framework created by **Nous Research**. First released in February 2026, it is described as "the agent that grows with you."

- **GitHub:** [NousResearch/hermes-agent](https://github.com/nousresearch/hermes-agent)
- **Docs:** [hermes-agent.nousresearch.com](https://hermes-agent.nousresearch.com/)
- **License:** Apache 2.0
- **Latest:** v0.10.0 (April 2026) — 180+ commits, 118 bundled skills, 6 messaging integrations

## What Makes It Different

The core differentiator is a **built-in learning loop**. The agent creates skills from experience, refines them through continued use, and builds a persistent model of the user across sessions.

### Task Execution Flow

1. Receives a natural-language goal
2. Breaks it into steps
3. Selects from 40+ built-in tools
4. Iterates until the task is complete

### Three-Layer Memory

| Layer | What it stores | Persistence |
|-------|---------------|-------------|
| **Session** | Current conversation context | Single session |
| **Persistent** | Facts, preferences, learned context | Across sessions |
| **Skill** | Reusable solutions from past tasks | Permanent (SQLite + FTS5) |

### GEPA — Self-Improvement Engine

- Accepted as an **ICLR 2026 Oral** paper
- Reads execution traces and evaluates objective metrics independently
- Agents with 20+ self-generated skills reported **40% faster** on repeated tasks
- Companion repo: [hermes-agent-self-evolution](https://github.com/NousResearch/hermes-agent-self-evolution)

## Architecture

```
User Message (15+ platforms)
       |
   Gateway (routing layer)
       |
   Agent Core (planning + tool selection)
       |
   +---+---+---+
   |   |   |   |
 Tools Skills Memory
 (40+) (SQLite) (3 layers)
       |
   Terminal Backend
   (local / Docker / SSH / Daytona / Singularity / Modal)
       |
   LLM Provider (model-agnostic)
```

## Model Independence

No vendor lock-in. Supports:
- Nous Portal, OpenRouter (200+ models), NVIDIA NIM (Nemotron)
- OpenAI, Hugging Face, Xiaomi MiMo, z.ai/GLM, Kimi/Moonshot, MiniMax
- Any custom OpenAI-compatible endpoint
- Switch models with `hermes model` — no code changes

## Messaging Integrations

CLI, Telegram, Discord, Slack, WhatsApp, Signal, Matrix, Mattermost, Email, SMS, DingTalk, Feishu, WeCom, BlueBubbles, Home Assistant

## Resource Requirements

- Minimum: 4 GB RAM (8 GB recommended)
- Deployable on a $5/month VPS
- Fits within OCI A1 Flex Always Free allocation (4 OCPU / 24 GB)

## Relationship to OpenClaw and NemoClaw

| | Hermes Agent | OpenClaw | NemoClaw |
|---|---|---|---|
| **Philosophy** | Agent-first, learning loop | Gateway-first, channel routing | Security-first reference stack |
| **Strength** | Self-improvement, skill generation | Integrations, speed to deploy | Enterprise security, sandboxing |
| **Created by** | Nous Research | Open-source community | NVIDIA |

- NemoClaw wraps OpenClaw as a hardened deployment layer — not a replacement
- NemoClaw has announced plans to integrate Hermes Agent as an additional agent type
- Hermes Agent provides a [Migrate from OpenClaw](https://hermes-agent.nousresearch.com/docs/guides/migrate-from-openclaw) guide

## References

- [Hermes Agent GitHub](https://github.com/nousresearch/hermes-agent)
- [Hermes Agent Documentation](https://hermes-agent.nousresearch.com/docs/)
- [GEPA Self-Evolution Repo](https://github.com/NousResearch/hermes-agent-self-evolution)
- [awesome-hermes-agent](https://github.com/0xNyk/awesome-hermes-agent)
- [Open Source AI Agents 2026: OpenClaw vs Hermes vs NemoClaw](https://www.remoteopenclaw.com/blog/open-source-ai-agents-2026-comparison)
