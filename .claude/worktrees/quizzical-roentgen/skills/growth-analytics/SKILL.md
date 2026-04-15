---
name: growth-analytics
description: Implement AARRR pirate metrics, select North Star metrics, and distinguish KPIs from OKRs—A/B testing with sample size calculations, retention cohort analysis with SQL templates, and the insight that a healthy retention curve flattens. Use when setting up analytics, designing experiments, or diagnosing growth bottlenecks.
---

# Growth & Analytics

## Core Principle

If you can't measure it, you can't improve it. But measuring everything improves nothing. Pick the metrics that drive decisions, ignore the rest.

## AARRR Pirate Metrics Framework

### The Funnel

```
ACQUISITION  → How do users find you?
ACTIVATION   → Do they have a great first experience?
RETENTION    → Do they come back?
REVENUE      → Do they pay you?
REFERRAL     → Do they tell others?
```

### Metrics by Stage

| Stage | Key Metrics | Healthy Benchmarks |
|-------|-------------|-------------------|
| Acquisition | Traffic, signups, CAC by channel | CAC < 1/3 of LTV |
| Activation | Onboarding completion, time-to-first-value | 40-60% complete onboarding |
| Retention | D1/D7/D30 retention, churn rate | D30 > 20% (consumer), > 80% (SaaS) |
| Revenue | MRR, ARPU, expansion revenue, LTV | LTV:CAC > 3:1 |
| Referral | NPS, viral coefficient, referral rate | NPS > 50, K-factor > 0.5 |

### Where to Focus First

```
Fix the funnel from the BOTTOM UP:
  1. Retention first — no point acquiring users who leave
  2. Activation second — make the first experience great
  3. Acquisition third — now pour users into a funnel that works
  4. Revenue fourth — monetize retained users
  5. Referral last — happy retained users refer naturally
```

## North Star Metric Selection

### What Makes a Good North Star

```
A North Star metric must:
  1. Reflect core product value (not vanity)
  2. Be a leading indicator of revenue
  3. Be actionable by the team
  4. Be understandable by everyone
```

### Examples by Company Type

| Business Type | North Star | Why |
|---------------|-----------|-----|
| SaaS (collaboration) | Weekly active teams | Teams = retention + expansion |
| Marketplace | Transactions completed | Both sides getting value |
| Content platform | Daily reading time | Engagement = ad revenue |
| E-commerce | Purchase frequency | Repeat buyers = LTV |
| Dev tools | Builds triggered/week | Core value delivered |

### KPI vs. OKR — The Distinction

```
KPIs = What you WATCH (ongoing health metrics)
  "MRR is $50K" — it tells you the state of things

OKRs = What you CHANGE (time-bound improvement targets)
  "Increase MRR from $50K to $80K by Q2" — it drives action

KPIs without OKRs = dashboard watching
OKRs without KPIs = flying blind
```

## A/B Testing

### Sample Size Calculation

```
Required sample per variant:
  n = (Z² × p × (1-p)) / E²

Where:
  Z = 1.96 (95% confidence)
  p = baseline conversion rate
  E = minimum detectable effect

Example:
  Baseline conversion: 5% (p = 0.05)
  Want to detect 20% relative lift (5% → 6%, so E = 0.01)
  n = (1.96² × 0.05 × 0.95) / 0.01² = 1,825 per variant
  Total needed: 3,650 visitors
```

### Testing Rules

```
1. One variable at a time — otherwise you can't attribute results
2. Run to full sample size — don't peek and stop early
3. Statistical significance ≠ practical significance — a 0.1% lift
   at p<0.05 isn't worth shipping
4. Test the big levers first — headlines, CTAs, pricing, not button colors
5. Document every test — hypothesis, result, learning
```

### Testing Prioritization

| Test Type | Expected Impact | Effort |
|-----------|----------------|--------|
| Pricing page changes | High | Low |
| Onboarding flow | High | Medium |
| Email subject lines | Medium | Low |
| CTA copy and placement | Medium | Low |
| Page layout changes | Medium | High |
| Button color changes | Low | Low |

## Retention & Cohort Analysis

### The Core Insight

```
A healthy retention curve FLATTENS.
An unhealthy retention curve approaches zero.

Healthy:  Week 1: 100% → Week 4: 45% → Week 8: 38% → Week 12: 35%
                                                        ↑ Flattening

Unhealthy: Week 1: 100% → Week 4: 30% → Week 8: 15% → Week 12: 5%
                                                        ↑ Still declining
```

### Cohort Analysis SQL Template

```sql
-- Weekly retention cohorts
WITH cohort AS (
  SELECT
    user_id,
    DATE_TRUNC('week', MIN(created_at)) AS cohort_week
  FROM events
  WHERE event_name = 'signup'
  GROUP BY user_id
),
activity AS (
  SELECT
    user_id,
    DATE_TRUNC('week', event_time) AS active_week
  FROM events
  WHERE event_name = 'core_action'
  GROUP BY user_id, DATE_TRUNC('week', event_time)
)
SELECT
  c.cohort_week,
  DATEDIFF('week', c.cohort_week, a.active_week) AS week_number,
  COUNT(DISTINCT a.user_id) AS active_users,
  COUNT(DISTINCT a.user_id)::FLOAT
    / COUNT(DISTINCT c.user_id) AS retention_rate
FROM cohort c
LEFT JOIN activity a ON c.user_id = a.user_id
  AND a.active_week >= c.cohort_week
GROUP BY c.cohort_week, week_number
ORDER BY c.cohort_week, week_number;
```

### Reading the Cohort Table

```
          Week 0  Week 1  Week 2  Week 4  Week 8
Jan cohort  100%    52%     41%     35%     33%   ← Healthy (flattening)
Feb cohort  100%    48%     30%     18%     10%   ← Problem (still declining)
Mar cohort  100%    55%     45%     40%     38%   ← Best (improved onboarding)

Compare cohorts to see if product changes improve retention.
```

## Anti-Patterns

| Analytics Theater | Real Analytics |
|-------------------|----------------|
| Tracking 50 metrics on a dashboard | 1 North Star + 4-5 supporting KPIs |
| "Our MAU is growing!" | "D30 retention for the Jan cohort is 35%" |
| Stopping A/B tests when results "look good" | Running to calculated sample size |
| Measuring pageviews and signups only | Measuring activation and retention |
| Annual review of metrics | Weekly metric review with action items |

## Power Move

"Set up a growth analytics framework for [product]. Define the North Star metric, map AARRR metrics with targets, and write a cohort analysis SQL query for our retention data. Then identify the biggest leak in the funnel and design an A/B test to fix it."

The agent becomes your growth analyst — turning data into decisions and experiments into compounding improvements.
