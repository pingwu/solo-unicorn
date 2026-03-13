---
name: career-lifecycle
description: Complete career lifecycle — track applications, generate resumes, log interviews, onboard effectively, document achievements, analyze skill gaps, and plan growth for performance reviews.
---

# Career Lifecycle Management

This folder manages your entire career lifecycle—from job search to role performance and growth.

## Purpose
- **Job Search:** Research companies, track applications, generate tailored resumes
- **Interview Prep:** Log interviews, learn from feedback, improve over time
- **Onboarding:** Track 30-60-90 day progress in new roles
- **Achievement Tracking:** Document wins for performance reviews
- **Growth Planning:** Skill gap analysis, learning plans, promotion readiness

## Structure

```
career/
├── INDEX.md                           # Central tracker - current role + applications
├── Accomplishments-Tracker.md         # Master career history & achievements
│
├── research/                          # PRE-APPLICATION (company & market research)
│   ├── companies/CO-001-Acme.md
│   └── outreach/OUT-001-JohnDoe.md
│
├── applications/                      # APPLICATION PHASE
│   └── APP-001-Company-Role/
│       ├── JD-Company-Role.md         # Job description + analysis
│       ├── Resume-Company-Role.md     # Generated tailored resume
│       ├── notes.md                   # Research, contacts, prep
│       └── INT-001-PhoneScreen.md     # Interview records
│
└── roles/                             # POST-HIRE PHASE
    └── ROLE-001-Company-Role/
        ├── onboarding.md              # 30-60-90 day plan
        ├── achievements/              # Achievement records (STAR format)
        │   └── ACH-001-Project.md
        ├── reviews/                   # Self-assessments
        │   └── 2026-H1-Self-Review.md
        └── growth.md                  # Skill gaps, learning plans, promotion path
```

## Getting Started

### For Job Search
1. Copy this folder to `my_knowledge/career/`
2. Edit `Accomplishments-Tracker.md` with your career history
3. Use `/career-resume research "Company"` to start researching
4. Use `/career-resume new "Company" "Role"` to create applications
5. Use `/career-resume generate APP-001` to create tailored resumes

### For Current Role (Post-Hire)
1. Use `/career-resume accept APP-001` to create role folder
2. Track 30-60-90 onboarding in `onboarding.md`
3. Log achievements as they happen with `/career-resume achievement`
4. Analyze skill gaps with `/career-resume gaps ROLE-001`
5. Create learning plans with `/career-resume learn ROLE-001 --skill "X"`
6. Generate self-reviews with `/career-resume review ROLE-001 --period "H1"`

## Related Skill

See `skills/career-resume/SKILL.md` for full documentation and commands.
