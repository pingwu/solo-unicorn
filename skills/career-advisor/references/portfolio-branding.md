# Portfolio, GitHub & LinkedIn Branding

Frameworks for building professional signal that closes gaps and attracts opportunities. The goal: when a hiring manager Googles you, they find a coherent story that matches what your resume claims.

## Table of Contents

1. [GitHub Portfolio Strategy](#github-portfolio-strategy)
2. [GitHub Profile Optimization](#github-profile-optimization)
3. [LinkedIn Strategy](#linkedin-strategy)
4. [Certification Tracking](#certification-tracking)
5. [File Templates](#file-templates)

---

## GitHub Portfolio Strategy

### Core Principle

**3-5 polished projects beats 30 abandoned repos.** Your GitHub is a curated gallery, not a code dump.

### Story Arcs (Pick One)

| Arc | Signal | Pin Pattern |
|-----|--------|-------------|
| **The Specialist** | Deep expertise in one domain | 4 projects showing progression in target area |
| **The Full-Stack Builder** | Complete products, end to end | Mix of frontend, backend, infra, deployed apps |
| **The AI-Native Developer** | Building with and for AI | LLM integrations, agents, RAG, dev tools |

### What to Pin (6 Slots)

1. **Full-stack project** — proves complete product ability
2. **Domain-depth project** — shows expertise in target area
3. **Open-source contribution** — demonstrates collaboration
4. **Developer tool/CLI** — solves real problems
5. **Gap-closing project** — built specifically to close a HARD gap from gap analysis
6. **Wildcard** — personality, curiosity, or emerging tech

Order matters: strongest project in position 1 (top-left). Six pins collectively answer: "What kind of engineer is this?"

### README That Sells (Every Pinned Repo)

```markdown
# Project Name

> One sentence: what it does and why it matters.

[Live Demo](url) | [Blog Post](url)

## The Problem
[2-3 sentences: what pain this solves]

## Architecture
[Diagram or brief description of key decisions]

## Tech Stack
[Only what's relevant — grouped by layer]

## Key Features
- Feature 1 (with quantified result if possible)
- Feature 2

## Setup
[How to run locally — must work on first try]

## Lessons Learned
[1-2 genuine insights — shows reflection]
```

### Deployment Matters

Code is a hypothesis; deployed apps are proof.

| Project Type | Deploy To |
|-------------|-----------|
| Web app | Vercel, Railway, Fly.io |
| API | Railway, Render |
| ML model | Hugging Face Spaces |
| Static site | GitHub Pages, Netlify |
| CLI tool | Published to npm/PyPI/Homebrew |

### Anti-Patterns

- Forked repos with no changes pinned
- Tutorial clones visible
- Empty repos or repos with no README
- 50+ visible unvetted repos (archive or make private)
- Outdated pins from 3 years ago
- Committing API keys/secrets (instant disqualification)

---

## GitHub Profile Optimization

### Profile README (username/username repo)

```markdown
# Headline

> Value proposition, not job title.
> "Building AI-powered developer tools in Python and TypeScript"
> NOT "Hi, I'm Alex" or "Full-stack developer"

## About
[2-3 sentences: what you're building, what interests you, what you're looking for]

## Tech Stack
**AI/ML:** Python, LangChain, OpenAI, RAG
**Backend:** FastAPI, PostgreSQL, Redis
**Frontend:** React, TypeScript, Next.js
**Infra:** Docker, AWS, Terraform

## Featured Projects
- **[project-name](link)** — One sentence with concrete result
- **[project-name](link)** — One sentence with technical detail
- **[project-name](link)** — One sentence showing range

## Connect
[LinkedIn](url) | [Email](mailto:) | [Portfolio](url)
```

### Profile Elements

- **Photo:** Clear professional headshot (not logo, not 2014 photo)
- **Bio (160 chars):** What you do + primary stack + status. "Building AI developer tools. Python, TypeScript, LLMs. Open to staff-level roles."
- **Links:** Fill every field — website, company, location, LinkedIn

### Repo Hygiene

| Element | Good | Bad |
|---------|------|-----|
| Description | "CLI tool that generates type-safe API clients from OpenAPI specs" | "A cool project" |
| Topics | `ai`, `llm`, `python`, `fastapi`, `developer-tools` (5-10 tags) | None |
| README | What, why, how, architecture, setup, demo | Empty or auto-generated |

### Activity Graph

- Enable private contributions (Settings > Profile) to fill gaps from work
- Consistent activity signals builder mindset
- Don't manufacture commits — hiring managers can tell
- Real patterns (regular work, focused sprints) > perfectly green calendar

---

## LinkedIn Strategy

### Profile Framework

**Headline (220 chars):** Not your current title — your value proposition targeting dream role keywords.
- Weak: "Software Engineer at Acme Corp"
- Strong: "Staff Engineer | Building AI-Powered Developer Tools | Python, TypeScript, LLMs"

**About (2600 chars):** Story arc structure:
1. **Hook** (first 2 lines — visible before "see more"): Lead with what you do and your strongest differentiator
2. **What you've done**: 3-4 quantified highlights from accomplishments.md
3. **What drives you**: Values and identity statements from my-identity.md
4. **What you're looking for** (if searching): Specific and confident, not desperate

Written in first person. Opens with a hook, not "I am a..."

**Experience section:** Mirror accomplishments.md — quantified achievements, not job duties. Each bullet starts with an action verb and includes a metric.

**Featured section (3-5 items):**
1. Best portfolio project (GitHub link)
2. A talk, article, or certification
3. Portfolio/personal site link

**Skills section:** Top 3 must match target JD keywords exactly. Get endorsements from colleagues.

**Recommendations:** 2-3 from managers/peers who speak to specific achievements. Give to receive.

### Content Strategy

| Frequency | Context | Goal |
|-----------|---------|------|
| 2x/week | Active job search | Visibility + recruiter discovery |
| 1-2x/month | Employed, growing | Thought leadership + network maintenance |
| 0 | Don't force it | Better silent than posting platitudes |

**High-signal post types:**
- Lessons learned from a real project (with specifics)
- Technical deep-dive on a problem you solved
- Genuine take on an industry trend (with evidence)
- Celebrating a team win (gives credit, shows leadership)
- Sharing a project you built (with demo link)

**Low-signal (avoid):**
- "Excited to announce..." without substance
- Motivational quotes
- Reposting without adding commentary
- Humble-bragging
- Engagement bait ("Agree?")

**Engagement > followers:** Comment thoughtfully on 3-5 posts daily during active search. Quality comments get noticed by hiring managers more than posts.

### LinkedIn Audit Checklist

```
[ ] Headline contains target role keywords (not current title)
[ ] About section opens with a hook (not "I am a...")
[ ] About section has quantified achievements
[ ] Experience bullets are achievements, not duties
[ ] Featured section has 3+ items including portfolio
[ ] Profile photo is professional and current
[ ] Custom URL set (linkedin.com/in/yourname)
[ ] Skills top 3 match target JD keywords
[ ] At least 2 recommendations from recent colleagues
[ ] Activity shows genuine engagement (not just reposts)
```

---

## Certification Tracking

### When Certs Matter

| Situation | Value | Example |
|-----------|-------|---------|
| Role requires it | Gate — must have | AWS SA, PMP, CPA |
| Industry standard signal | High for that domain | CKAD for K8s roles |
| Fills a HARD gap | Proves you learned it | GCP cert when switching from AWS |
| Nice to have | Low — build something instead | Random Udemy certificates |

### Certification Tracker Template

Track in `2-target/certifications.md`:

```markdown
# Certifications

**Last Updated:** YYYY-MM-DD

## Earned
| Certification | Issuer | Date Earned | Expiry | Closes Gap | Credential Link |
|---------------|--------|-------------|--------|------------|-----------------|
| | | | | | |

## In Progress
| Certification | Issuer | Started | Target Date | Study Hours/Week | Gap It Closes | Status |
|---------------|--------|---------|-------------|------------------|---------------|--------|
| | | | | | | |

## Planned
| Certification | Issuer | Why | Priority | Prerequisite | Estimated Effort |
|---------------|--------|-----|----------|-------------|------------------|
| | | | | | |

## Decided Against
| Certification | Why Not | Alternative |
|---------------|---------|-------------|
| | | |
```

---

## File Templates

### 2-target/portfolio.md

```markdown
# Portfolio Strategy

**Last Updated:** YYYY-MM-DD
**GitHub:** github.com/[username]
**Target Audience:** [hiring managers for what kind of role]

---

## Story Arc
[Specialist | Full-Stack Builder | AI-Native Developer | Custom]

## Current Pins
| Position | Repo | README? | Deployed? | Signals |
|----------|------|---------|-----------|---------|
| 1 | | | | |
| 2 | | | | |
| 3 | | | | |
| 4 | | | | |
| 5 | | | | |
| 6 | | | | |

## Projects to Build/Polish
| Project Idea | Gap It Closes | Effort | Priority | Status |
|-------------|---------------|--------|----------|--------|
| | | | | |

## Profile README Status
- [ ] Headline is value proposition
- [ ] Tech stack grouped and current
- [ ] Featured projects with descriptions
- [ ] Contact links complete

## Repo Hygiene
- [ ] Archived old/irrelevant repos
- [ ] All visible repos have descriptions
- [ ] Pinned repos have compelling READMEs
- [ ] No secrets committed anywhere
- [ ] Private contributions enabled

## Last Audit: YYYY-MM-DD
[Notes from most recent audit]
```

### 2-target/linkedin.md

```markdown
# LinkedIn Strategy

**Last Updated:** YYYY-MM-DD
**Profile URL:** linkedin.com/in/[username]
**Target Role:** [from dream-job.md]

---

## Headline
[Current headline]
[Target headline — optimized for dream role keywords]

## About Section
[Draft or current about section]

## Featured Items
1. [item + link]
2. [item + link]
3. [item + link]

## Content Plan
| Frequency | Topic Ideas | Status |
|-----------|------------|--------|
| | | |

## Network Building
| Target Connection | Why | Approach | Status |
|-------------------|-----|----------|--------|
| | | | |

## Last Audit: YYYY-MM-DD
[Notes from most recent audit]
```
