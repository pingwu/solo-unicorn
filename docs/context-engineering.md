---
name: context-engineering
description: How Solo Unicorn Builder evolved from context engineering to agent harness — the daily writing discipline, personal knowledge graph, vendor independence, and the real-world outcomes that prove the approach works.
---

# From Context Engineering to Agent Harness

The industry calls it **context engineering** — the discipline of structuring information so AI produces better, more grounded outputs. This project has been practicing it from the start, before the term existed.

But context engineering is only half the picture. Knowing what to feed the AI doesn't help if you don't have a system to make it *act*. Solo Unicorn Builder is an **agent harness** — it doesn't just structure your knowledge; it gives AI agents the skills, instructions, and domain expertise to operate as your team across every function you've never done before.

## Three Layers of Engineered Context

Solo Unicorn Builder is built on three layers:

| Layer | What | Where |
|-------|------|-------|
| **Skills** — what the AI can do | 36 structured prompting patterns that give the AI domain expertise | `skills/` |
| **Instructions** — how the AI behaves | Cascading rules from mission to constitution to agent config | `CLAUDE.md` → `UNICORN_CONSTITUTION.md` → `MISSION.md` |
| **Knowledge** — what the AI knows about you | Your daily writing, research, ideas, goals, career materials | `my_knowledge/` |

The first two layers ship with the project. The third layer — **your knowledge** — is the one only you can build.

## The Writing Practice

The `my_knowledge/` vault is designed around a daily practice: collect your thoughts, capture external knowledge (news, articles, videos, conversations), and organize it into folders that form a personal knowledge graph.

| Folder | What goes here |
|--------|---------------|
| `daily/` | Daily reflections, what you learned, what you noticed |
| `ideas/` | Raw brainstorms, "what if" sparks, early-stage thinking |
| `companies/` | Research on companies, industries, market trends |
| `people/` | Contacts, collaborators, mentors, relationship notes |
| `career/` | Accomplishments, applications, roles, growth tracking |
| `goals/` | Long-term vision, OKRs, quarterly plans |
| `personal/` | Values, strengths, your "why" |

Over time, these entries connect. An idea on Monday links to a company you researched on Wednesday, which connects to a person you met on Friday, which shapes a goal you set next quarter. The AI reads this graph and produces outputs grounded in *your* actual context — not generic advice.

When a skill like `career-advisor` runs, it doesn't generate a generic resume. It reads your accomplishments, your target companies, your goals — and produces something that reflects your real story. That's what context engineering looks like in practice: **the daily discipline of collecting and connecting your knowledge so AI can reason about your specific situation.**

## Proof It Works

This isn't theory. The agent harness approach has shipped real outcomes.

### *Just Ask* — A Business Novel

This project's author used the same practice to write *[Just Ask](https://www.ping-ai.com)* — a business novel about a laid-off cloud engineer who discovers that the skill behind every AI breakthrough is the same skill behind every human breakthrough: the ability to ask the right question.

The book was produced through daily writing and knowledge collection — the same `my_knowledge/` workflow this project gives you. Years of daily reflections, research notes, collected ideas, and external knowledge accumulated into a personal knowledge graph. When it came time to write, the AI didn't start from nothing. It drew from a rich, structured context that the author had been building one day at a time.

In Chapter 2, "Lemon Juice," the protagonist discovers the core insight: **the technology is never the variable — the context is the variable.** The same AI tool that electrifies a room full of fifteen people at a family dinner produces flat, adequate answers the next morning in a quiet kitchen. The difference isn't the model. It's the context surrounding it — the energy, the audience, the frame, the accumulated knowledge that gives the AI something real to work with.

The protagonist's morning writing practice — emptying thoughts onto a blank page with no audience, no optimization — becomes the foundation for everything that follows. Not because writing is magical, but because it builds the context that makes AI useful. Without that daily discipline, the AI has nothing personal to reason about. With it, every tool in the stack becomes grounded in *your* actual situation.

The `my_knowledge/` vault isn't a feature — it's the practice the entire framework was built on.

### AI Launchpad Cohort — A Production Landing Page

The [AI Launchpad Cohort](https://cohort.solo-unicorn.app/) is a paid 3-week intensive that teaches the same agent harness methodology to knowledge workers. The landing page itself — from copy to deployment — was built and shipped using the same skills and workflows this project teaches.

This is the agent harness in action: `landing-page-service-discovery` synthesized the author's professional accomplishments into positioning copy. `career-advisor` provided the career narrative. `frontend-ui-ux` handled responsive design. `go-to-market` shaped the offer structure. No separate design team, no copywriter, no web agency. One person, multiple AI agents, a real product in production.

The landing page isn't a demo — it's a business generating revenue. That's the difference between context engineering (structuring information) and an agent harness (making AI act). The same framework you clone from this repo is the one that shipped a real product.

### WRITITATION™ — Before the Karpathy Wiki Pattern

In April 2026, Andrej Karpathy [posted a pattern](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) that went viral — 16M+ views, 5,000+ GitHub stars in days: use Obsidian as the IDE, an LLM as the programmer, and a structured markdown wiki as the codebase. The community called it the "LLM Wiki Pattern."

Solo Unicorn Builder has been doing this since 2025 — and we trademarked it.

**WRITITATION™** (Writing + Meditation) is the methodology behind the `my_knowledge/` vault: a daily practice of collecting thoughts, capturing external knowledge, and organizing it into structured markdown that AI agents can reason over. The `obsidian-knowledge` skill connects your Obsidian vault directly to your coding agent. The three-layer architecture (skills, instructions, knowledge) predates Karpathy's three-layer architecture (raw, wiki, schema) by over a year.

The difference: the Karpathy Wiki Pattern is about **building a knowledge base**. WRITITATION™ is about **building a practice** — the daily discipline that makes the knowledge base valuable. A wiki without a writing habit is an empty folder. WRITITATION™ is the 心法 (inner methodology) that fills it.

If the Karpathy Wiki Pattern resonates with you, you're already looking at its evolution. Solo Unicorn Builder doesn't just store knowledge — it harnesses that knowledge through 40+ skills that turn your accumulated context into shipped products, tailored resumes, validated ideas, and real business outcomes.

## Why Your Context Shouldn't Live in a Vendor's Data Center

When you use ChatGPT, Claude.ai, or Gemini through their web apps, every conversation — every question you've asked, every idea you've explored, every decision you've reasoned through — lives in that vendor's data center. Your context is scattered across chat threads you can't search, can't structure, and can't move. Switch vendors, and you start from zero. Your history isn't portable. Your knowledge graph doesn't exist. You're renting your own thinking.

Solo Unicorn Builder takes the opposite approach: **your context is your codebase.** Every piece of knowledge lives as a local markdown file in `my_knowledge/`. Every project lives in `my_projects/`. Every skill is a readable file in `skills/`. The AI agent reads your local files — it doesn't remember you from a previous SaaS session. It doesn't need to. Your context is right here, on your machine, version-controlled, searchable, and portable.

| | SaaS Chat (ChatGPT, Claude.ai, etc.) | Solo Unicorn Builder |
|---|---|---|
| **Where context lives** | Vendor's servers, in chat threads | Your local filesystem, as markdown |
| **Searchable** | Limited, per-conversation | Full-text search across everything |
| **Structured** | Flat list of conversations | Organized folders forming a knowledge graph |
| **Portable** | Locked to vendor | Move anywhere — it's just files |
| **Version-controlled** | No | Git-tracked, with full history |
| **Survives vendor changes** | No | Yes — agent-agnostic by design |

This is the practical difference. With SaaS chat, the AI gets smarter about you only within a single conversation window. With Solo Unicorn Builder, the AI gets smarter about you because your accumulated knowledge is always available as local context — and it compounds over time, across every session, with any agent.

## Same Context, Multiple Models — Discovering Blind Spots

Every LLM has blind spots. Claude reasons deeply but may overcomplicate. Gemini handles massive context but may miss nuance. GPT generates quickly but may skip edge cases. When your context is locked inside one vendor's chat history, you're stuck with that model's blind spots. You can't get a second opinion without re-explaining everything from scratch.

Because Solo Unicorn Builder stores all context as local files, you can run the **exact same knowledge, skills, and instructions** through any model:

1. **Claude Code** architects a feature — deep reasoning, multi-file refactoring
2. **Gemini CLI** reviews the same codebase — catches issues Claude missed with its 1M+ token window
3. **Kiro CLI** deploys it — AWS-native, spec-driven validation
4. **OpenCode** runs a local model for privacy-sensitive analysis — no data leaves your machine

Each model reads the same `my_knowledge/`, the same `skills/`, the same project files. Different models surface different concerns. One catches a security issue. Another questions the architecture. A third flags a cost problem. The context is the constant; the models are the variables.

This is the multi-model advantage that vendor lock-in makes impossible. When your thinking lives in ChatGPT threads, you can't hand it to Claude for a second look. When your thinking lives in files, every model is a fresh pair of eyes on the same foundation.

## A Note on the Terms

We didn't set out to build a "context engineering framework." We set out to help specialists ship end-to-end. The writing practice and knowledge structure are how we got there. The industry now has a name for the first half — context engineering. We've gone further: an agent harness that turns structured context into autonomous action across every business function. The practice predates both buzzwords.
