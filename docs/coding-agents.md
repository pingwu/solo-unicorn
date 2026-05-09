---
name: coding-agents
description: Complete comparison guide for CLI coding agents — Claude Code, GitHub Copilot CLI, Gemini CLI, Kiro CLI, Kilo.ai CLI agents, Docker AI Agent Gordon, Codex CLI, OpenCode, and more. Solo Unicorn Builder prefers CLI agents for their ability to translate natural language into system commands.
---

# AI Coding Agents: Complete Comparison Guide

**For builders who want AI as a real development partner**

---

## Why CLI Coding Agents?

The magic of a CLI coding agent is its ability to **translate natural language into system command-line interface (CLI) commands** — and execute them.

You say: *"Set up a Docker container with Node 20, install dependencies, and start the dev server."*

The agent translates that into `docker compose up -d`, `npm install`, `npm run dev` — and runs it. No copy-pasting. No switching between a chat window and a terminal. The AI reads your project, understands the context, and operates your machine.

This is why **Solo Unicorn Builder prefers CLI coding agents**. They don't just suggest code — they execute workflows. They read your `SKILL.md` files, understand your project structure, run tests, manage Git, deploy containers, and orchestrate multi-file changes. All from natural language.

**IDE-based agents** (Copilot, Cursor) are great for real-time autocomplete while typing. But CLI agents are where AI becomes a true **operating partner** — not just a suggestion engine.

---

## What is an AI Coding Agent?

Think of an AI coding agent as a **smart assistant that helps you write, edit, and understand code**. Unlike traditional tools that just highlight syntax or check for errors, AI coding agents:

- **Understand what you're trying to build** (not just what you've written)
- **Suggest entire functions or files** (not just the next line)
- **Explain complex code in plain English** (or write code from your English description)
- **Execute system commands** from natural language instructions
- **Refactor across multiple files** (understanding your whole project)

**For non-coders:** Imagine having a translator who not only translates words but understands the context, suggests better phrasing, and can rewrite entire paragraphs to be clearer. That's what AI coding agents do for software.

**For coders:** It's like pair programming with a senior developer who's read your entire codebase and can suggest refactorings, catch bugs, write tests, and explain architectural decisions — and who can also run the commands for you.

---

## The Evolution: How We Got Here

### Phase 1: Code Completion (2021)
**Tool:** GitHub Copilot
**Capability:** Autocomplete the next line of code
**Like:** Predictive text on your phone, but for code

### Phase 2: Chat-Based Help (2023)
**Tool:** ChatGPT
**Capability:** Answer coding questions, generate code snippets
**Like:** Having an expert you can ask questions, but can't see your files

### Phase 3: Project-Aware CLI Agents (2024-2025)
**Tools:** Claude Code, Gemini CLI, GitHub Copilot CLI, Atlassian Rovo Dev CLI, LangChain DeepAgents, Kiro CLI, Kilo.ai CLI agents, Docker AI Agent Gordon, Codex CLI, OpenCode
**Capability:** Understand your entire project, execute commands, modify multiple files
**Like:** A senior developer who can both think and type — reading your codebase, running your tests, and shipping your code

### Phase 4: Agent Harnesses & Self-Hosted Frameworks (2025-2026)
**Tools:** OpenClaw, Hermes Agent, NemoClaw, Solo Unicorn Builder
**Capability:** Deploy your own agent infrastructure — persistent memory, skill libraries, multi-channel messaging (Slack, Discord, CLI), self-hosted on your own server or free-tier cloud
**Like:** Building your own AI team rather than renting one — you own the runtime, the skills, and the data

### Phase 5: Multi-Agent Systems (2026 and Emerging)
**Trend:** Using multiple AI agents for different tasks
**Capability:** One agent plans, another codes, another reviews
**Like:** A full development team, but AI

---

## CLI Agents (Recommended for Solo Unicorn Builder)

These agents run in your terminal and can **read, write, and execute** — the full development loop.

| Agent                  | Provider    | Installation                                                                      | Start Command       | Key Strength                                                                                                                    |
| ---------------------- | ----------- | --------------------------------------------------------------------------------- | ------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| **Claude Code**        | Anthropic   | `npm install -g @anthropic-ai/claude-code`                                        | `claude`            | **Best reasoning and code quality.** Deep project understanding, multi-file refactoring, architecture decisions.                |
| **GitHub Copilot CLI** | GitHub      | `npm install -g @github/copilot-cli`                                              | `gh copilot`        | **Natural language shell commands.** Translate English to CLI commands, explain code. Integrated with GitHub.                   |
| **Gemini CLI**         | Google      | `npm install -g @google/gemini-cli`                                               | `gemini`            | **Largest context window (1M+ tokens).** Multimodal — understands images, diagrams, screenshots alongside code.                 |
| **Atlassian Rovo**     | Atlassian   | `npm install -g @atlassian/rovo-dev`                                              | `rovo`              | **Jira & Confluence integration.** Specialized subagents, MCP support, and "shadow mode" for safe code testing.                 |
| **DeepAgents**         | LangChain   | `uv tool install deepagents-cli` (or `uv tool install 'deepagents-cli[openrouter]'` for OpenRouter)  | `deepagents`        | **Persistent memory & sandboxing.** Learns project conventions, supports remote sandboxes (Modal, Daytona), and MCP.             |
| **Kiro CLI**           | AWS         | See [kiro.dev/cli](https://kiro.dev/cli/)                                         | `kiro-cli`          | **Spec-driven development.** Turns prompts into structured requirements, then code. Deep AWS integration and DevOps automation. |
| **Kilo.ai CLI agents** | Kilo.ai     | See [kilo.ai](https://kilo.ai)                                                    | `kilo`              | **Agentic implementation workflows.** Useful for coordinating coding agents around tasks, code changes, and project execution. |
| **Docker Gordon**      | Docker      | Docker Desktop / Docker AI                                                        | Docker Desktop / `docker ai` | **Container-native assistance.** Helps explain Dockerfiles, Compose files, images, containers, and local dev environments. |
| **Codex CLI**          | OpenAI      | `npm install -g @openai/codex`                                                    | `codex`             | **OpenAI ecosystem.** Quick code generation, integrates with ChatGPT.                                                           |
| **OpenCode**           | Open Source | `brew install opencode-ai/tap/opencode` or see [opencode.ai](https://opencode.ai) | `opencode`          | **75+ model support.** Works with Claude, OpenAI, Gemini, and local models. Go-based TUI, LSP integration, vim-like editor.     |
| **Pi**                 | Open Source | `npm install -g @mariozechner/pi-coding-agent`                                    | `pi`                | **Minimal and yours.** Tree-structured sessions, 15+ providers, TypeScript extensions. Built for developers who want full control. |

### What CLI Agents Can Do That IDE Agents Can't

| Capability | CLI Agent | IDE Agent |
|---|---|---|
| Read and modify files | Yes | Yes |
| Execute shell commands | **Yes** | Limited |
| Run tests, builds, deployments | **Yes** | No |
| Manage Git (commit, push, PR) | **Yes** | Partial |
| Docker operations | **Yes** | No |
| AWS/GCP CLI commands | **Yes** | No |
| Read project configuration (SKILL.md, AGENTS.md) | **Yes** | Partial |
| Multi-turn workflows across tools | **Yes** | No |

---

## IDE Agents (Complementary)

These agents live inside your editor. Great for real-time autocomplete and inline edits, but they don't execute commands.

| Agent | Type | Installation | Key Strength |
|---|---|---|---|
| **VS Code** | Extensible IDE | Download from [code.visualstudio.com](https://code.visualstudio.com) | **Mainstream developer hub.** Works with Copilot, Continue, Cline/Roo-style agents, Docker, remote containers, and many AI extensions. |
| **Cursor** | AI-powered IDE | Download from [cursor.com](https://cursor.com) | **Complete AI editor.** VS Code fork with chat, multi-file editing, Cmd+K inline edits. |
| **GitHub Copilot** | IDE extension | VS Code / JetBrains extension | **Real-time autocomplete.** Best for day-to-day typing productivity. |
| **Kiro IDE** | AI-powered IDE | Download from [kiro.dev](https://kiro.dev) | **Spec-first development.** Generates requirements and design docs before code. VS Code fork. |
| **AntiGravity** | AI-powered IDE / agentic coding environment | See official AntiGravity docs/site | **Agentic IDE workflow.** Useful for builders who want an IDE-centered AI coding experience with deeper project context. |
| **Tabnine** | IDE extension | IDE extension — [tabnine.com](https://www.tabnine.com) | **On-premise options.** Code stays private, enterprise compliance. |

**Tip:** Use a CLI agent as your primary development partner and an IDE agent for real-time autocomplete. They complement each other.

---

## Detailed CLI Agent Profiles

### Claude Code - The Thoughtful Architect

**Official Docs:** https://docs.anthropic.com/en/docs/claude-code

**What makes it special:**
- **Best reasoning capabilities** among current agents
- **Reads your entire project** for context-aware suggestions
- **Multi-file refactoring** with preview before applying
- **Ctrl+G feature** - write long prompts in your text editor
- **Strong at code review** - catches subtle bugs and architecture issues
- **Executes commands** - runs tests, manages Git, deploys containers

**Best for:**
- Complex refactoring across multiple files
- Architectural decisions and code reviews
- Security-sensitive code
- Teaching and explaining code concepts

**Limitations:**
- Requires API key and internet connection
- Not free (pay per use via Anthropic API)
- No autocomplete while typing (pair with Copilot for that)

---

### GitHub Copilot CLI - The Command-Line Expert

**Official Docs:** https://gh.io/copilot-cli

**What makes it special:**
- **Natural language to shell commands** - translate English to bash, PowerShell, zsh commands
- **Command explanation** - ask what a complex command does and get a clear explanation
- **GitHub integration** - seamlessly works with GitHub repositories and pull requests
- **Lightweight CLI tool** - installs via `gh` extension, minimal overhead
- **Consistent Copilot experience** - same underlying models as Copilot IDE extension

**Best for:**
- Learning shell commands by describing what you want to do
- Understanding complex bash/PowerShell/zsh commands
- Developers who already use GitHub Copilot in their IDE
- Quick command generation without leaving the terminal
- Getting help with CLI operations in natural language

**Limitations:**
- Primary focus is shell commands, not code generation or refactoring
- Requires GitHub Copilot subscription
- Not designed for full project analysis or multi-file code changes
- More command-focused than architecture-focused

**Example usage:**
```bash
gh copilot suggest "recursively list all JavaScript files in src directory"
# Suggests: find src -name "*.js"

gh copilot explain "grep -r 'TODO' . | grep -v node_modules"
# Explains: Search for TODO comments in all files, excluding node_modules
```

---

### Gemini CLI - The Multimodal Expert

**Official Docs:** https://github.com/google-gemini/gemini-cli

**What makes it special:**
- **Largest context window** (1M+ tokens)
- **Multimodal** - understands images, diagrams, screenshots
- **Long-form analysis** - can analyze entire large codebases
- **Google integration** - works with Google Cloud Platform

**Best for:**
- Analyzing large, complex codebases
- Converting UI screenshots to code
- Understanding system architecture diagrams
- Projects with extensive documentation

**Limitations:**
- Newer tool, smaller community
- Requires Google account
- Less specialized for code than Claude Code

---

### Atlassian Rovo Dev CLI - The Enterprise Workflow Partner

**Official Docs:** https://support.atlassian.com/rovo/docs/use-rovo-dev-cli/

**What makes it special:**
- **Atlassian Ecosystem Integration** - Deeply integrated with Jira and Confluence for task management and project context.
- **Specialized Subagents** - Access to specialized AI agents for specific tasks like code refactoring, bug fixing, or documentation.
- **Model Context Protocol (MCP)** - Supports MCP servers for extensible context (e.g., fetching data from external APIs or databases).
- **Shadow Mode** - A safety feature that allows you to see what the agent *would* do before it makes any changes.
- **Enterprise-Ready** - Built for collaborative teams already using the Atlassian suite.

**Best for:**
- Teams using Jira for task tracking and Confluence for documentation.
- Developers who want task-specific subagents for specialized coding work.
- Enterprise workflows requiring high security and "shadow mode" validation.
- Complex projects that need to integrate external data via MCP.

**Limitations:**
- Requires an active Atlassian account with Rovo permissions.
- Best used within projects that are already tracked in Jira/Confluence.
- Newer addition to the CLI market.

**Example usage:**
```bash
rovo "Create a new branch for JIRA-123 and implement the search feature"
rovo "Refactor this component to use React hooks and update Confluence docs"
```

---

### LangChain DeepAgents CLI - The Memory-First Assistant

**Official Docs:** https://docs.langchain.com/oss/python/deepagents/cli/overview

**What makes it special:**
- **Persistent Memory** - Automatically learns and stores project conventions and architecture in local markdown files.
- **Remote Sandboxes** - Execute code in isolated environments like Modal, Daytona, or Runloop for added security and reproducibility.
- **Extensible with Skills & MCP** - Supports custom expert instructions (Skills) and Model Context Protocol tools.
- **Flexible Interaction** - Supports both interactive chat and non-interactive piping (e.g., `cat logs | deepagents "Fix this"`).
- **Human-in-the-Loop** - Built-in safeguards requiring user approval for destructive actions, with optional auto-approval.

**Best for:**
- Developers who want an agent that "gets" their specific coding style over time.
- Security-conscious workflows requiring isolated code execution (sandboxing).
- Complex, multi-step tasks that need robust todo tracking.
- Users who want to leverage the LangChain / Deep Agents ecosystem.

**Limitations:**
- Requires `uv` for installation.
- Newer ecosystem; documentation and community are growing.

**Installation:**
```bash
# Default install
uv tool install deepagents-cli

# With OpenRouter support (enables OpenRouter API key usage)
uv tool install 'deepagents-cli[openrouter]'
```

**Example usage:**
```bash
deepagents "Refactor the authentication module and update the unit tests"
cat error.log | deepagents -n "Explain and fix this error"
```

---

### Kiro CLI - The Spec-Driven Builder

**Official Docs:** https://kiro.dev/docs/cli/

**What makes it special:**
- **Spec-driven workflow** - turns natural language into structured requirements before writing code
- **AWS-native** - makes AWS CLI calls, manages cloud resources
- **DevOps automation** - install, configure, and deploy infrastructure from natural language
- **MCP server support** - extensible with Model Context Protocol tools
- **Powered by Claude** - uses Anthropic's frontier models under the hood

**Best for:**
- AWS infrastructure and DevOps workflows
- Spec-first development (requirements → design → code)
- Cloud resource management from the terminal
- Enterprise and production deployments

**Pricing:** Free tier (50 credits/mo), Pro $20/mo, Pro+ $40/mo, Power $200/mo

---

### Kilo.ai CLI Agents - The Agent Coordinator

**Official Site:** https://kilo.ai

**What makes it special:**
- **Agentic task execution** - coordinate AI agents around coding tasks and project changes
- **Natural language workflow control** - describe what needs to happen and let agents work through the steps
- **Project-aware assistance** - useful for navigating tasks, code changes, and multi-file implementation work
- **Fits multi-agent systems** - aligns with Solo Unicorn Builder's command-center model

**Best for:**
- Builders experimenting with multi-agent coding workflows
- Coordinating implementation tasks across a project
- Teams comparing AI coding agents beyond the major cloud providers

**Limitations:**
- Newer ecosystem; confirm current install and command details from Kilo.ai docs
- Capabilities may vary depending on configured models and integrations

---

### Docker AI Agent Gordon - The Container Specialist

**Official Site:** https://www.docker.com/products/docker-ai/

**What makes it special:**
- **Docker-native context** - helps explain Dockerfiles, Compose files, images, volumes, and container networking
- **Local development support** - useful when debugging why a service, image build, or Compose stack is failing
- **Container workflow guidance** - pairs naturally with Solo Unicorn Builder's Docker-first setup
- **Accessible through Docker tooling** - available through Docker's AI experience, including Docker Desktop integrations

**Best for:**
- Understanding and fixing Dockerfiles and `docker-compose.yml`
- Debugging local containerized development environments
- Explaining container logs, image build failures, and networking issues
- Builders who want AI help inside the Docker workflow

**Limitations:**
- Docker-focused; pair with a general CLI coding agent for broad codebase changes
- Availability and CLI access may depend on Docker Desktop version and account features

---

### Codex CLI - The OpenAI Terminal Agent

**Official Docs:** https://github.com/openai/codex

**What makes it special:**
- **OpenAI ecosystem** - brings OpenAI models into terminal-based development workflows
- **Project-aware coding help** - useful for editing files, generating code, explaining errors, and iterating from natural language
- **ChatGPT-adjacent workflow** - familiar model behavior for users already working with OpenAI tools
- **Fast experimentation** - good for quick implementation passes, scripts, tests, and explanations

**Best for:**
- Builders already using OpenAI or ChatGPT heavily
- Quick code generation and explanation tasks
- Comparing OpenAI model output against Claude, Gemini, or local-model agents
- Natural-language terminal workflows in OpenAI-centered environments

**Limitations:**
- Requires OpenAI access/API configuration
- Review generated code carefully, especially for production or security-sensitive changes
- Capabilities and command behavior may change as the Codex CLI evolves

---

### OpenCode - The Model-Agnostic Powerhouse

**Official Docs:** https://opencode.ai

**What makes it special:**
- **75+ model support** - Claude, OpenAI, Gemini, Groq, Azure, local models via LM Studio
- **Go-based TUI** - fast, native terminal UI with vim-like editor
- **LSP integration** - language server support for Rust, TypeScript, Python, and more
- **Use existing subscriptions** - works with ChatGPT Plus/Pro, GitHub Copilot, or free local models
- **Persistent sessions** - SQLite storage, multi-session management

**Best for:**
- Developers who want maximum model flexibility
- Privacy-conscious builders (local model support)
- Those with existing AI subscriptions they want to leverage
- Polyglot developers working across many languages

**Limitations:**
- Newer project, smaller community than Claude Code
- Go installation required

### Pi - The Minimal Terminal Agent

**Official Docs:** https://pi.dev

**What makes it special:**
- **"This one is mine"** philosophy — minimal core that adapts to your workflow, not the other way around
- **Tree-structured sessions** — conversation history stored as a branching tree; navigate to any prior point and fork from there
- **15+ providers, hundreds of models** — Anthropic, OpenAI, Google, Azure, Bedrock, Mistral, Groq, and more
- **TypeScript extensions** — extend with skills, prompt templates, themes, and context injection
- **Multiple output modes** — interactive TUI, print/JSON output, RPC protocol, and an SDK for embedding in your own tools
- **Intentionally minimal** — no built-in MCP, sub-agents, or plan mode by default; build what you need via extensions

**Best for:**
- Developers who want a lightweight, hackable agent with no opinions
- Context engineering experimentation (configurable system prompts, auto-compaction, skills)
- Multi-provider workflows without committing to one vendor
- Embedding AI capabilities directly into your own tooling via the SDK

**Pricing:** Free and open source (MIT License)

**Install:**
```bash
npm install -g @mariozechner/pi-coding-agent
```

---

## Agent Harnesses & Self-Hosted Frameworks

CLI agents run on your machine and talk to cloud APIs. **Agent harnesses** go further — you deploy your own agent infrastructure that runs persistently, connects to your communication channels (Slack, Discord, CLI), and learns over time. You own the runtime. You own the data.

| Framework | Provider | Approach | Deployment | Key Strength |
|-----------|----------|----------|------------|--------------|
| **OpenClaw** | Open-source | Gateway-first | OCI, $5 VPS, Docker | Channel routing, integrations, rapid deploy on cheap infra |
| **Hermes Agent** | Nous Research | Agent-first | OCI, Docker, SSH, Modal | Self-improving skill library, 15+ messaging platforms, 200+ models |
| **NemoClaw** | NVIDIA | Security-first | Enterprise / NVIDIA NIM | Deny-by-default egress, sandboxed config, policy guardrails |
| **Solo Unicorn Builder** | Open-source | Agent harness | Local / any CLI agent | Skills-first orchestration: structured knowledge + agent execution across every business function |

**Agent harness vs CLI agent:**

| | CLI Agent | Agent Harness |
|---|---|---|
| Where it runs | Your local machine | Your server (always-on) |
| State | Per-session | Persistent across sessions |
| Channels | Terminal | Slack, Discord, CLI, WhatsApp, and more |
| Learning | None | Skill library grows over time |
| Ownership | Vendor-hosted API | Your infrastructure |

### OpenClaw — The Gateway Framework

**Official Docs:** https://github.com/openclaw-ai/openclaw

**What makes it special:**
- **Gateway-first architecture** — routes messages from any channel (Slack, Discord, CLI) to any LLM provider
- **Cheap to run** — deploys on OCI Always Free (A1 ARM64, 4 OCPU / 24 GB) or a $5/month VPS
- **Fast to deploy** — single Docker Compose stack, no ML infrastructure required
- **Foundation for NemoClaw** — NemoClaw wraps OpenClaw with NVIDIA's security and policy layer
- **Active open-source community** — channel integrations, provider plugins, and deployment guides

**Best for:**
- Deploying your own always-on agent on free or near-free cloud infrastructure
- Teams who want a self-hosted Slack/Discord bot backed by frontier models
- Builders experimenting with multi-channel AI agent deployments
- Anyone who wants OpenClaw + Hermes Agent on the same OCI free-tier instance

**Limitations:**
- Not a coding agent in the CLI sense — it's a deployment layer, not a local dev tool
- Requires server setup (Docker, SSH, OCI or VPS)
- Pair with a CLI coding agent (Claude Code, Gemini CLI) for local development work

**Install:**
```bash
# Deploy via Docker Compose on OCI, VPS, or local server
# See official docs for the full runbook
docker compose up -d
```

### Solo Unicorn Builder — The Agent Harness

**What it is:**
Solo Unicorn Builder is not a coding agent — it's an **agent harness**: a structured skill library and knowledge vault that turns any CLI agent into a full operating partner across every business function.

**What makes it special:**
- **Skills-first architecture** — 36+ structured `SKILL.md` files covering code, marketing, legal, finance, sales, and more
- **Agent-agnostic** — works with Claude Code, Gemini CLI, Kiro CLI, DeepAgents, or any agent that reads markdown
- **Knowledge vault** — personal context (career, projects, decisions) that the agent reads before acting
- **Context engineering made operational** — not just structured prompts, but a system that makes AI act autonomously on your behalf

**Best for:**
- Knowledge workers who want AI to handle functions they've never done before (legal, marketing, finance)
- Builders who want a consistent system across multiple CLI agents
- Anyone running the AI Launchpad Cohort methodology

**Official Docs:** https://github.com/pingwu/solo-unicorn

---

## Choosing Your Agent(s)

### Decision Framework

1. **What's your primary use case?**
   - Complex architecture and refactoring → **Claude Code**
   - Shell commands and CLI operations → **GitHub Copilot CLI**
   - Large codebases, multimodal → **Gemini CLI**
   - Jira/Confluence integration, enterprise workflow → **Atlassian Rovo**
   - Persistent project memory & sandboxing → **LangChain DeepAgents**
   - AWS infrastructure and DevOps → **Kiro CLI**
   - Multi-agent coding coordination → **Kilo.ai CLI agents**
   - Docker/container troubleshooting → **Docker AI Agent Gordon**
   - Maximum model flexibility → **OpenCode**
   - Minimal, hackable, self-owned → **Pi**
   - Self-hosted always-on agent (Slack/Discord/CLI gateway) → **OpenClaw**
   - Skills-first agent harness across every business function → **Solo Unicorn Builder**
   - Real-time autocomplete → **Copilot** or **Cursor** (IDE)

2. **What's your budget?**
   - Pay per use → Claude Code, Gemini CLI, DeepAgents
   - Monthly/Seat-based subscription → Atlassian Rovo, Kiro CLI, Kilo.ai, Docker AI/Docker Desktop, Copilot, Cursor
   - Free/open source → OpenCode, OpenClaw, Solo Unicorn Builder (but you pay for LLM API, or use local models)

3. **What cloud/stack do you use?**
   - Atlassian Ecosystem → Atlassian Rovo
   - LangChain / Python Ecosystem → LangChain DeepAgents
   - AWS → Kiro CLI
   - Docker/container-first → Docker AI Agent Gordon plus a general CLI coding agent
   - Multi-agent workflow experimentation → Kilo.ai CLI agents
   - GCP → Gemini CLI
   - Self-hosted / free-tier cloud (OCI, $5 VPS) → OpenClaw
   - Any/none → Claude Code or OpenCode

### Recommended for Solo Unicorn Builder

**Primary:** Pick one CLI agent — Claude Code, Gemini CLI, Atlassian Rovo, LangChain DeepAgents, Kiro CLI, Kilo.ai CLI agents, or Docker AI Agent Gordon for Docker-heavy work
**Optional:** Add Cursor or Copilot for real-time autocomplete in your IDE

All of Solo Unicorn Builder's skills work with any CLI agent. You describe what you need in natural language, the agent reads the relevant `SKILL.md`, and executes.

---

## The Multi-Agent Workflow

**Best practice:** Use multiple CLI agents for different strengths.

### Example: Building and Deploying a Feature

```
1. Atlassian Rovo: "Analyze the Jira ticket JIRA-456 and suggest a technical design"
   → Context-aware planning based on existing tasks

2. LangChain DeepAgents: "Summarize the project conventions and architecture for the new dev"
   → Persistent memory makes context retrieval fast

3. Claude Code: "Implement the feature according to the design"
   → High-quality code generation and multi-file changes

4. Docker Gordon: "Explain why this Compose stack is failing and how to fix the Dockerfile"
   → Container-native debugging and local environment guidance

5. Kiro CLI: "Deploy this to AWS with a staging environment"
   → Infrastructure setup, container registry, Cloud Run config

6. Gemini CLI: "Generate comprehensive API documentation from the codebase"
   → Large context window handles the full system
```

Each agent does what it does best. Your job is to ask the right questions.

---

## Common Questions

**Q: Will AI replace developers?**
**A:** No. AI makes developers more productive, but humans still define requirements, make architectural decisions, review suggestions, and handle business logic.

**Q: Which agent should I learn first?**
**A:** Pick one CLI agent and start building. Skills transfer between agents. For Solo Unicorn Builder, Claude Code, Gemini CLI, Atlassian Rovo, LangChain DeepAgents, Kiro CLI, Kilo.ai CLI agents, or Docker Gordon are useful starting points depending on your workflow.

**Q: What happened to Amazon CodeWhisperer?**
**A:** AWS retired CodeWhisperer in April 2024 and merged its features into Amazon Q Developer. Kiro is AWS's newer, more ambitious offering — a spec-first AI development platform available as both an IDE and a CLI.

**Q: Are these tools ready for production?**
**A:** Yes, with caveats: always review AI-generated code, use tests to catch issues, and start with well-understood problems.

**Q: What about code privacy?**
**A:** Varies by tool:
- **Claude Code, Gemini CLI, Atlassian Rovo, LangChain DeepAgents, Kiro CLI, Kilo.ai, Docker Gordon:** Code/context may be sent to cloud services for processing
- **OpenCode:** Can use local LLMs for full privacy
- Check each tool's privacy policy for your compliance needs

---

## Getting Started with Solo Unicorn Builder

Solo Unicorn Builder works with **any CLI coding agent**. The skills in `skills/` are agent-agnostic — they work with Claude Code, GitHub Copilot CLI, Gemini CLI, Atlassian Rovo, LangChain DeepAgents, Kiro CLI, Kilo.ai CLI agents, Docker AI Agent Gordon, Codex CLI, OpenCode, or any tool that reads markdown files.

**Setup:**
1. Install at least one CLI agent (Claude Code, Gemini CLI, Atlassian Rovo, LangChain DeepAgents, Kiro CLI, Kilo.ai CLI agents, Docker Gordon, or OpenCode)
2. Clone Solo Unicorn Builder and run the init setup
3. Start describing what you want to build — the agent reads the relevant skills and executes

The AI-augmented knowledge worker doesn't need to master every tool. Pick one, start building, and add more as your workflow demands.

---

## Official Resources

AI coding tools evolve rapidly. Start with the official resources:

- **Claude Code:** https://docs.anthropic.com/en/docs/claude-code
- **GitHub Copilot CLI:** https://gh.io/copilot-cli
- **Gemini CLI:** https://github.com/google-gemini/gemini-cli
- **Atlassian Rovo:** https://support.atlassian.com/rovo/docs/use-rovo-dev-cli/
- **LangChain DeepAgents:** https://docs.langchain.com/oss/python/deepagents/cli/overview
- **Kiro CLI:** https://kiro.dev/docs/cli/
- **Kilo.ai CLI agents:** https://kilo.ai
- **Docker AI Agent Gordon:** https://www.docker.com/products/docker-ai/
- **Codex CLI:** https://github.com/openai/codex
- **OpenCode:** https://opencode.ai
- **Pi:** https://pi.dev
- **GitHub Copilot:** https://github.com/features/copilot
- **Cursor:** https://cursor.com/docs
- **OpenClaw:** https://github.com/openclaw-ai/openclaw
- **Hermes Agent:** https://hermes-agent.nousresearch.com/
- **Solo Unicorn Builder:** https://github.com/pingwu/solo-unicorn
