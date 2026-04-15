---
name: product
description: Write PRDs using Kevin Yien's Square template, prioritize roadmaps with RICE scoring, and define user stories with INVEST criteria—non-goals get equal attention because scope creep kills projects. Use when defining features, writing specs, prioritizing backlogs, or when "what to build next" needs structure.
---

# Product Management

## Core Principle

A PRD that doesn't say "no" to anything says "yes" to everything. Scope discipline is the product manager's highest-leverage skill.

## PRD Writing (Kevin Yien / Square Template)

### PRD Structure

```
1. PROBLEM STATEMENT
   What user pain are we addressing? Evidence?

2. GOALS
   What does success look like? Measurable outcomes.

3. NON-GOALS (Critical)
   What are we explicitly NOT doing? Why?

4. USER STORIES
   As a [persona], I want [action], so that [outcome].

5. DESIGN & UX
   Wireframes, flows, key interactions.

6. TECHNICAL APPROACH
   High-level architecture, dependencies, risks.

7. METRICS
   How we measure if this worked.

8. TIMELINE
   Milestones with dates.

9. OPEN QUESTIONS
   What we still need to figure out.
```

### Non-Goals Section — Why It Matters

```
Non-goals aren't "things we'll do later."
They're "things we're choosing NOT to do, and here's why."

Example:
  Goal: "Users can filter search results by category"
  Non-goal: "Advanced boolean search queries"
  Why: "80% of users use single-category filters. Boolean
  search serves <5% of power users and triples complexity."
```

## RICE Prioritization Framework

### Score Each Feature

| Factor | Definition | Scale |
|--------|-----------|-------|
| **R**each | How many users affected per quarter? | Actual number |
| **I**mpact | How much does it move the needle per user? | 3=massive, 2=high, 1=medium, 0.5=low, 0.25=minimal |
| **C**onfidence | How sure are we about R, I, and E? | 100%=high, 80%=medium, 50%=low |
| **E**ffort | Person-months to ship | Actual estimate |

### RICE Score

```
RICE = (Reach × Impact × Confidence) / Effort

Example A: Onboarding redesign
  Reach: 5,000 users/quarter
  Impact: 2 (high)
  Confidence: 80%
  Effort: 2 person-months
  RICE = (5000 × 2 × 0.8) / 2 = 4,000

Example B: Dark mode
  Reach: 1,000 users/quarter
  Impact: 0.5 (low)
  Confidence: 100%
  Effort: 1 person-month
  RICE = (1000 × 0.5 × 1.0) / 1 = 500

→ Onboarding redesign wins by 8x.
```

## User Stories with INVEST Criteria

### INVEST Checklist

| Criteria | Question | Pass/Fail |
|----------|----------|-----------|
| **I**ndependent | Can it be built without other stories? | |
| **N**egotiable | Is there room to adjust scope? | |
| **V**aluable | Does the user get clear value? | |
| **E**stimable | Can the team estimate effort? | |
| **S**mall | Can it ship in one sprint? | |
| **T**estable | Can we write acceptance criteria? | |

### Story Template

```
As a [specific persona],
I want to [concrete action],
so that [measurable outcome].

Acceptance criteria:
- Given [context], when [action], then [result]
- Given [edge case], when [action], then [handled gracefully]
```

### Story Splitting Patterns

```
Too big: "As a user, I want to manage my account"

Split by operation:
  → "As a user, I want to update my email"
  → "As a user, I want to change my password"
  → "As a user, I want to delete my account"

Split by persona:
  → "As a free user, I want to see my usage limits"
  → "As a paid user, I want to manage my subscription"
```

## Anti-Patterns

| Product Theater | Real Product Work |
|-----------------|-------------------|
| PRD with no non-goals section | Non-goals are as explicit as goals |
| Prioritizing by HiPPO (highest paid person's opinion) | RICE score with documented evidence |
| "MVP" that has 30 features | MVP that solves one problem completely |
| Stories without acceptance criteria | Every story has testable conditions |
| Roadmap set in stone for 12 months | Quarterly commitments, annual themes |

## Power Move

"Write a PRD for [feature] using the Square template. Include 3 explicit non-goals with reasoning. Then RICE-score it against [alternative feature] and tell me which one to build first."

The agent becomes your product thinking partner — bringing rigor to what gets built and what gets cut.

## Related Skills

| Skill | When to use it |
|-------|---------------|
| `idea-validation` | Before building — validate the problem exists and is worth solving |
| `pm-design-thinking` | During feature definition — frame features through user outcomes |
