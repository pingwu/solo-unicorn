# Templates Reference

All file templates for the career-advisor system. Use these when creating new files.

## Table of Contents

1. [INDEX.md](#indexmd)
2. [config.md](#configmd)
3. [1-identity/my-identity.md](#my-identitymd)
4. [1-identity/accomplishments.md](#accomplishmentsmd)
5. [1-identity/skills-inventory.md](#skills-inventorymd)
6. [2-target/dream-job.md](#dream-jobmd)
7. [2-target/learning-plan.md](#learning-planmd)
8. [2-target/education-log.md](#education-logmd)
9. [3-research/companies/CO-NNN](#company-research)
10. [3-research/outreach/OUT-NNN](#outreach-contact)
11. [4-applications/APP-NNN/notes.md](#application-notesmd)
12. [4-applications/APP-NNN/interviews/INT-NNN](#interview-record)
13. [5-roles/ROLE-NNN/onboarding.md](#onboardingmd)
14. [5-roles/ROLE-NNN/achievements/ACH-NNN](#achievement-record)
15. [5-roles/ROLE-NNN/reviews/self-review](#self-review)
16. [5-roles/ROLE-NNN/growth.md](#growthmd)
17. [2-target/narratives/NAR-NNN](#narrative-hat)
18. [2-target/education-log.md](#education-logmd)

---

## INDEX.md

```markdown
# Career Dashboard

**Last Updated:** YYYY-MM-DD
**Current Status:** [Exploring | Job Search Active | Employed @ Company | In Transition]

---

## Current Role (if employed)

| Role | Company | Started | Status | Achievements |
|------|---------|---------|--------|--------------|
| | | | Active | |

---

## Active Job Search

| ID | Company | Role | Status | Applied | Updated | Next Action | Priority |
|----|---------|------|--------|---------|---------|-------------|----------|
| | | | | | | | |

### Pipeline Summary

| Stage | Count |
|-------|-------|
| Researching | |
| Resume ready | |
| Applied | |
| Interviewing | |
| Offer | |

---

## This Week

### Goals
- [ ]

### Completed
- [x]

---

## Research Pipeline

| ID | Company | Interest | Contacts | Status |
|----|---------|----------|----------|--------|
| | | | | |

---

## Archived Applications

| ID | Company | Role | Outcome | Key Learning |
|----|---------|------|---------|--------------|
| | | | | |

---

## Key Dates
- **Career tracking started:** YYYY-MM-DD
- **Next quarterly review:** YYYY-MM-DD

*Next application ID: APP-001*
```

---

## config.md

```markdown
# Career Advisor Config

**Name:** Your Name
**Email:** you@example.com
**Phone:** +1 555-555-5555
**LinkedIn:** linkedin.com/in/yourname
**Location:** City, State

---

## Settings

- **Career Root:** my_knowledge/career
- **Current Role:** (none)
- **Review Schedule:** quarterly
- **Resume Default Length:** 1 page

---

## Privacy Notes

Add to .gitignore if this repo is public:
- `my_knowledge/career/`
```

---

## my-identity.md

See `references/self-discovery.md` for the full template (MY-IDENTITY.md section at bottom).

---

## accomplishments.md

```markdown
# Accomplishments Tracker

**Last Updated:** YYYY-MM-DD

> This is the most important document in the system. Resumes are carved from it.
> Write at the highest impact level. Quantify everything.

---

## Differentiating Strengths
[What makes you unique? 3-5 bullet points.]

---

## Professional Summary
[3-4 sentences positioning statement. Update when target shifts.]

---

## [Most Recent Employer] -- [Title]
**Dates:** Month YYYY - Month YYYY
**Location:** [City, State / Remote]
**Team:** [size, structure]
**Scope:** [what you were responsible for]

### Key Achievements
- **[Achievement title]**: [Quantified result]. [Context: why it mattered, who cared]
- **[Achievement title]**: [Quantified result]. [Context]

### Technical Environment
[Tools, platforms, languages, frameworks used]

### STAR Stories
#### [Story Name] [INTERVIEW-READY]
- **Situation:** [context]
- **Task:** [what needed to happen]
- **Action:** [what you did specifically]
- **Result:** [quantified outcome]

---

## [Previous Employer] -- [Title]
[Same structure as above]

---

## Education
| Degree | Institution | Year | Notes |
|--------|-------------|------|-------|
| | | | |

## Certifications
| Certification | Issuer | Date | Expiry |
|---------------|--------|------|--------|
| | | | |

## Speaking / Publications / Teaching
| Title | Type | Venue | Date |
|-------|------|-------|------|
| | | | |
```

---

## skills-inventory.md

```markdown
# Skills Inventory

**Last Updated:** YYYY-MM-DD

---

## Technical / Hard Skills

| Skill | Years | Proficiency (1-5) | Formal Training? | Used Professionally? |
|-------|-------|--------------------|--------------------|----------------------|
| | | | | |

---

## Transferable / Soft Skills

| Skill | Evidence | Frequency of Use | Feedback Received |
|-------|----------|-------------------|-------------------|
| | | | |

---

## Hidden Skills
[Things you do that you don't think of as skills]
-
-
-

---

## Skills That Transfer Across Roles

| Skill | Current Context | Could Apply To |
|-------|-----------------|----------------|
| | | |
```

---

## dream-job.md

See `references/gap-analysis.md` for the full DREAM-JOB.md template.

---

## learning-plan.md

See `references/gap-analysis.md` for the full LEARNING-PLAN.md template.

---

## Company Research

```markdown
# Company Research: [Company Name]

**ID:** CO-NNN
**Date:** YYYY-MM-DD
**Interest Level:** High / Medium / Low

## Overview
- **Industry:**
- **Size:** [employees, revenue]
- **Founded:**
- **HQ:**
- **Funding/Stage:**

## Tech Stack & Culture
- **Technologies:**
- **Engineering culture:** [from Glassdoor, blog posts, talks]
- **Remote policy:**

## Open Roles of Interest
| Role | Level | Link | Fit Assessment |
|------|-------|------|----------------|
| | | | |

## Key Contacts
| Name | Role | Connection | Notes |
|------|------|------------|-------|
| | | | |

## Recent News
-

## Why This Company
[What specifically attracts you -- and what concerns you]
```

---

## Outreach Contact

```markdown
# Outreach: [Name]

**ID:** OUT-NNN
**Company:** [current company]
**Relationship:** [former colleague / recruiter / referral / community]
**Contact:** [email / LinkedIn]

## Context
[How you know them, shared history]

## Conversation Log
| Date | Channel | Summary | Follow-up |
|------|---------|---------|-----------|
| | | | |

## Referral Status
- Referral requested: [yes/no]
- Referral given: [yes/no]
- Application linked: [APP-NNN if applicable]
```

---

## Application notes.md

```markdown
# [Company] -- [Role]

**Status:** [current stage]
**Applied:** YYYY-MM-DD
**Source:** [LinkedIn / recruiter / referral / direct]
**Recruiter/Contact:** [name + contact]
**Salary Range:** [from JD or researched]
**Target Salary:** [your ask]
**Priority:** High / Medium / Low

---

## Fit Analysis
- Required quals match: X/Y
- Key strengths for this role:
  -
- Gaps to address:
  -

---

## Application Materials
- [ ] JD saved verbatim
- [ ] Resume tailored
- [ ] Cover letter / other assets (if required)
- [ ] Submitted: YYYY-MM-DD

---

## Interview Log

[Use INT-NNN files in interviews/ for detailed logs, summarize here]

---

## Decision Log
[Offer details, negotiation notes, acceptance or decline reasoning]

---

## Key Learnings
[What to do differently -- feeds back into vault and system improvement]
```

---

## Interview Record

```markdown
# [Stage] Interview -- [Company]

**ID:** INT-NNN
**Application:** APP-NNN
**Date:** YYYY-MM-DD
**Interviewer(s):** [names + titles]
**Format:** [phone / video / onsite / panel]
**Duration:** [minutes]

## Questions & Answers
- Q: [question]
  A: [what you actually said]

## Stories Used
| Story Tag | For Question | Landed Well? |
|-----------|-------------|-------------|
| | | |

## Their Probes / Concerns
-

## My Read
- Energy: [1-5]
- Advance likely: [yes / no / unsure]
- Red flags: [any]

## Next Step
[What they said + timeline]

## Follow-up
- Thank-you sent: [yes/no + date]
- Notes for next round:
```

---

## Onboarding.md

See `references/career-growth.md` for the full 30-60-90 template.

---

## Achievement Record

```markdown
# Achievement: [Title]

**Date:** YYYY-MM-DD
**Role:** ROLE-NNN -- [Title] @ [Company]
**Category:** [Technical | Leadership | Process | Business | Learning]

## Summary
[One sentence: what you did and why it mattered]

## Context (Situation)
[What was the problem? Why did it matter? Who cared?]

## What I Did (Action)
-

## Results (Quantified)
- [Metric: before -> after (% change)]
-

## Evidence
- [ ] Link / screenshot / feedback quote

## Skills Demonstrated
-

## STAR-Ready?
- [ ] Can tell in 2 minutes with clear result
- [ ] Marked [INTERVIEW-READY] in accomplishments.md
```

---

## Self-Review

See `references/career-growth.md` for the full template.

---

## Growth.md

```markdown
# Growth Plan: [Role] @ [Company]

**Last Updated:** YYYY-MM-DD
**Current Level:** [title]
**Target Level:** [title]
**Target Timeline:** [when]

---

## Skill Gap Analysis

### Critical Gaps
| Skill | Current | Required | Closing Plan | Status |
|-------|---------|----------|-------------|--------|
| | | | | |

### Important Gaps
| Skill | Current | Required | Closing Plan | Status |
|-------|---------|----------|-------------|--------|
| | | | | |

### On Track
| Skill | Current | Required |
|-------|---------|----------|
| | | |

---

## Active Learning
| Skill | Activity | Hours/Week | Started | Target | Status |
|-------|----------|------------|---------|--------|--------|
| | | | | | |

---

## Promotion Readiness: __%
[Summary of what's blocking and what's on track]

---

## Quarterly Review Notes
### YYYY-QN
[What changed? What's next?]
```

---

## education-log.md

```markdown
# Education & Training Log

**Last Updated:** YYYY-MM-DD

> Every investment in learning — formal or informal — belongs here.
> If you'd mention it in an interview or put it on a resume, track it.

---

## Academic Degrees

| Degree | Field | Institution | Year | GPA / Honors | Notes |
|--------|-------|-------------|------|-------------|-------|
| | | | | | |

---

## Professional Certifications

| Certification | Issuer | Earned | Expiry | Cost | Gap Closed | Evidence Link |
|---------------|--------|--------|--------|------|-----------|---------------|
| | | | | | | |

---

## Online Courses & Specializations

| Course / Specialization | Platform | Completed | Hours | Certificate? | Gap Closed | Key Takeaway |
|------------------------|----------|-----------|-------|-------------|-----------|--------------|
| | Coursera / Udemy / edX / LinkedIn Learning / Other | | | Yes/No | | |

---

## Bootcamps & Intensives

| Program | Provider | Dates | Duration | Format | Cost | Gap Closed | Outcome |
|---------|----------|-------|----------|--------|------|-----------|---------|
| | | | | In-person / Remote / Hybrid | | | What you built or learned |

---

## Coaching & Mentorship

| Coach / Mentor | Focus Area | Period | Frequency | Key Insight | Still Active? |
|----------------|-----------|--------|-----------|-------------|--------------|
| | Career / Technical / Leadership / Executive | | | | |

---

## Workshops, Conferences & Events

| Event | Type | Date | Duration | Key Takeaway | Networking Value |
|-------|------|------|----------|-------------|-----------------|
| | Workshop / Conference / Hackathon / Meetup | | | | |

---

## Volunteer & Extracurricular Leadership

> Leadership outside of 9-to-5 is often the strongest signal for management,
> cross-functional, and community-facing roles. If you led without a title, track it here.

| Activity | Organization | Role | Period | Hours/Month | Impact | Leadership Skills Demonstrated |
|----------|-------------|------|--------|-------------|--------|-------------------------------|
| | | Organizer / Board member / Mentor / Lead / Contributor | | | Quantify where possible | e.g., team coordination, fundraising, public speaking |

### Examples worth tracking:
- **Community organizing:** Meetup organizer, hackathon lead, conference volunteer coordinator
- **Nonprofit / board work:** Board member, committee chair, treasurer, advisory role
- **Mentoring:** Youth coding mentor, bootcamp TA, university guest lecturer, peer mentor
- **Open source leadership:** Project maintainer, community moderator, documentation lead
- **Professional associations:** Chapter president, event chair, standards committee member
- **Civic / faith / cultural:** PTA officer, community group leader, fundraising chair

---

## Self-Directed Learning (selective — only notable items)

| Topic | Resource | Completed | Format | Why It Mattered |
|-------|----------|-----------|--------|----------------|
| | Book / Open Courseware / Study Group / Tutorial Series | | | |

---

## Summary Stats

- **Total formal education:** __ years
- **Certifications active:** __
- **Courses completed (last 12 months):** __
- **Total invested (estimated):** $__
- **Gaps closed by education:** [list gap IDs from gap analysis]
```

---

## Narrative Hat

```markdown
# Narrative Hat: [Hat Name]

**ID:** NAR-NNN
**Created:** YYYY-MM-DD
**Status:** Active / Retired
**Target Roles:** [specific job titles this hat targets]

---

## Positioning Pitch (30 seconds)

[Write it out verbatim. Practice until it's natural.]

---

## Top 5 Accomplishments (for this hat)

| # | Achievement | From | Reframed Angle |
|---|------------|------|----------------|
| 1 | | accomplishments.md reference | How it supports THIS narrative |
| 2 | | | |
| 3 | | | |
| 4 | | | |
| 5 | | | |

---

## Portfolio Curation

### GitHub Pins (for this hat)
| Position | Repo | Why This Hat |
|----------|------|-------------|
| 1 | | |
| 2 | | |
| 3 | | |
| 4 | | |
| 5 | | |
| 6 | | |

### Profile README Adjustments
[What headline, about, and featured projects to use when wearing this hat]

---

## LinkedIn Variant

**Headline:** [220 chars, optimized for this hat's target keywords]
**About Hook:** [First 2 lines of About section for this hat]
**Featured Items:** [3-5 items to pin when wearing this hat]

---

## Gap Narrative

| Gap | Type | How This Hat Frames It |
|-----|------|----------------------|
| | HARD/SOFT/NARRATIVE | |

---

## Signal Checklist

- [ ] Positioning pitch tested (say it out loud, time it)
- [ ] Top 5 accomplishments are all quantified
- [ ] GitHub pins tell this hat's story without conflicting signals
- [ ] LinkedIn headline uses target role keywords
- [ ] No accomplishment contradicts this hat's narrative
- [ ] At least one deployed project supports this hat

---

## Applications Using This Hat

| APP ID | Company | Role | Status |
|--------|---------|------|--------|
| | | | |
```
