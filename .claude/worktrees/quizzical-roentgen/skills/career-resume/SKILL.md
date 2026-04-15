---
name: career-resume
description: Complete career lifecycle management — research companies, generate resumes, track applications, log interviews, onboard effectively, analyze skill gaps, create learning plans, and document achievements for performance reviews.
---

# Career Resume Skill

End-to-end career lifecycle: research opportunities, generate targeted resumes, track applications, ace interviews, onboard successfully, identify skill gaps, build learning plans, and document achievements for performance reviews and future opportunities.

## Core Principles

- **"Match what you've done to what they need—truthfully."**
- **"Track everything—learn from every application."**
- **"Document achievements as they happen—your future self will thank you."**

---

## Career Lifecycle

```
┌──────────────────────────────────────────────────────────────────────────────┐
│                                                                              │
│  RESEARCH ──→ APPLY ──→ INTERVIEW ──→ OFFER ──→ ONBOARD ──→ PERFORM ──→ GROW │
│     │                                              │            │         │  │
│     │                                              │            ▼         │  │
│     │                                              │     ┌─────────────┐  │  │
│     │                                              │     │ ACHIEVEMENTS │  │  │
│     │                                              │     │   & REVIEWS  │  │  │
│     │                                              │     └──────┬──────┘  │  │
│     │                                              │            │         │  │
│     │                                              │            ▼         │  │
│     │                                              │     ┌─────────────┐  │  │
│     │                                              │     │  SKILL GAP  │◄─┘  │
│     │                                              │     │  ANALYSIS & │     │
│     │                                              │     │   LEARNING  │     │
│     │                                              │     └──────┬──────┘     │
│     │                                              │            │            │
│     └──────────────────────────────────────────────┴────────────┘            │
│                              ▲                                               │
│                              │                                               │
│                    Feeds Accomplishments-Tracker                             │
│                       (for next opportunity)                                 │
└──────────────────────────────────────────────────────────────────────────────┘
```

---

## Quick Start

### Initialize Career Folder

```
/career-resume init
```

Creates:
```
my_knowledge/career/
├── INDEX.md                    # Central status tracker
├── Accomplishments-Tracker.md  # Your career history
├── research/                   # Company & market research
├── applications/               # One folder per application
└── roles/                      # Post-hire achievement tracking
```

---

## File Structure

### Complete Structure

```
my_knowledge/career/
├── INDEX.md                           # Central tracker for everything
├── Accomplishments-Tracker.md         # Master career history
│
├── research/                          # PRE-APPLICATION PHASE
│   ├── companies/                     # Company research (CO- prefix)
│   │   ├── CO-001-Acme.md
│   │   └── CO-002-Beta.md
│   ├── market/                        # Market/salary research
│   │   └── 2026-Q1-SeniorDev-Market.md
│   └── outreach/                      # Networking contacts (OUT- prefix)
│       ├── OUT-001-JohnDoe-Referral.md
│       └── OUT-002-JaneSmith-Recruiter.md
│
├── applications/                      # APPLICATION PHASE
│   ├── APP-001-Acme-SeniorDev/
│   │   ├── JD-Acme-SeniorDev.md
│   │   ├── Resume-Acme-SeniorDev.md
│   │   ├── notes.md
│   │   ├── INT-001-PhoneScreen.md
│   │   └── INT-002-Technical.md
│   └── APP-002-Beta-StaffEng/
│       └── ...
│
└── roles/                             # POST-HIRE PHASE
    └── ROLE-001-Acme-SeniorDev/
        ├── onboarding.md              # 30-60-90 day plan & progress
        ├── achievements/              # Achievement records (ACH- prefix)
        │   ├── ACH-001-API-Performance.md
        │   ├── ACH-002-Team-Onboarding.md
        │   └── ACH-003-Cost-Reduction.md
        ├── reviews/                   # Self-assessments
        │   ├── 2026-H1-Self-Review.md
        │   └── 2026-H2-Self-Review.md
        ├── feedback/                  # Feedback received
        │   └── 2026-Q2-Manager-Feedback.md
        └── growth.md                  # Skill gaps, learning plans, career trajectory
```

### Naming Convention

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

## Phase 1: Research

### Research a Company

```
/career-resume research "Acme Corp"
```

Creates `research/companies/CO-001-Acme.md` with template for:
- Company overview (size, funding, industry)
- Tech stack and engineering culture
- Glassdoor/Blind reviews summary
- Recent news and growth trajectory
- Key contacts and referral paths
- Open roles of interest

### Track Outreach/Networking

```
/career-resume outreach "John Doe" --relationship "former colleague" --company "Acme"
```

Creates `research/outreach/OUT-001-JohnDoe.md` to track:
- Relationship context
- Conversation history
- Referral status
- Follow-up schedule

### Market Research

```
/career-resume market "Senior Developer" --location "Remote US"
```

Creates market research file with:
- Salary ranges by company tier
- Demand trends
- Common requirements
- Negotiation benchmarks

### View Research Pipeline

```
/career-resume prospects
```

Shows companies researched, outreach status, and warm leads.

---

## Phase 2: Apply

### Create New Application

```
/career-resume new "Acme Corp" "Senior Developer"
/career-resume new "Acme Corp" "Senior Developer" --source referral --referral "John Doe"
```

Creates application folder, links to company research if exists.

### Generate Resume

```
/career-resume generate APP-001
```

Matches accomplishments to JD requirements with skill inference.

### Update Status

```
/career-resume status APP-001 applied
/career-resume status APP-001 phone-screen
/career-resume status APP-001 technical --date 2026-02-15
/career-resume status APP-001 onsite
/career-resume status APP-001 offer --salary "$180,000" --deadline "2026-02-20"
/career-resume status APP-001 accepted
/career-resume status APP-001 rejected --reason "Went with internal candidate"
/career-resume status APP-001 withdrawn --reason "Accepted other offer"
```

**Status Flow:**
```
researching → applied → phone-screen → technical → onsite → offer → accepted
                                                              ↓
                                                          rejected/withdrawn
```

---

## Phase 3: Interview

### Add Interview

```
/career-resume interview APP-001 phone-screen
/career-resume interview APP-001 technical --date "2026-02-15 10:00"
/career-resume interview APP-001 onsite --interviewers "Alice, Bob, Carol"
```

### Interview Prep

```
/career-resume prep APP-001
```

Suggests stories from accomplishments that match JD requirements.

### Post-Interview Reflection

```
/career-resume reflect APP-001 INT-001
```

Record what went well, what to improve, better answers for next time.

---

## Phase 4: Offer & Onboarding

### Accept Offer & Start Role

```
/career-resume accept APP-001 --start-date "2026-03-01"
```

Creates `roles/ROLE-001-Acme-SeniorDev/` with:
- `onboarding.md` — 30-60-90 day plan template
- `achievements/` — folder for tracking wins
- `reviews/` — folder for self-assessments
- `growth.md` — development goals

Links back to the application for context.

### Track Onboarding Progress

```
/career-resume onboarding ROLE-001
```

View and update your 30-60-90 day plan:

```markdown
## 30-Day Goals (Learning)
- [x] Complete HR onboarding
- [x] Set up development environment
- [ ] Meet with all team members 1:1
- [ ] Understand current architecture

## 60-Day Goals (Contributing)
- [ ] Ship first PR to production
- [ ] Own a small feature end-to-end
- [ ] Document one undocumented system

## 90-Day Goals (Impact)
- [ ] Lead a small project
- [ ] Identify one improvement opportunity
- [ ] Present to team on learnings
```

---

## Phase 5: Perform & Document

### Log Achievement (As It Happens!)

```
/career-resume achievement ROLE-001 "Reduced API latency by 40%"
```

Creates `achievements/ACH-001-API-Latency.md`:

```markdown
# Achievement: Reduced API Latency by 40%

**Date:** 2026-05-15
**Role:** ROLE-001 - Senior Developer @ Acme
**Category:** Performance / Technical

## Summary
Reduced API latency by 40% by implementing Redis caching layer.

## Context (Situation)
Dashboard loading times were causing customer complaints. P95 latency was 2.5s.

## What I Did (Action)
- Profiled slow endpoints to identify bottlenecks
- Designed caching strategy with cache invalidation
- Implemented Redis caching layer
- Set up monitoring dashboards

## Results (Quantified)
- P95 latency: 2.5s → 1.5s (40% reduction)
- Customer complaints about speed: -60%
- Cache hit rate: 85%

## Evidence
- [ ] Link to PR/commit
- [ ] Screenshot of metrics
- [ ] Slack thread with positive feedback

## Skills Demonstrated
- Performance optimization
- Redis/caching
- Monitoring & observability

## Visibility
- Who knows about this? Manager, team lead
- Presented at: Team meeting 2026-05-20
```

### Quick Achievement (Lightweight)

```
/career-resume win ROLE-001 "Mentored new hire through first PR"
```

Creates a shorter achievement record for smaller wins.

### View Achievements

```
/career-resume achievements ROLE-001
```

Lists all achievements with dates and categories.

---

## Phase 6: Skill Gap Analysis & Growth Planning

### Analyze Skill Gaps

```
/career-resume gaps ROLE-001
```

Compares your current skills to target level requirements:

```markdown
## Gap Analysis: Senior → Staff Engineer

### 🔴 Critical Gaps (Blocking Progression)
| Skill | Current | Required | Priority |
|-------|---------|----------|----------|
| System design | Competent | Expert | High |
| Cross-team influence | Beginner | Proficient | High |

### 🟡 Important Gaps
| Skill | Current | Required | Priority |
|-------|---------|----------|----------|
| Technical writing | Competent | Proficient | Medium |

### 🟢 On Track
| Skill | Current | Required |
|-------|---------|----------|
| Core coding | Expert | Expert |
| Code review | Proficient | Proficient |
```

### Create Learning Plan

```
/career-resume learn ROLE-001 --skill "system-design"
```

Creates a structured learning plan for a specific skill gap:

```markdown
## Learning Plan: System Design

**Priority:** 🔴 Critical
**Timeline:** Q1-Q2 2026
**Success Metric:** Lead design of 2 medium-scale systems

### Weekly Plan
| Week | Activity | Resource | Hours |
|------|----------|----------|-------|
| 1-2 | Fundamentals | "Designing Data-Intensive Apps" Ch 1-4 | 6 |
| 3-4 | Patterns | System Design Primer (GitHub) | 4 |
| 5-6 | Practice | Mock design: URL shortener | 4 |
| 7-8 | Apply | Lead feature design at work | 8 |

### Evidence of Completion
- [ ] Completed design doc reviewed by senior engineer
- [ ] Presented design to team
- [ ] Design implemented successfully
```

### View Growth Plan

```
/career-resume growth ROLE-001
```

Shows overall development status, active learning, and progression readiness.

### Update Growth Plan

```
/career-resume growth ROLE-001 --update
```

Interactively update progress on learning goals and skill development.

### Track Learning Progress

```
/career-resume progress ROLE-001 --skill "system-design"
```

Updates status on a specific learning plan.

### Promotion Readiness Check

```
/career-resume ready ROLE-001 --target "Staff Engineer"
```

Shows checklist of requirements and gap status for target level:

```markdown
## Promotion Readiness: Staff Engineer

### Technical (3/5 met)
- ✅ Deep expertise in core domain
- ✅ Can debug complex production issues
- ⚠️ System design — improving (60%)
- ❌ Technical strategy — needs experience
- ❌ Cross-system impact — needs scope

### Leadership (2/4 met)
- ✅ Mentors junior developers
- ✅ Code review quality
- ⚠️ Project leadership — in progress
- ❌ Org-wide influence — not started

### Readiness: 55% — Focus on critical gaps
```

---

## Phase 7: Self-Review

### Create Review Document

```
/career-resume review ROLE-001 --period "2026-H1"
```

Creates `reviews/2026-H1-Self-Review.md` with:

```markdown
# Self-Review: 2026 H1

**Role:** Senior Developer @ Acme
**Period:** January - June 2026
**Review Date:** 2026-06-15

## Performance Summary

### Key Achievements This Period
<!-- Auto-populated from achievements/ folder -->
1. **ACH-001: Reduced API latency by 40%** — Performance optimization
2. **ACH-002: Onboarded 2 new team members** — Leadership
3. **ACH-003: Led migration to new auth system** — Technical leadership

### Goals vs. Actuals

| Goal | Target | Actual | Status |
|------|--------|--------|--------|
| Ship 3 major features | 3 | 4 | ✅ Exceeded |
| Reduce P95 latency | <2s | 1.5s | ✅ Met |
| Mentor 1 junior dev | 1 | 2 | ✅ Exceeded |
| Complete AWS cert | Done | In progress | ⚠️ Partial |

## Honest Self-Assessment

### What Went Well
- Strong technical delivery on API performance project
- Good collaboration with product team
- Effective mentoring of new hires

### What Could Be Better
- Missed deadline on auth migration (scope creep)
- Could improve documentation habits
- Need to speak up more in architecture discussions

### Feedback Received
- Manager: "Strong technical skills, keep developing leadership"
- Peer: "Great at explaining complex concepts"
- Skip-level: "Would like to see more initiative on cross-team projects"

## Growth & Development

### Skills Developed
- Redis/caching at scale
- Technical mentoring
- Cross-team collaboration

### Areas to Develop
- System design communication
- Project estimation
- Public speaking (tech talks)

### Goals for Next Period
1. Lead a cross-team initiative
2. Give 1 tech talk (internal or external)
3. Complete AWS Solutions Architect certification
4. Improve estimation accuracy to within 20%

## Career Trajectory

### Current Level: Senior Developer
### Target Level: Staff Engineer
### Gap Analysis:
- ✅ Technical depth — on track
- ⚠️ Technical breadth — need more cross-team exposure
- ❌ Organizational impact — need to lead larger initiatives
```

### Sync to Accomplishments Tracker

```
/career-resume sync ROLE-001
```

Copies achievements from current role to master `Accomplishments-Tracker.md` in proper format for future job searches.

---

## Analytics

### Pipeline View

```
/career-resume pipeline
```

Shows applications by stage with conversion rates.

### Research Pipeline

```
/career-resume prospects
```

Shows companies researched and outreach status.

### Achievement Summary

```
/career-resume achievements ROLE-001 --summary
```

Shows achievements by category, impact, and visibility.

### Career Stats

```
/career-resume stats
```

Shows:
- Application conversion rates
- Interview success rates
- Time-to-offer metrics
- Achievement velocity in current role

### Weekly Review

```
/career-resume weekly
```

Summarizes job search activity OR current role achievements depending on phase.

---

## INDEX.md — Central Tracker

The INDEX tracks everything:

```markdown
# Career Index

**Current Status:** Employed @ Acme (ROLE-001)
**Last Updated:** 2026-06-15

## Current Role

| Role | Company | Started | Status | Achievements |
|------|---------|---------|--------|--------------|
| [ROLE-001](roles/ROLE-001-Acme-SeniorDev/) | Acme | 2026-03-01 | Active | 5 this quarter |

## Active Job Search (if any)

| ID | Company | Role | Status | Updated | Next Action |
|----|---------|------|--------|---------|-------------|
| - | - | Not actively searching | - | - |

## Research Pipeline

| ID | Company | Interest | Contacts | Status |
|----|---------|----------|----------|--------|
| [CO-001](research/companies/CO-001-Acme.md) | Acme | High | 2 | → Became ROLE-001 |

## Outreach

| ID | Contact | Company | Relationship | Last Contact | Status |
|----|---------|---------|--------------|--------------|--------|
| [OUT-001](research/outreach/OUT-001-JohnDoe.md) | John Doe | Acme | Former colleague | 2026-02-10 | Referred → Hired! |

## Archived Applications

| ID | Company | Role | Outcome | Learnings |
|----|---------|------|---------|-----------|
| [APP-001](applications/APP-001-Acme-SeniorDev/) | Acme | Senior Dev | ✅ Accepted | Strong prep paid off |
```

---

## Configuration

### Config File

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

```bash
export CAREER_ROOT="$HOME/private/career"
```

---

## Privacy

Your career data is sensitive. Recommended `.gitignore`:

```gitignore
# All career data
my_knowledge/career/

# Or selective
my_knowledge/career/applications/
my_knowledge/career/roles/
my_knowledge/career/research/outreach/
.claude/career-resume.json
```

---

## Templates Reference

| Template | Purpose |
|----------|---------|
| `accomplishments-template.md` | Master career history |
| `index-template.md` | Central tracker |
| `application-folder-template/` | Per-application files (JD, Resume, notes, interviews) |
| `company-research-template.md` | Company due diligence |
| `outreach-template.md` | Networking contact tracking |
| `role-folder-template/onboarding-TEMPLATE.md` | 30-60-90 day plan |
| `role-folder-template/achievements/achievement-TEMPLATE.md` | Individual achievement record (STAR format) |
| `role-folder-template/reviews/review-TEMPLATE.md` | Self-review document |
| `role-folder-template/growth-TEMPLATE.md` | Skill gap analysis, learning plans, career trajectory |

## Related Skills

| Skill | When to use it |
|-------|---------------|
| `portfolio-strategy` | Curate your GitHub repos into a coherent story for hiring managers |
| `github-profile` | Optimize your GitHub profile page — README, pins, topics, activity graph |
