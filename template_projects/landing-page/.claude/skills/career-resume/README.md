---
name: career-resume-readme
description: Overview of the career resume skill covering job search, applications, interviews, onboarding, achievements, and growth tracking.
---

# Career Resume Skill

Complete career lifecycle management: research companies, generate targeted resumes, track applications, ace interviews, onboard effectively, analyze skill gaps, create learning plans, and document achievements for performance reviews.

## Features

### Job Search Phase
- **Company Research:** Due diligence on potential employers (tech stack, culture, growth)
- **Outreach Tracking:** Manage networking contacts and referral requests
- **Resume Generation:** Match accomplishments to job requirements with skill inference
- **Application Tracking:** One folder per application, central INDEX for pipeline view
- **Interview Logging:** Record questions, answers, and feedback to improve over time

### Post-Hire Phase
- **Onboarding:** 30-60-90 day plans with progress tracking
- **Achievement Documentation:** STAR-format records for performance reviews
- **Self-Reviews:** Periodic assessments tied to achievements and goals
- **Skill Gap Analysis:** Compare current skills to target level requirements
- **Learning Plans:** Structured development with resources and timelines
- **Promotion Readiness:** Track requirements and evidence for next level

---

## Quick Start

### For Job Search

```bash
# 1. Initialize career folder
/career-resume init

# 2. Add your accomplishments
# Edit my_knowledge/career/Accomplishments-Tracker.md

# 3. Research a company
/career-resume research "Acme Corp"

# 4. Start an application
/career-resume new "Acme Corp" "Senior Developer"

# 5. Generate tailored resume
/career-resume generate APP-001
```

### For Current Role

```bash
# 1. Accept offer and create role folder
/career-resume accept APP-001 --start-date "2026-03-01"

# 2. Track onboarding progress
/career-resume onboarding ROLE-001

# 3. Log achievements as they happen
/career-resume achievement ROLE-001 "Reduced API latency by 40%"

# 4. Analyze skill gaps
/career-resume gaps ROLE-001

# 5. Create learning plans
/career-resume learn ROLE-001 --skill "system-design"

# 6. Generate self-review
/career-resume review ROLE-001 --period "2026-H1"
```

---

## Career Lifecycle

```
RESEARCH ──→ APPLY ──→ INTERVIEW ──→ OFFER ──→ ONBOARD ──→ PERFORM ──→ GROW
                                                   │           │         │
                                                   │           ▼         │
                                                   │    ┌─────────────┐  │
                                                   │    │ ACHIEVEMENTS │  │
                                                   │    │  & REVIEWS   │  │
                                                   │    └──────┬──────┘  │
                                                   │           │         │
                                                   │           ▼         │
                                                   │    ┌─────────────┐  │
                                                   │    │  SKILL GAP  │◄─┘
                                                   │    │  & LEARNING │
                                                   │    └─────────────┘
                                                   │           │
                                                   └───────────┘
                                                         │
                                           Feeds Accomplishments-Tracker
                                              (for next opportunity)
```

---

## File Structure

### Skill Files (Generic — stays in repo)

```
skills/career-resume/
├── SKILL.md                                    # Main skill definition
├── README.md                                   # This file
├── assets/
│   ├── accomplishments-template.md             # Career history template
│   ├── index-template.md                       # INDEX.md template
│   ├── resume-template.md                      # Resume output format
│   ├── company-research-template.md            # Company due diligence
│   ├── outreach-template.md                    # Networking contact tracking
│   ├── application-folder-template/            # Per-application templates
│   │   ├── JD-TEMPLATE.md
│   │   ├── notes-TEMPLATE.md
│   │   └── interview-TEMPLATE.md
│   └── role-folder-template/                   # Post-hire templates
│       ├── onboarding-TEMPLATE.md              # 30-60-90 day plan
│       ├── growth-TEMPLATE.md                  # Skill gaps & learning plans
│       ├── achievements/
│       │   └── achievement-TEMPLATE.md         # STAR format achievement
│       └── reviews/
│           └── review-TEMPLATE.md              # Self-assessment
└── references/
    └── skill-inference-rules.md                # Inference logic
```

### Personal Files (Your data — gitignored)

```
my_knowledge/career/
├── INDEX.md                                    # Central status tracker
├── Accomplishments-Tracker.md                  # Master career history
│
├── research/                                   # PRE-APPLICATION PHASE
│   ├── companies/
│   │   ├── CO-001-Acme.md
│   │   └── CO-002-Beta.md
│   ├── market/
│   │   └── 2026-Q1-SeniorDev-Market.md
│   └── outreach/
│       ├── OUT-001-JohnDoe-Referral.md
│       └── OUT-002-JaneSmith-Recruiter.md
│
├── applications/                               # APPLICATION PHASE
│   ├── APP-001-Acme-SeniorDev/
│   │   ├── JD-Acme-SeniorDev.md
│   │   ├── Resume-Acme-SeniorDev.md
│   │   ├── notes.md
│   │   ├── INT-001-PhoneScreen.md
│   │   └── INT-002-Technical.md
│   └── APP-002-Beta-StaffEng/
│       └── ...
│
└── roles/                                      # POST-HIRE PHASE
    └── ROLE-001-Acme-SeniorDev/
        ├── onboarding.md                       # 30-60-90 day plan
        ├── achievements/
        │   ├── ACH-001-API-Performance.md
        │   └── ACH-002-Team-Onboarding.md
        ├── reviews/
        │   ├── 2026-H1-Self-Review.md
        │   └── 2026-H2-Self-Review.md
        ├── feedback/
        │   └── 2026-Q2-Manager-Feedback.md
        └── growth.md                           # Skill gaps & learning plans
```

---

## Naming Convention

| Type | Prefix | Location | Example |
|------|--------|----------|---------|
| Company research | `CO-` | `research/companies/` | `CO-001-Acme.md` |
| Outreach contact | `OUT-` | `research/outreach/` | `OUT-001-JohnDoe.md` |
| Application | `APP-` | `applications/` | `APP-001-Acme-SeniorDev/` |
| Job description | `JD-` | Inside app folder | `JD-Acme-SeniorDev.md` |
| Resume | `Resume-` | Inside app folder | `Resume-Acme-SeniorDev.md` |
| Interview | `INT-` | Inside app folder | `INT-001-PhoneScreen.md` |
| Role | `ROLE-` | `roles/` | `ROLE-001-Acme-SeniorDev/` |
| Achievement | `ACH-` | Inside role folder | `ACH-001-API-Performance.md` |

---

## Commands

### Research Phase

```bash
# Research a company
/career-resume research "Acme Corp"

# Track networking contact
/career-resume outreach "John Doe" --relationship "former colleague" --company "Acme"

# Market research
/career-resume market "Senior Developer" --location "Remote US"

# View research pipeline
/career-resume prospects
```

### Application Phase

```bash
# Create new application
/career-resume new "Company" "Role"
/career-resume new "Company" "Role" --source referral --referral "John Doe"

# Generate tailored resume
/career-resume generate APP-001

# Update status
/career-resume status APP-001 applied
/career-resume status APP-001 phone-screen
/career-resume status APP-001 technical
/career-resume status APP-001 offer --salary "$180k" --deadline "2026-02-20"
/career-resume status APP-001 accepted
/career-resume status APP-001 rejected --reason "Internal candidate"
```

### Interview Phase

```bash
# Create interview record
/career-resume interview APP-001 phone-screen
/career-resume interview APP-001 technical --date "2026-02-15 10:00"

# Get interview prep
/career-resume prep APP-001

# Record reflection
/career-resume reflect APP-001 INT-001
```

### Onboarding Phase

```bash
# Accept offer and create role folder
/career-resume accept APP-001 --start-date "2026-03-01"

# View/update onboarding progress
/career-resume onboarding ROLE-001
```

### Achievement Phase

```bash
# Log achievement (full STAR format)
/career-resume achievement ROLE-001 "Reduced API latency by 40%"

# Quick win (lightweight)
/career-resume win ROLE-001 "Mentored new hire through first PR"

# View achievements
/career-resume achievements ROLE-001
/career-resume achievements ROLE-001 --summary
```

### Skill Gap & Growth Phase

```bash
# Analyze skill gaps
/career-resume gaps ROLE-001

# Create learning plan for a skill
/career-resume learn ROLE-001 --skill "system-design"

# View growth plan
/career-resume growth ROLE-001

# Update learning progress
/career-resume progress ROLE-001 --skill "system-design"

# Check promotion readiness
/career-resume ready ROLE-001 --target "Staff Engineer"
```

### Self-Review Phase

```bash
# Create self-review document
/career-resume review ROLE-001 --period "2026-H1"

# Sync achievements to Accomplishments-Tracker
/career-resume sync ROLE-001
```

### Analytics

```bash
# View application pipeline
/career-resume pipeline

# Conversion stats
/career-resume stats

# Weekly review
/career-resume weekly
```

---

## Customization

### Configuration File

Create `.claude/career-resume.json`:

```json
{
  "career_root": "my_knowledge/career",
  "user_name": "Your Name",
  "contact": {
    "email": "you@example.com",
    "phone": "+1 555-555-5555"
  },
  "current_role": "ROLE-001",
  "review_schedule": "quarterly"
}
```

### Environment Variable

Keep career data outside repo:

```bash
export CAREER_ROOT="$HOME/private/career"
```

### Custom Templates

Copy and modify templates in `assets/` to match your preferences.

---

## Privacy Setup

### Option A: Gitignore All Career Data

```gitignore
my_knowledge/career/
.claude/career-resume.json
```

### Option B: Keep Structure, Ignore Content

```gitignore
my_knowledge/career/applications/
my_knowledge/career/roles/
my_knowledge/career/research/outreach/
my_knowledge/career/INDEX.md
my_knowledge/career/Accomplishments-Tracker.md
```

### Option C: External Location

Use environment variable to store career data outside the repo entirely.

---

## Templates Reference

| Template | Purpose |
|----------|---------|
| `accomplishments-template.md` | Master career history |
| `index-template.md` | Central tracker |
| `company-research-template.md` | Company due diligence |
| `outreach-template.md` | Networking contact tracking |
| `application-folder-template/` | JD, Resume, notes, interviews |
| `role-folder-template/onboarding-TEMPLATE.md` | 30-60-90 day plan |
| `role-folder-template/growth-TEMPLATE.md` | Skill gaps, learning plans, promotion path |
| `role-folder-template/achievements/achievement-TEMPLATE.md` | STAR format achievement |
| `role-folder-template/reviews/review-TEMPLATE.md` | Self-assessment document |
| `references/skill-inference-rules.md` | Skill inference logic |

---

## Workflow Examples

### Job Search Workflow

```bash
# 1. Research target companies
/career-resume research "Acme Corp"
/career-resume research "Beta Inc"

# 2. Reach out to contacts
/career-resume outreach "John Doe" --company "Acme"

# 3. Create application when ready
/career-resume new "Acme Corp" "Senior Developer" --source referral

# 4. Generate resume
/career-resume generate APP-001

# 5. Track through pipeline
/career-resume status APP-001 applied
/career-resume interview APP-001 phone-screen
/career-resume status APP-001 phone-screen
# ... continue through process

# 6. Weekly review
/career-resume weekly
```

### Post-Hire Workflow

```bash
# 1. Accept offer
/career-resume accept APP-001 --start-date "2026-03-01"

# 2. Track onboarding (update weekly)
/career-resume onboarding ROLE-001

# 3. Log achievements as they happen
/career-resume achievement ROLE-001 "Shipped user preferences feature"
/career-resume win ROLE-001 "Presented architecture to team"

# 4. Quarterly: Analyze gaps and plan learning
/career-resume gaps ROLE-001
/career-resume learn ROLE-001 --skill "system-design"

# 5. Review period: Generate self-assessment
/career-resume review ROLE-001 --period "2026-H1"

# 6. Sync achievements to master tracker
/career-resume sync ROLE-001
```

### Promotion Planning Workflow

```bash
# 1. Check current gaps
/career-resume gaps ROLE-001

# 2. Check readiness for target level
/career-resume ready ROLE-001 --target "Staff Engineer"

# 3. Create learning plans for critical gaps
/career-resume learn ROLE-001 --skill "system-design"
/career-resume learn ROLE-001 --skill "cross-team-influence"

# 4. Track progress monthly
/career-resume progress ROLE-001 --skill "system-design"

# 5. Document achievements that demonstrate growth
/career-resume achievement ROLE-001 "Led auth migration design"
```
