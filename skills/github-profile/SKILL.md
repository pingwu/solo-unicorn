---
name: github-profile
description: Optimize your GitHub profile as a living portfolio — craft a standout profile README, pin the right repos, tag for discoverability, and signal real builder credibility to hiring managers evaluating AI-native developer candidates.
---

# GitHub Profile

Your GitHub profile is your portfolio, your proof of work, and often the first technical impression a hiring manager gets. This skill turns it into a strategic asset — not a graveyard of half-finished tutorials.

## Core Principle

**"Show what you build, not what you star."** Hiring managers spend 30 seconds on your profile. Every element — README, pinned repos, bio, activity graph — should answer one question: *Can this person ship?*

---

## The Profile README (username/username repo)

### Setup

GitHub renders a special `README.md` as your profile page if you create a repo that matches your username.

```
1. Create a new repo named exactly your GitHub username
   → github.com/yourname/yourname

2. Check "Add a README file" during creation

3. The README.md in this repo becomes your profile landing page
```

If the repo already exists but is private, make it public. GitHub only renders public profile READMEs.

### README Structure

Write it in this order. Every section earns its place or gets cut.

```markdown
# Headline (1 line)

What you do + what makes you different. Not your job title — your value proposition.

## About

2-3 sentences. What you're building, what you care about technically,
what you're looking for. Written for a human, not a search engine.

## Tech Stack

Grouped by category. Only include tools you can talk about in an interview.

## Featured Projects

3-4 repos with one-line descriptions and what makes each interesting.
Link directly to the repos.

## Contact

LinkedIn, email, portfolio site. Make it easy to reach you.
```

### Headline — The Most Important Line

| Weak | Strong |
|------|--------|
| "Hi, I'm Alex" | "Building AI-powered developer tools in Python and TypeScript" |
| "Full-stack developer" | "Staff engineer turning LLM prototypes into production systems" |
| "Passionate about code" | "Shipping AI agents that automate real workflows" |

The headline should pass the "So what?" test. If a hiring manager reads it and thinks "so what?" — rewrite it.

### About Section

Write 2-3 sentences that answer:

1. What are you building right now?
2. What technical problems genuinely interest you?
3. What are you looking for? (open to roles, collaborating, etc.)

```markdown
## About

I build AI-native applications that go beyond chat wrappers — tool-using agents,
retrieval-augmented generation pipelines, and LLM evaluation frameworks. Currently
focused on making AI systems reliable enough for production workloads. Open to
senior/staff roles where I can ship AI products end-to-end.
```

Do not write a life story. Do not list soft skills. Do not say "passionate learner."

### Tech Stack Section

Group by function. Only list what you could whiteboard in an interview.

```markdown
## Tech Stack

**AI/ML:** Python, LangChain, OpenAI API, RAG pipelines, vector databases (Pinecone, pgvector)
**Backend:** Node.js, FastAPI, PostgreSQL, Redis
**Infrastructure:** AWS (Lambda, ECS, S3), Docker, Terraform
**Frontend:** React, TypeScript, Next.js
```

| Do | Don't |
|----|-------|
| Group logically (AI/ML, Backend, Infra, Frontend) | Dump 40 badges in a grid |
| Include only tools you've used in projects | List every technology you've seen a tutorial for |
| Put your strongest/most relevant stack first | Alphabetize everything |

Skip the shields.io badge wall. A clean text list signals confidence. A wall of badges signals insecurity.

### Featured Projects Section

Link 3-4 of your best repos. Each gets one line explaining what it does and one line explaining why it's interesting technically.

```markdown
## Featured Projects

**[ai-code-reviewer](https://github.com/yourname/ai-code-reviewer)**
Automated PR reviewer using GPT-4 with AST-aware context windowing. Reduced review time by 40% on a 5-person team.

**[rag-eval-framework](https://github.com/yourname/rag-eval-framework)**
End-to-end evaluation pipeline for RAG systems — measures retrieval precision, answer faithfulness, and hallucination rate.

**[deploy-cli](https://github.com/yourname/deploy-cli)**
Zero-config deployment tool for containerized Python apps. One command from code to running on AWS ECS.
```

Every project description should include a **concrete result or technical detail**, not just what the project "is."

### Contact Section

```markdown
## Get in Touch

- LinkedIn: [linkedin.com/in/yourname](https://linkedin.com/in/yourname)
- Email: you@example.com
- Portfolio: [yoursite.dev](https://yoursite.dev)
```

Make it frictionless. If someone wants to hire you, don't make them hunt for a way to reach you.

---

## Pinned Repos — Your Curated Portfolio

GitHub lets you pin up to 6 repos. These are the only repos most people will ever look at.

### Selection Criteria

```
Pin repos that show:
1. You can ship a complete project (not just a starter template)
2. You understand the domain hiring managers care about (AI, infra, full-stack)
3. You write code that other humans can read
4. You solve real problems, not toy examples
```

### What to Pin vs. What to Skip

| Pin This | Skip This |
|----------|-----------|
| Original project with a real README | Fork of a popular repo with no changes |
| Tool/library that solves a specific problem | "awesome-list" or curated link collections |
| Project with tests, docs, and clean commits | Tutorial follow-along (todo app, calculator) |
| Collaborative project where you're a key contributor | Repo with 1 commit from 2 years ago |
| Something you can demo and explain in 5 minutes | Class homework or bootcamp assignments |

### Pin Order Matters

GitHub displays pinned repos left-to-right, top-to-bottom. Put your strongest project in position 1 (top-left). Most people only look at the first 2-3.

### Tell a Story With Your Pins

Your 6 pins should collectively answer: "What kind of engineer is this person?"

```
Example narrative: "AI-native full-stack developer"

Pin 1: AI agent framework (shows AI depth)
Pin 2: Production API with AI integration (shows backend + AI)
Pin 3: CLI tool for developer workflows (shows shipping real tools)
Pin 4: Open source contribution to known project (shows collaboration)
Pin 5: Infrastructure-as-code repo (shows production awareness)
Pin 6: Side project with a live demo (shows end-to-end ability)
```

---

## Repo Hygiene — Topics, Descriptions, and READMEs

Every pinned repo needs three things before it's profile-ready.

### 1. Repository Description (the one-liner)

The short description shown on your profile and in search results. Write it like a commit message — clear, specific, no filler.

```
Bad:  "A cool project I built"
Good: "CLI tool that generates type-safe API clients from OpenAPI specs"

Bad:  "Machine learning stuff"
Good: "RAG evaluation framework measuring retrieval precision and answer faithfulness"
```

### 2. Topics/Tags

Topics make your repos discoverable in GitHub search and signal what technologies you work with.

```
Add 5-10 relevant topics per repo:

ai, llm, rag, python, fastapi, openai, langchain,
vector-database, developer-tools, cli
```

| Do | Don't |
|----|-------|
| Use specific, searchable terms | Add generic tags like "code" or "project" |
| Include the primary language | Tag languages you didn't actually use |
| Add the problem domain (e.g., "developer-tools", "devops") | Add 30 tags hoping for SEO |
| Match terms hiring managers search for | Make up tags nobody searches for |

### 3. Repo README

Every pinned repo needs a README that covers:

```
- What it does (1-2 sentences)
- Why it exists / what problem it solves
- How to install and run it
- Architecture or design decisions (brief)
- Screenshots or demo GIF if applicable
```

A repo without a README is a repo nobody will look at. A README without install instructions is a project nobody will try.

---

## Profile Photo, Bio, and Links

### Profile Photo

Use a clear, professional headshot. Not a logo, not an avatar, not a photo from 2014. Hiring managers are evaluating whether they want to work with you — a real face builds trust.

### Bio (the 160-character field)

This appears on your profile and in search results. Treat it like a tweet.

```
Bad:  "I like coding and learning new things"
Good: "Building AI developer tools. Python, TypeScript, LLMs. Open to staff-level roles."

Bad:  "Student | Dreamer | Coder"
Good: "ML engineer shipping RAG pipelines to production. Previously @CompanyName."
```

Include: what you do, your primary stack, and your current status (open to work, building X, etc.).

### Links

GitHub gives you fields for:
- **Website:** Use this. Link to a portfolio, blog, or LinkedIn.
- **Company:** Current employer or "Open to opportunities" if job searching.
- **Location:** Include it. Remote hiring managers filter by timezone.
- **Social accounts:** Link your LinkedIn at minimum.

Fill every field. Empty fields look like you don't care.

---

## GitHub Activity Graph — What It Signals

The green contribution graph is the first thing many recruiters look at. Here's what they actually read from it.

### What the Graph Signals

| Pattern | Signal |
|---------|--------|
| Consistent daily/weekly activity | Active builder, codes regularly |
| Large gaps with sudden bursts | Only codes for job searches (red flag) |
| Heavy activity on weekdays only | Mostly work contributions (fine, but not standout) |
| Steady mix of weekday + weekend | Genuine interest beyond the job |
| All green, every single day | Probably gaming the graph (also a red flag) |

### How to Build a Real Graph

```
The graph reflects:
- Commits to default branches
- Opening issues and PRs
- Creating repos
- Reviewing PRs

It does NOT reflect:
- Commits to non-default branches (until merged)
- Private repo activity (unless you enable it in settings)
- Starring or forking repos
```

**Enable private contributions:** Settings > Profile > check "Include private contributions on my profile." This fills in gaps from work activity without exposing code.

### Honest Advice

Do not manufacture commits to make the graph green. Hiring managers who care about AI-native developers care about **what** you build, not how green your calendar is. A sparse graph with 3 excellent pinned repos beats a solid green wall with nothing worth clicking on.

---

## Anti-Patterns — What NOT to Do

| Anti-Pattern | Why It Hurts You |
|--------------|-----------------|
| Profile README with animated GIFs, visitor counters, and Spotify widgets | Looks like MySpace, not a professional portfolio |
| 30+ pinned badge icons for every framework ever | Signals breadth without depth — "jack of all trades" |
| Pinning forks you didn't meaningfully contribute to | Hiring managers check commit history. They'll notice. |
| "Hello world" or tutorial repos visible on profile | Suggests you're still learning the basics |
| No README on any repo | "I write code but can't communicate about it" |
| Bio says "aspiring developer" or "learning to code" | Undercuts your credibility before they look at anything |
| Dozens of repos with 1 commit each | Starts things, finishes nothing |
| Star count as a personality trait | Nobody cares how many repos you've starred |
| README that's 500 lines with every GitHub stat widget | Overcompensating. Let the work speak. |
| Committing API keys, .env files, or secrets | Instant disqualification. Audit your repos now. |

---

## Optimization Checklist

Run through this before sharing your profile with anyone.

```
Profile Basics:
[ ] Professional headshot as profile photo
[ ] Bio filled with role + stack + status (160 chars)
[ ] Website field links to portfolio or LinkedIn
[ ] Location set (city or timezone)
[ ] Company field filled (employer or "Open to opportunities")
[ ] Social accounts linked

Profile README (username/username repo):
[ ] Repo exists, is public, contains README.md
[ ] Headline passes the "So what?" test
[ ] About section is 2-3 sentences, not a novel
[ ] Tech stack grouped by category, only real skills listed
[ ] 3-4 featured projects with concrete descriptions
[ ] Contact info is easy to find

Pinned Repos (up to 6):
[ ] Each repo has a clear one-line description
[ ] Each repo has 5-10 relevant topics/tags
[ ] Each repo has a README with install instructions
[ ] No forks, no tutorials, no abandoned projects
[ ] Pin order reflects your best work first
[ ] Pins collectively tell a coherent career story

Activity & Hygiene:
[ ] Private contributions enabled in settings
[ ] No committed secrets or API keys (audit with trufflehog or similar)
[ ] Recent activity visible (within last 30 days)
[ ] Commit messages are clear, not "fix" or "update"
```

---

## Power Move

"Audit my GitHub profile at github.com/[username]. Rewrite my profile README using the headline/about/stack/projects/contact structure. Recommend which 6 repos to pin and in what order, what topics to add to each, and what repo descriptions to update. Write the full README.md I can copy-paste, and flag any anti-patterns you see. Target audience: hiring managers looking for AI-native developers."

The agent becomes your profile strategist — turning a scattered GitHub presence into a portfolio that gets interviews.

## Related Skills

| Skill | When to use it |
|-------|---------------|
| `portfolio-strategy` | Decide which projects to showcase and what story they tell together |
| `career-resume` | Full career lifecycle — job search, interviews, onboarding, performance reviews |
