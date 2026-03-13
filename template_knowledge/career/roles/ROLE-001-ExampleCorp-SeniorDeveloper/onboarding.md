# Onboarding: Senior Developer @ ExampleCorp

**Role ID:** ROLE-001
**Start Date:** 2026-03-01
**Manager:** Sarah Chen
**Buddy/Mentor:** Mike Rodriguez

---

## Role Context

### From Application
- **Application ID:** APP-001
- **Why I Took This Role:** Strong engineering culture, interesting technical challenges, good growth path to Staff
- **Expectations Discussed:** Ship features independently by 60 days, contribute to architecture by 90 days

### Team Structure
- Team name: Platform Team
- Team size: 8 engineers
- My role in team: Senior individual contributor
- Key collaborators: Product (Lisa), Design (Tom), QA (Jenny)

---

## 30-Day Goals (Learning)

**Theme:** Absorb, understand, build relationships

### Knowledge
- [x] Complete HR/compliance onboarding
- [x] Set up development environment
- [x] Understand codebase architecture
- [x] Read key documentation
- [x] Understand team's current priorities

### Relationships
- [x] 1:1 with manager — understand expectations
- [x] 1:1 with each team member
- [x] 1:1 with key stakeholders
- [x] Identify go-to people for questions

### Early Wins
- [x] Fix a small bug or make small improvement
- [x] Contribute to code review
- [x] Ask good questions in meetings

### 30-Day Check-in
**Date:** 2026-04-01
**How It Went:**
Smooth start. Got environment running Day 2. Shipped first bug fix Day 5. Team is welcoming and code is cleaner than expected.

**Manager Feedback:**
"Ramping up faster than expected. Keep asking questions — they're good ones."

**Adjustments for Day 31-60:**
Focus on one major system (auth) rather than trying to learn everything at once.

---

## 60-Day Goals (Contributing)

**Theme:** Add value, ship code, deepen understanding

### Delivery
- [x] Ship first meaningful PR to production
- [x] Own a small feature end-to-end
- [ ] Participate in on-call rotation (if applicable) — Starting week 8
- [x] Complete a sprint's worth of tickets independently

### Knowledge
- [x] Understand 2-3 major systems deeply
- [x] Document something that wasn't documented
- [x] Understand team's pain points

### Relationships
- [x] Build rapport with cross-functional partners
- [x] Identify potential mentor for growth areas
- [x] Start participating actively in team discussions

### 60-Day Check-in
**Date:** 2026-05-01
**How It Went:**
Shipped the user preferences feature end-to-end. Wrote first architecture doc for the team. Feel confident taking on bigger scope.

**Manager Feedback:**
"Strong delivery. Like how you documented the preferences system. Ready for more ownership."

**Adjustments for Day 61-90:**
Take on the API performance project — aligns with Staff-level scope.

---

## 90-Day Goals (Impact)

**Theme:** Drive results, show initiative, establish presence

### Delivery
- [x] Lead a small project or initiative
- [x] Make a process or system improvement
- [x] Deliver something that gets visibility

### Leadership
- [x] Present to team on something learned
- [ ] Help onboard another new person (if applicable) — No new hires yet
- [x] Propose an improvement idea

### Strategic
- [x] Understand team's roadmap and priorities
- [x] Identify where you can have most impact
- [x] Have career growth conversation with manager

### 90-Day Check-in
**Date:** 2026-06-01
**How It Went:**
Led API caching project — reduced p95 latency by 40%. Presented at team architecture review. Have clear path to Staff engineer now.

**Manager Feedback:**
"Exceeded expectations. The caching work shows Staff-level thinking. Let's talk about timeline to promotion."

**Transition to Steady State:**
- Regular sprint work + one strategic project per quarter
- Monthly 1:1s focused on career growth
- Quarterly check-ins on Staff progression

---

## Key Learnings

### About the Codebase
- Auth system is the most complex — needs refactoring
- Good test coverage, but integration tests are slow
- Microservices are well-separated but monitoring could be better

### About the Team/Culture
- Strong code review culture — reviews are thorough and constructive
- Team is data-driven — always ask "what metric does this move?"
- Decisions documented in RFCs — respect the process

### About the Domain
- Enterprise customers have very specific compliance needs
- Scale matters — design for 10x from day one
- API contracts are sacred — backward compatibility required

---

## Questions Log

| Date | Question | Answer | Source |
|------|----------|--------|--------|
| 2026-03-05 | How do we handle rate limiting? | Redis-based, per-customer limits in config | Mike |
| 2026-03-12 | Why two auth systems? | Legacy migration in progress, target Q3 completion | Architecture doc |
| 2026-03-20 | What's the deployment process? | CI/CD through GitHub Actions, prod needs 2 approvers | Sarah |

---

## Blockers & Challenges

| Challenge | Status | Resolution |
|-----------|--------|------------|
| VPN issues first week | Resolved | IT reconfigured account |
| Unclear ownership of pricing service | Resolved | Sarah clarified — it's Platform's |
| Slow test suite | In progress | Proposed parallelization in Q2 planning |

---

## Tools & Access

| Tool/System | Access Status | Notes |
|-------------|---------------|-------|
| GitHub | ✅ | |
| AWS | ✅ | Read-only until week 4, now full |
| Jira | ✅ | |
| DataDog | ✅ | |
| PagerDuty | ✅ | On-call starting week 8 |

---

## Reading List

- [x] Architecture overview doc
- [x] RFC-042: Auth migration plan
- [x] Incident postmortem: Feb 2026 outage
- [ ] Staff engineer career ladder (reviewing for promotion prep)
