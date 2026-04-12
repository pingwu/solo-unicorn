---
name: career-tracker
description: >
  Full-lifecycle career management — from self-discovery and identity exploration (ikigai, values, skills, passions)
  through dream job gap analysis, job search (applications, ATS-optimized resumes, mock interviews),
  post-hire onboarding, achievement tracking, self-reviews, and career growth planning.
  Use when the user wants to: (1) discover who they are and what they want (ikigai, values, identity),
  (2) analyze career gaps and build learning plans, (3) search for jobs, create applications, or generate resumes,
  (4) prepare for or debrief interviews, (5) run mock interviews, (6) track onboarding progress at a new role,
  (7) log achievements and build self-reviews, (8) plan skill development and career growth,
  (9) initialize or manage their career tracking folder.
  Serves students, parents, young adults, early-career professionals, and mid-career changers.
  Encourages authentic identity discovery over job-title pigeonholing.
---

# Career Tracker

A complete career management system: discover who you are, define where you're going, close the gaps, land the role, and keep growing after you arrive.

## Core Philosophy

**"Don't start with job titles. Start with who you are."**

- Identity is not a job title. You are not "a developer" or "a manager" — you are a person who builds, leads, teaches, creates.
- Roles are vehicles, not destinations. Help users make **deliberate choices** instead of feeling stuck.
- Track everything. Your future self will thank you for the notes you write today.
- This system serves everyone: students exploring for the first time, parents returning to work, mid-career changers reinventing themselves, executives planning their next chapter.

---

## The Career Journey

```
DISCOVER → DEFINE → CLOSE GAPS → SEARCH → LAND → GROW → (repeat)
   │          │         │           │        │       │
   │          │         │           │        │       └─ Achievements, Reviews, Promotions
   │          │         │           │        └─ Onboarding 30/60/90
   │          │         │           └─ Applications, Resumes, Interviews
   │          │         └─ Learning Plans, Projects, Credentials
   │          └─ Dream Job, Gap Analysis
   └─ Ikigai, Values, Identity, Skills Inventory
```

---

## Quick Start

### Initialize Career Folder

```
/career-tracker init
```

Creates:
```
my_knowledge/career/
├── INDEX.md                    # Central dashboard
├── MY-IDENTITY.md              # Self-discovery: ikigai, values, identity
├── Accomplishments-Tracker.md  # Master career history
├── research/                   # Company & market research
│   ├── companies/
│   ├── market/
│   └── outreach/
├── opportunities/              # Pre-application JDs under evaluation
├── applications/               # One folder per application (APP-NNN)
└── roles/                      # Post-hire tracking (ROLE-NNN)
```

### Initialize with Self-Discovery

```
/career-tracker discover
```

Creates `MY-IDENTITY.md` and walks through the ikigai framework, values assessment, and identity exploration interactively. See [self-discovery.md](references/self-discovery.md) for the full framework.

---

## Phase 0: Discover Who You Are

Before any job search or career decision. Read [self-discovery.md](references/self-discovery.md) for the complete framework.

### Commands

| Command | Action |
|---------|--------|
| `/career-tracker discover` | Interactive self-discovery (ikigai + values + identity) |
| `/career-tracker values` | Values assessment and ranking |
| `/career-tracker skills` | Skills inventory (hard, soft, hidden) |
| `/career-tracker vision` | Career vision statement + three horizons |
| `/career-tracker identity` | View or update MY-IDENTITY.md |

### Key Deliverable: MY-IDENTITY.md

Contains: ikigai map (four circles + intersection), ranked values, identity statements beyond job titles, role archetypes, skills inventory, career vision with three horizons.

---

## Phase 1: Define Your Dream & Analyze Gaps

Read [gap-analysis.md](references/gap-analysis.md) for dream job definition, gap classification, and closing tracks.

### Commands

| Command | Action |
|---------|--------|
| `/career-tracker dream` | Define or update dream job |
| `/career-tracker gaps` | Run gap analysis (vault vs. dream JDs) |
| `/career-tracker learn` | Create or update learning plan |
| `/career-tracker closing` | View active gap-closing work |

### Key Deliverables
- **DREAM-JOB.md** — target role, companies, conditions, gap analysis tables
- **LEARNING-PLAN.md** — active learning with tracks, timelines, and evidence

### Gap Classification
- `HARD` — gate you won't pass without it → needs a closing plan
- `SOFT` — preference, offset by strengths → needs a story
- `NARRATIVE` — you have it, just haven't framed it → close in an afternoon

### Six Closing Tracks (Don't Default to Courses)
1. **Formal Learning** — when the credential itself is the signal
2. **Build Something** — a deployed project > a certificate
3. **Earn Reps** — freelance/consulting to earn real STAR stories
4. **Write or Teach** — closes visibility gaps, forces genuine learning
5. **Network Proximity** — proximity produces referrals
6. **Reframe** — check if it's really a narrative gap in disguise

---

## Phase 2: Search & Apply

Read [job-search.md](references/job-search.md) for full application workflow, resume factory, and interview system.

### Commands

| Command | Action |
|---------|--------|
| `/career-tracker research "Company"` | Create company research file |
| `/career-tracker outreach "Name"` | Track networking contact |
| `/career-tracker new "Company" "Role"` | Create new application folder |
| `/career-tracker resume APP-NNN` | Generate ATS-optimized resume from JD + vault |
| `/career-tracker status APP-NNN [stage]` | Update application status |
| `/career-tracker pipeline` | View all applications by stage |

### Resume Factory Process
1. Save JD verbatim
2. Extract ATS keywords (exact tool names, action verbs, industry language)
3. Mine Accomplishments-Tracker for matching stories
4. Build resume: right length, keywords matched, everything quantified
5. ATS check before submitting

### Application Pipeline

```
researching → resume-ready → applied → phone-screen → technical → behavioral → onsite → offer → accepted
                                                                                          ↓
                                                                                   rejected / withdrawn / ghosted
```

---

## Phase 3: Interview & Win

Read [job-search.md](references/job-search.md) — Interview System and Mock Interview Protocol sections.

### Commands

| Command | Action |
|---------|--------|
| `/career-tracker prep APP-NNN` | Story inventory + prep for next interview |
| `/career-tracker mock APP-NNN [round-type]` | Run mock interview (stays in character until "debrief") |
| `/career-tracker interview APP-NNN [stage]` | Log a completed interview |
| `/career-tracker reflect APP-NNN INT-NNN` | Post-interview reflection |

### Story Inventory (Before Every Interview)

```
[ ] 30-second positioning pitch
[ ] One "impact at scale" story (quantified)
[ ] One "technical depth" story
[ ] One "conflict or pushback" story
[ ] One "failure or course correction" story
[ ] One "why this company" answer
[ ] Two genuine questions to ask them
```

### Mock Interview Protocol
1. Specify round type + interviewer role
2. Claude stays in interviewer mode — no hints
3. User says **"debrief"** to get structured feedback
4. Feedback: what landed, what was thin, what to fix before real interview

---

## Phase 4: Land & Onboard

Read [career-growth.md](references/career-growth.md) for onboarding system and relationship mapping.

### Commands

| Command | Action |
|---------|--------|
| `/career-tracker accept APP-NNN` | Accept offer, create role folder with 30/60/90 plan |
| `/career-tracker onboarding ROLE-NNN` | View/update onboarding progress |
| `/career-tracker people ROLE-NNN` | Manage relationship map |

---

## Phase 5: Grow & Document

Read [career-growth.md](references/career-growth.md) for achievement tracking, self-reviews, and growth planning.

### Commands

| Command | Action |
|---------|--------|
| `/career-tracker achievement ROLE-NNN "Title"` | Log achievement (STAR format) |
| `/career-tracker win ROLE-NNN "Title"` | Quick win (lightweight) |
| `/career-tracker achievements ROLE-NNN` | View all achievements |
| `/career-tracker review ROLE-NNN --period "YYYY-HN"` | Generate self-review from achievements |
| `/career-tracker gaps ROLE-NNN` | In-role skill gap analysis |
| `/career-tracker growth ROLE-NNN` | View/update growth plan |
| `/career-tracker ready ROLE-NNN --target "Level"` | Promotion readiness check |
| `/career-tracker sync ROLE-NNN` | Copy achievements to master Accomplishments-Tracker |
| `/career-tracker quarterly` | Run quarterly review (15 min) |

### Quarterly Review (Even When Not Searching)
1. Achievement sweep — log anything missed
2. Accomplishments sync — copy to master tracker
3. Growth check — update gaps and learning
4. Narrative check — does positioning still reflect reality?
5. Market pulse — note new trends

---

## Analytics

| Command | Shows |
|---------|-------|
| `/career-tracker pipeline` | Applications by stage with conversion rates |
| `/career-tracker prospects` | Research pipeline + warm leads |
| `/career-tracker stats` | Application conversion, interview success, achievement velocity |
| `/career-tracker weekly` | This week's activity summary |

---

## All Templates

See [templates.md](references/templates.md) for every file template in the system.

---

## Configuration

Create `.claude/career-tracker.json`:

```json
{
  "career_root": "my_knowledge/career",
  "user_name": "Your Name",
  "current_role": null,
  "review_schedule": "quarterly"
}
```

---

## Privacy

Career data is sensitive. Recommended `.gitignore`:

```gitignore
my_knowledge/career/
```

Or selective:
```gitignore
my_knowledge/career/applications/
my_knowledge/career/roles/
my_knowledge/career/research/outreach/
.claude/career-tracker.json
```

---

## Related Skills

| Skill | When to Use |
|-------|-------------|
| `career-resume` | Legacy skill — `career-tracker` is the comprehensive replacement |
| `portfolio-strategy` | Curate GitHub repos into a coherent hiring story |
| `github-profile` | Optimize GitHub profile for recruiters |
