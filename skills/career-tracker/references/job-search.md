# Job Search: Applications, Resumes, Interviews

The tactical engine: from discovering opportunities to landing offers.

## Table of Contents

1. [Folder Structure](#folder-structure)
2. [Application Workflow](#application-workflow)
3. [Resume Factory](#resume-factory)
4. [Interview System](#interview-system)
5. [Mock Interview Protocol](#mock-interview-protocol)
6. [Pipeline Analytics](#pipeline-analytics)

---

## Folder Structure

```
my_knowledge/career/
├── INDEX.md                           # Central dashboard
├── Accomplishments-Tracker.md         # Master career history
├── research/
│   ├── companies/CO-NNN-Company.md    # Company due diligence
│   ├── market/                        # Salary & market research
│   └── outreach/OUT-NNN-Name.md       # Networking contacts
├── opportunities/                     # Pre-application JDs under evaluation
│   └── Company-Role.md
├── applications/
│   └── APP-NNN-Company-Role/
│       ├── JD-Company-Role.md         # Verbatim job description
│       ├── Resume-Company-Role.md     # Tailored resume
│       ├── notes.md                   # Application log + interview notes
│       ├── INT-NNN-Stage.md           # Individual interview records
│       └── assets/                    # Cover letters, video scripts, etc.
└── roles/                             # Post-hire (see career-growth.md)
```

### Naming Conventions

| Type | Convention | Example |
|------|-----------|---------|
| Company research | `CO-NNN-Company.md` | `CO-001-Acme.md` |
| Outreach contact | `OUT-NNN-Name.md` | `OUT-001-JohnDoe-Referral.md` |
| Opportunity (pre-app) | `Company-Role.md` | `Acme-SeniorDev.md` |
| Application folder | `APP-NNN-Company-Role/` | `APP-001-Acme-SeniorDev/` |
| Job description | `JD-Company-Role.md` | `JD-Acme-SeniorDev.md` |
| Resume | `Resume-Company-Role.md` | `Resume-Acme-SeniorDev.md` |
| Interview record | `INT-NNN-Stage.md` | `INT-001-PhoneScreen.md` |

---

## Application Workflow

### Step 1: Evaluate Opportunity

Before applying, run a fit analysis:
1. Save JD verbatim in `opportunities/Company-Role.md`
2. Compare JD requirements to Accomplishments-Tracker.md
3. Score fit: required quals match (X/Y), strengths, gaps
4. Decision: apply now, defer, or skip

### Step 2: Create Application

When deciding to apply:
1. Create folder: `applications/APP-NNN-Company-Role/`
2. Move JD into folder as `JD-Company-Role.md`
3. Create `notes.md` with fit analysis and materials checklist
4. Generate tailored resume (see Resume Factory)
5. Create any additional materials (cover letter, etc.)

### Step 3: Submit & Track

1. Submit application
2. Update `notes.md` with submission date
3. Update `INDEX.md` — add row, update pipeline counts
4. Set follow-up reminder (5-7 business days)

### Step 4: Progress Through Pipeline

Update status at each stage:

```
researching → resume-ready → applied → phone-screen → technical → behavioral → onsite → offer → accepted
                                                                                          ↓
                                                                                   rejected / withdrawn / ghosted
```

| Stage | Meaning |
|-------|---------|
| `researching` | Analyzing JD, deciding whether to apply |
| `resume-ready` | Resume tailored, not yet submitted |
| `applied` | Application submitted |
| `phone-screen` | Recruiter / HR screening call |
| `technical` | Technical interview (one or more rounds) |
| `behavioral` | Behavioral / leadership rounds |
| `onsite` | Final round (in-person or multi-hour virtual) |
| `offer` | Offer received, in negotiation |
| `accepted` | Offer accepted |
| `rejected` | They passed |
| `withdrawn` | You withdrew |
| `ghosted` | No response after follow-up |

---

## Resume Factory

**Process: JD → keyword extraction → vault mining → ATS-optimized resume**

### Extract ATS Keywords

Analyze the JD for:
- Required skills (exact tool and technology names)
- Preferred skills (include if truthfully held)
- Years of experience targets
- Action verbs the company uses (mirror them)
- Industry-specific terminology

### Mine the Vault

Match keywords against Accomplishments-Tracker.md. For each keyword:
- Find the strongest story or bullet
- Identify quantified results
- Note the business context

### Build the Resume

Rules:
- Length: 1 page = IC/specialist, 2 pages = senior/principal/executive
- Use keywords **exactly** as written in the JD
- Quantify everything: dollars, users, accounts, percentages, team sizes
- Professional summary: 3-4 sentences, front-load role-specific keywords
- Remove anything that doesn't serve this specific role

### ATS Check Before Submitting

```
[ ] Every required qualification addressed somewhere in resume
[ ] Job title keywords appear in summary
[ ] No tables, columns, or graphics (ATS parsers break on them)
[ ] File format matches their instructions (.docx or .pdf)
[ ] File named: [Name]_Resume_[Role]-[Company].pdf
[ ] Contact info complete: name, email, phone, LinkedIn, location
```

---

## Interview System

### Before Every Interview

Run a story inventory against the JD:

```
[ ] 30-second positioning pitch (role-specific, not generic)
[ ] One "impact at scale" story (quantified, matches JD scope)
[ ] One "technical depth" story (matches required skills)
[ ] One "conflict or pushback" story (behavioral standard)
[ ] One "failure or course correction" story (shows judgment)
[ ] One "why this company" answer (researched, not flattery)
[ ] Two genuine questions to ask them
```

If any slot is empty — that's your prep gap. Fill it before the interview.

### Round-Specific Focus

| Round | What's Really Tested | Prep Emphasis |
|-------|---------------------|---------------|
| Recruiter / phone screen | Fit, compensation alignment, basics | 30-sec pitch, comp range, logistics |
| Hiring manager | Judgment, communication, priorities | STAR stories, "why this role", career arc |
| Technical / domain | Depth, problem-solving, tool fluency | Live problem-solving, not just recall |
| Behavioral / leadership | Patterns under pressure | STAR with conflict, failure, ambiguity |
| Panel / final | Everything + culture fit | Consistency, genuine questions |

### After Every Interview (Within 2 Hours)

```
[ ] Write interview log in notes.md or INT-NNN file
[ ] Log every question asked + what you actually said (honest, not ideal)
[ ] Flag stories that landed well → mark [INTERVIEW-READY] in vault
[ ] Note their probes/concerns and your read on likelihood
[ ] Send thank-you within 24 hours
[ ] Update INDEX.md status and next action
```

### Interview Log Template (INT-NNN)

```markdown
# [Stage] Interview — [Company]

**Date:** YYYY-MM-DD
**Interviewer(s):** [names + titles]
**Format:** [phone / video / onsite / panel]
**Duration:** [minutes]

## Questions & Answers
- Q: [question]
  A: [what you actually said]

## Stories Used
- [Story tag from vault] → for [which question]

## Their Probes / Concerns
- [What they pushed back on or dug into]

## My Read
- Energy level: [1-5]
- Likely to advance: [yes / no / unsure]
- Red flags: [any]

## Next Step
- [What they said + timeline]

## Follow-up
- Thank-you sent: [yes/no + date]
```

---

## Mock Interview Protocol

Run before every interview round. The goal is to pressure-test stories and find gaps before the interviewer does.

### Setup

1. Pull the JD and fit analysis from notes.md
2. Specify the round type and interviewer role
3. Claude stays in interviewer mode until user says "debrief"
4. Answer naturally — no editing, no looking things up

### During the Mock

- Claude asks one question at a time
- No hints or meta-commentary
- Follow-up probes based on answers (like a real interviewer)
- Calibrate difficulty to the round type

### Debrief (After User Says "Debrief")

Claude provides structured feedback:
1. **What landed**: Stories that were compelling and well-structured
2. **What was thin**: Answers that lacked specifics, metrics, or clarity
3. **What was skipped**: Questions where you went off-topic or avoided the core
4. **The one thing to fix**: Single highest-impact improvement before the real interview
5. **Story upgrades**: How to strengthen specific stories

### Mock Prompts by Round Type

**Phone screen**: Focus on fit, compensation, basics, "tell me about yourself"
**Hiring manager**: Judgment calls, why this role, leadership scenarios
**Technical**: Domain-specific problems, system design, debugging
**Behavioral**: STAR format stories, conflict, failure, ambiguity
**Panel**: Mix of all types, test consistency

---

## Pipeline Analytics

### Conversion Metrics

Track these to improve over time:

```
Applications → Phone screens: ___%
Phone screens → Technical: ___%
Technical → Onsite: ___%
Onsite → Offers: ___%
Offers → Accepted: ___%
```

### Weekly Review Questions

1. How many active applications? Any stale (>2 weeks without movement)?
2. Any follow-ups overdue?
3. Any interviews this week to prep for?
4. Any new opportunities worth evaluating?
5. What did I learn from recent interviews?
