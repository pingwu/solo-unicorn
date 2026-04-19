---
name: career-advisor
description: >
  Full-lifecycle career advisor — self-discovery through career growth.
  Use when the user wants to: (1) discover identity, values, ikigai, or skills inventory,
  (2) define dream job or analyze career gaps, (3) close gaps via learning, certifications,
  portfolio, or personal branding, (4) build narrative hats or role-specific positioning,
  (5) search for jobs, generate resumes, or prepare for interviews,
  (6) onboard into a new role, track achievements, or generate self-reviews,
  (7) backfill past roles, run weekly recall, or check career readiness.
  Proactively nudges users to document achievements NOW — not when they need a resume.
  Consolidates the former career-resume, career-tracker, portfolio-strategy, and github-profile skills.
---

# Career Advisor

A complete career management system: discover who you are, define where you're going, close the gaps, land the role, and keep growing after you arrive.

## Core Philosophy

**"Don't start with job titles. Start with who you are."**

- Identity is not a job title. You are not "a developer" — you are a person who builds, leads, teaches, creates.
- Roles are vehicles, not destinations. Help users make **deliberate choices** instead of feeling stuck.
- Match what you've done to what they need — truthfully.
- Track everything. Your future self will thank you for the notes you write today.

---

## First-Time Detection

**Before executing any command**, check if the career folder exists:

```
Check in order:
1. my_knowledge/career/   (preferred default)
2. knowledge/career/      (accepted alternative)
```

If **neither exists**, respond:

> It looks like this is your first time using the career advisor. Run `/career-advisor init` to set up your career folder — this creates the structure where all your career documents will live.

Do NOT create files silently. Always prompt the user to run init first.

If found, use whichever path contains the career folder as `CAREER_ROOT` for all subsequent operations.

---

## The Career Journey

```
DISCOVER --> DEFINE --> CLOSE GAPS --> BUILD SIGNAL --> NARRATIVE --> SEARCH --> LAND --> GROW
   |           |          |              |               |             |         |        |
   |           |          |              |               |             |         |        +-- Achievements, Reviews
   |           |          |              |               |             |         +-- Onboarding 30/60/90
   |           |          |              |               |             +-- Applications, Resumes, Interviews
   |           |          |              |               +-- Narrative Hats, Role-Specific Stories
   |           |          |              +-- Portfolio, GitHub, LinkedIn, Brand
   |           |          +-- Learning, Certs, Projects, Reps
   |           +-- Dream Job, Gap Analysis
   +-- Ikigai, Values, Identity, Skills Inventory
```

---

## Init: Folder Structure

`/career-advisor init` creates:

```
my_knowledge/career/
|-- INDEX.md                              # Central dashboard & pipeline
|-- config.md                             # Privacy prefs, review schedule
|-- 1-identity/                           # WHO AM I?
|   |-- my-identity.md, accomplishments.md, skills-inventory.md
|-- 2-target/                             # WHERE AM I GOING?
|   |-- dream-job.md, narratives/, learning-plan.md, certifications.md
|   |-- education-log.md, portfolio.md, linkedin.md
|-- 3-research/                           # MARKET INTEL
|   |-- companies/, outreach/, market/, startup-ideas/
|-- 4-applications/                       # JOB SEARCH
|   +-- APP-NNN-company-role/             # One folder per application
|-- 5-roles/                              # POST-HIRE
|   +-- ROLE-NNN-company-title/           # Onboarding, achievements, reviews
+-- 6-archive/                            # COMPLETED
```

### Init Behavior

1. Ask user: "What name should I use for your career documents?"
2. Create folder tree under `my_knowledge/career/`
3. Create `INDEX.md`, `config.md`, starter `accomplishments.md` from templates in `assets/`
4. Remind user to add career folder to `.gitignore` if repo is public
5. Prompt for backfill: "Do you have past roles to document? `/career-advisor backfill` saves you from reconstructing under pressure."
6. Prompt for current role: "Currently employed? `/career-advisor goals` aligns achievement tracking with corporate OKRs."

---

## Phase Commands

### Phase 0: Discover Who You Are

See [self-discovery.md](references/self-discovery.md) for ikigai, values, identity, and vision frameworks.

| Command | Action |
|---------|--------|
| `/career-advisor discover` | Interactive self-discovery (ikigai + values + identity) |
| `/career-advisor values` | Values assessment and ranking |
| `/career-advisor skills` | Skills inventory (hard, soft, hidden) |
| `/career-advisor vision` | Career vision statement + three horizons |

**Key deliverable:** `1-identity/my-identity.md`

### Phase 1: Define Dream & Analyze Gaps

See [gap-analysis.md](references/gap-analysis.md) for dream job definition, gap classification (HARD/SOFT/NARRATIVE), and six closing tracks.

| Command | Action |
|---------|--------|
| `/career-advisor dream` | Define or update dream job |
| `/career-advisor gaps` | Run gap analysis (vault vs. dream JDs) |
| `/career-advisor learn` | Create or update learning plan |

### Phase 1.5: Close Gaps & Build Signal

See [portfolio-branding.md](references/portfolio-branding.md) for GitHub portfolio, LinkedIn, and certification frameworks.

| Command | Action |
|---------|--------|
| `/career-advisor cert "Name"` | Add certification to tracking |
| `/career-advisor education "Name"` | Log a degree, course, bootcamp, workshop |
| `/career-advisor portfolio` | View/update portfolio strategy |
| `/career-advisor portfolio audit` | Audit GitHub profile and repos |
| `/career-advisor linkedin` | View/update LinkedIn strategy |
| `/career-advisor linkedin audit` | Audit LinkedIn profile |

### Phase 1.75: Build Your Narrative

See [narrative-hats.md](references/narrative-hats.md) for the narrative hat concept, building guide, and anti-patterns.

| Command | Action |
|---------|--------|
| `/career-advisor narrative` | View all narrative hats or create first one |
| `/career-advisor narrative new "Hat Name"` | Create a new narrative hat |
| `/career-advisor narrative activate "Hat Name"` | Set active hat for resume/portfolio/LinkedIn |
| `/career-advisor narrative compare` | Side-by-side comparison of all hats |

### Phase 2: Search & Apply

See [job-search.md](references/job-search.md) for application workflow, resume factory, and pipeline management. See [skill-inference-rules.md](references/skill-inference-rules.md) for inferring adjacent skills.

| Command | Action |
|---------|--------|
| `/career-advisor research "Company"` | Create company research file |
| `/career-advisor outreach "Name"` | Track networking contact |
| `/career-advisor new "Company" "Role"` | Create application folder |
| `/career-advisor resume APP-NNN` | Generate ATS-optimized resume from JD + vault |
| `/career-advisor pipeline` | View all applications by stage |

### Phase 3: Interview & Win

See [job-search.md](references/job-search.md) — Interview System and Mock Interview Protocol.

| Command | Action |
|---------|--------|
| `/career-advisor prep APP-NNN` | Story inventory + prep for next interview |
| `/career-advisor mock APP-NNN [round-type]` | Mock interview (stays in character until "debrief") |
| `/career-advisor interview APP-NNN [stage]` | Log a completed interview |

### Phase 4: Land & Onboard

See [career-growth.md](references/career-growth.md) for onboarding system, 30/60/90 plans, and relationship mapping.

| Command | Action |
|---------|--------|
| `/career-advisor accept APP-NNN` | Accept offer, create role folder with 30/60/90 plan |
| `/career-advisor onboarding ROLE-NNN` | View/update onboarding progress |

### Phase 5: Grow & Document

See [career-growth.md](references/career-growth.md) for achievement tracking, self-reviews, growth planning, and corporate HR alignment.

| Command | Action |
|---------|--------|
| `/career-advisor achievement ROLE-NNN "Title"` | Log achievement (STAR format) |
| `/career-advisor win ROLE-NNN "Title"` | Quick win (lightweight) |
| `/career-advisor review ROLE-NNN --period "YYYY-HN"` | Generate self-review from achievements |
| `/career-advisor growth ROLE-NNN` | View/update growth plan |
| `/career-advisor ready ROLE-NNN --target "Level"` | Promotion readiness check |
| `/career-advisor quarterly` | Run quarterly review (15 min) |

---

## Career Insurance: Always Ready

See [career-growth.md](references/career-growth.md) for backfill workflow, weekly recall protocol, and file save maps.

**"The best time to document your career was the day it happened. The second best time is today."**

| Command | Action | Cadence |
|---------|--------|---------|
| `/career-advisor backfill` | Guided walkthrough to document past roles | Once per role |
| `/career-advisor recall` | Quick achievement mining — "what did you ship this week?" | Weekly (5 min) |
| `/career-advisor checkup` | Career readiness health score | Monthly (2 min) |
| `/career-advisor goals` | View/set current role goals (syncs with corporate OKRs) | As needed |

**Rules:** Nothing stays in conversation only — every backfill and recall session must write files. After saving, prompt user to review for truth: "Check that every claim is something you could defend in an interview."

---

## Analytics

| Command | Shows |
|---------|-------|
| `/career-advisor pipeline` | Applications by stage with conversion rates |
| `/career-advisor prospects` | Research pipeline + warm leads |
| `/career-advisor stats` | Conversion rates, interview success, achievement velocity |
| `/career-advisor weekly` | This week's activity summary |

---

## Naming Conventions

| Type | Prefix | Location | Example |
|------|--------|----------|---------|
| Company research | `CO-` | `3-research/companies/` | `CO-001-acme-corp.md` |
| Outreach contact | `OUT-` | `3-research/outreach/` | `OUT-001-jane-doe.md` |
| Application | `APP-` | `4-applications/` | `APP-001-acme-swe/` |
| Interview | `INT-` | Inside app/interviews/ | `INT-001-phone-screen.md` |
| Role | `ROLE-` | `5-roles/` | `ROLE-001-acme-swe/` |
| Achievement | `ACH-` | Inside role/achievements/ | `ACH-001-api-perf.md` |
| Narrative hat | `NAR-` | `2-target/narratives/` | `NAR-001-ai-infra-engineer.md` |

---

## Configuration

`config.md` in career root:

```markdown
# Career Advisor Config
**Name:** Your Name
**Email:** you@example.com
**Career Root:** my_knowledge/career
**Current Role:** ROLE-NNN (or null)
**Review Schedule:** quarterly
```

**Privacy:** Add `my_knowledge/career/` to `.gitignore` (or selectively ignore `4-applications/`, `5-roles/`, `3-research/outreach/`).

---

## Anti-Patterns

| Anti-Pattern | Why | Do This Instead |
|---|---|---|
| Jumping to resume without self-discovery | Builds on sand | Start with `/career-advisor discover` |
| Defaulting to courses for every gap | Slowest, lowest-signal closing track | Check all six closing tracks first |
| Writing achievements at review time | You'll forget 80% | Log within 24 hours: `/career-advisor win` |
| Generic resume for every application | ATS filters it out | One resume per application via resume factory |
| Skipping mock interviews | Discover gaps live instead of in practice | `/career-advisor mock` before every round |
| GitHub profile is a code dump | 30 unvetted repos repels recruiters | Curate 3-5 pins: `/career-advisor portfolio audit` |
| Past roles undocumented | Can't mine achievements you never wrote down | `/career-advisor backfill` for every past role |
| "I'll document later" | Later never comes | `/career-advisor recall` weekly — 5 minutes |
| Career folder exists but is stale | False sense of readiness | `/career-advisor checkup` monthly |
| Achievements discussed but not saved | Conversation vanishes; next session starts from zero | Every session must write files |

---

## Power Move

"I have a job posting I'm excited about. Walk me through the full process: analyze the JD against my accomplishments, identify gaps, generate a tailored resume, prepare my story inventory, and run a mock interview for the first round."

---

## Related Skills

| Skill | When to Use |
|-------|-------------|
| `startup-explorer` | Mine career data for startup ideas, find niche, frame hypothesis |
| `landing-page-service-discovery` | Package expertise as a consulting service (consulting-first path) |
| `open-source-contribution` | Build credibility through OSS contributions (feeds portfolio) |
| `technical-writing` | Write articles/talks to close visibility gaps |
