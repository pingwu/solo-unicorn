---
name: onboarding
description: Start-here orientation for new human contributors to Solo Unicorn Builder — the mental model, where things live, setup path, and who to ask. Not loaded by AI agents.
---

# ONBOARDING.md — Start Here (Humans)

This is the map for people, not agents. AI agents read [CLAUDE.md](CLAUDE.md) /
[GEMINI.md](GEMINI.md) / [AGENTS.md](AGENTS.md) instead.

## Mental Model

Solo Unicorn Builder is an **agent harness**: a command-center repo that gives AI
agents the skills, rules, and your personal context to operate as your whole team
across functions you've never shipped before. Three layers:

- **Skills** (`skills/`) — what the AI can do (structured prompting patterns).
- **Instructions** — how the AI behaves (this repo's rules + anchor).
- **Knowledge** (`../my_knowledge/`) — what the AI knows about *you* (the layer only you build).

Your code lives in `../my_projects/`. Your private notes live in `../my_knowledge/`.
Both sit *outside* this repo and get their own git repos.

## Where Things Live

| You want… | Go to |
|-----------|-------|
| The pitch / overview | [README.md](README.md) |
| First-time setup | [INIT_UNICORN.md](INIT_UNICORN.md) |
| Tooling to install | [PREREQUISITES.md](PREREQUISITES.md) |
| The rules agents follow | [UNICORN_CONSTITUTION.md](UNICORN_CONSTITUTION.md) + [ANCHOR.md](ANCHOR.md) |
| Coding principles | [DEVELOPMENT-STANDARDS.md](DEVELOPMENT-STANDARDS.md) |
| Why this exists / philosophy | [docs/philosophy.md](docs/philosophy.md), [docs/context-engineering.md](docs/context-engineering.md) |
| How to contribute a skill | [CONTRIBUTING.md](CONTRIBUTING.md) → [docs/contributing.md](docs/contributing.md) |
| Agent reference & sandbox | [docs/coding-agents.md](docs/coding-agents.md), [docs/local-sandbox.md](docs/local-sandbox.md) |

## Setup Path

1. Install prerequisites — [PREREQUISITES.md](PREREQUISITES.md) (TL;DR: just Docker Desktop).
2. Run first-time setup — [INIT_UNICORN.md](INIT_UNICORN.md) (skill symlinks, vault, dev container).
3. Build something — copy a `template_projects/` starter into `../my_projects/` and start the container.

## Who to Ask

- Questions & success stories: [GitHub Discussions](https://github.com/pingwu/solo-unicorn/discussions)
- Conduct: [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)
