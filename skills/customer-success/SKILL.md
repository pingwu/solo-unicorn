---
name: customer-success
description: Design onboarding flows, churn prevention systems, NPS/CSAT measurement, and health scoring—time-to-first-value as the core metric and churn analysis segmented by timing because interventions differ. Use when building onboarding, reducing churn, measuring satisfaction, or designing customer health systems.
---

# Customer Success

## Core Principle

The sale is the beginning, not the end. Time-to-first-value is the single most important metric because a customer who never experiences value is a churn statistic waiting to happen.

## Onboarding Flows

### Time-to-First-Value (TTFV)

```
TTFV = Time from signup to the moment the customer says "this is useful"

The shorter the TTFV, the higher the retention.

Benchmark targets:
  Self-serve SaaS: < 5 minutes
  SMB SaaS: < 1 day
  Mid-market: < 1 week
  Enterprise: < 30 days
```

### Onboarding Design Framework

```
Step 1: Define the "aha moment"
  What's the SINGLE action that makes users stick?
  Slack: Send first message in a team channel
  Dropbox: Save first file
  Zoom: Complete first call

Step 2: Remove everything between signup and aha
  Every screen, field, and choice between signup
  and aha moment is friction that kills activation.

Step 3: Measure completion rates at each step
  Signup → Step 1 → Step 2 → ... → Aha moment
  Find where the drop-off is. Fix that step.
```

### Onboarding Checklist Template

```
IMMEDIATE (first session):
  - [ ] Welcome message with clear next step
  - [ ] Guide user to one core action (not all features)
  - [ ] Show progress indicator
  - [ ] Success state when aha moment is reached

DAY 1-3 (follow-up):
  - [ ] Email: "Here's what you can do next"
  - [ ] In-app: Surface second-most-valuable feature
  - [ ] If inactive: Nudge with specific use case

DAY 7 (habit formation):
  - [ ] Email: Case study or tip from similar users
  - [ ] In-app: Introduce team/collaboration features
  - [ ] Check: Has user returned 3+ times?

DAY 14-30 (value confirmation):
  - [ ] NPS or CSAT survey
  - [ ] Expansion prompt (upgrade, invite team)
  - [ ] CSM check-in for higher-tier accounts
```

## Churn Prevention

### Churn Segmented by Timing

```
The critical insight: Churn at different stages has different causes
and requires different interventions.

EARLY CHURN (0-30 days)
  Cause: Failed onboarding, didn't reach aha moment
  Intervention: Improve onboarding, reduce TTFV
  Signal: User never completed core action

MID-TERM CHURN (1-6 months)
  Cause: Product doesn't deliver ongoing value, competitor switch
  Intervention: Feature adoption campaigns, QBRs, use-case expansion
  Signal: Declining login frequency, support tickets

LATE CHURN (6+ months)
  Cause: Budget cuts, org changes, contract renegotiation
  Intervention: Multi-stakeholder relationships, ROI reporting
  Signal: Champion departure, billing contact changes
```

### Churn Analysis Template

| Metric | Calculation | Target |
|--------|-------------|--------|
| Monthly churn rate | Lost customers / Start-of-month customers | < 5% (SMB), < 1% (enterprise) |
| Revenue churn | Lost MRR / Start-of-month MRR | < 2% monthly |
| Net revenue retention | (Start MRR + expansion - contraction - churn) / Start MRR | > 100% (ideally 120%+) |
| Logo churn | Lost logos / Start-of-month logos | Track alongside revenue churn |

## NPS / CSAT Measurement

### NPS (Net Promoter Score)

```
Question: "How likely are you to recommend [product] to a colleague?" (0-10)

Segments:
  Promoters (9-10): Loyal fans — ask for referrals and testimonials
  Passives (7-8): Satisfied but switchable — find what's missing
  Detractors (0-6): At risk — intervene immediately

NPS = % Promoters - % Detractors

Benchmarks:
  > 50: Excellent
  30-50: Good
  0-30: Needs improvement
  < 0: Problem
```

### CSAT (Customer Satisfaction Score)

```
Question: "How satisfied are you with [specific interaction]?" (1-5)

CSAT = (# of 4-5 responses / Total responses) × 100

Use CSAT for specific touchpoints:
  - Post-onboarding
  - After support ticket resolution
  - After feature release
  - Post-QBR

Use NPS for overall relationship health.
```

### Survey Timing

```
NPS: Quarterly (or after major milestones)
CSAT: After specific interactions (support, onboarding, call)
CES (Customer Effort Score): After task completion

Rule: Never survey more than once per month per customer.
```

## Customer Health Scoring

### Health Score Components

| Signal | Weight | Green | Yellow | Red |
|--------|--------|-------|--------|-----|
| Product usage (DAU/WAU) | 30% | Above average | Declining 2+ weeks | Inactive 30+ days |
| Feature adoption | 20% | Using 3+ core features | Using 1-2 features | Only login feature |
| Support sentiment | 15% | Positive CSAT | Neutral | Negative or escalations |
| NPS | 15% | Promoter (9-10) | Passive (7-8) | Detractor (0-6) |
| Engagement (meetings, training) | 10% | Regular QBRs | Occasional contact | No response to outreach |
| Contract signals | 10% | Expansion discussions | Flat renewal | Downgrade or at-risk |

### Health Score Actions

```
GREEN (80-100): Expansion opportunity
  → Ask for referrals, case studies, upsell

YELLOW (50-79): Intervention needed
  → Schedule check-in, identify blockers, re-onboard on unused features

RED (0-49): Churn risk
  → Executive outreach, save plan, offer concessions if warranted
```

## Anti-Patterns

| CS Theater | Real Customer Success |
|------------|----------------------|
| "We have a help center" | Proactive onboarding that guides to aha moment |
| Measuring NPS but never acting on it | Detractor follow-up within 48 hours |
| Treating all churn the same | Segmenting by timing and tailoring interventions |
| Health score based only on logins | Multi-signal health score with actionable thresholds |
| CS only talks to customers who call | Proactive outreach to yellow and red accounts |

## Power Move

"Design a customer health scoring model for [product]. Define the aha moment, build an onboarding flow that minimizes TTFV, create a churn analysis segmented by timing (early/mid/late), and write the intervention playbook for each health score tier."

The agent becomes your head of customer success — turning onboarding into retention and retention into expansion.
