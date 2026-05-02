---
name: landing-page-service-discovery
description: >
  Synthesizes professional accomplishments into high-converting landing page content.
  Triggers when a user wants to build a landing page, launch a consulting service,
  productize their career expertise, create a service page, or monetize their skills.
  Also triggers on: "freelance", "consulting offer", "offer page", "service offering",
  "turn my experience into a business". Uses career-advisor data as the foundation.
---

# Landing Page Service Discovery

A bridge between career history and market-ready service offerings. This skill helps experts stop "selling their time" and start "selling outcomes."

## Core Principle

**"Features tell, Benefits sell, but Transformations land the client."**

- **Accomplishments** are what you *did*.
- **Services** are what you *do*.
- **Landing Pages** are what the client *gets*.

---

## Prerequisites: Career Data

This skill reads from the career-advisor folder. Before starting, detect the career root:

```
Check in order:
1. my_knowledge/career/   (preferred)
2. knowledge/career/      (alternative)
```

If neither exists, stop and say:

> "This skill builds on your career data. Run `/career-advisor init` first to set up your career folder, then `/career-advisor backfill` to document your past roles. The landing page is only as strong as the accomplishments behind it."

Required files:
- `{CAREER_ROOT}/1-identity/accomplishments.md` — source of Peak Win and case studies
- `{CAREER_ROOT}/1-identity/skills-inventory.md` — source of unique mechanism

Optional but valuable:
- `{CAREER_ROOT}/2-target/narratives/` — active narrative hats inform positioning
- `{CAREER_ROOT}/2-target/dream-job.md` — target audience clues

---

## The Service Discovery Workflow

### Step 1: Accomplishment Audit (Identity Scan)

Read `{CAREER_ROOT}/1-identity/accomplishments.md` and `skills-inventory.md`.

Identify the **"Peak Win"**:
- The accomplishment with the highest quantified ROI (time saved, revenue generated, risk mitigated)
- The skill you used that is most difficult for others to replicate
- If multiple candidates, pick the one where the user has the most passion and repeat evidence

### Step 2: The Transformation Framework

Convert the Peak Win into a service using the formula:

> "I help [Target Persona] achieve [Massive Result] via [Unique Mechanism] in [Timeline] without [Primary Pain Point]."

Example: "I help Series A CTOs cut cloud costs by 40% via infrastructure audits in 2 weeks without downtime or vendor lock-in."

### Step 3: Customer Clarification

Before generating the landing page, you MUST ask these 4 questions:

1. **The Buyer:** Who has the budget to fix this? (e.g., CTO, Founder, VP Engineering)
2. **The Stakes:** What is the cost of inaction? (What happens if they don't hire you?)
3. **The Objections:** Why would they say "no"? (Too expensive, too risky, not urgent, tried before)
4. **The CTA:** What is the smallest "Yes" they can give? (e.g., "Book a 15-min audit", "Get your free assessment")

### Step 4: Generate Landing Page

Produce the output in the user's chosen format (see [Output Formats](#output-formats)).

---

## Landing Page Structure

Use the PAS framework (Problem → Agitate → Solution) as the backbone:

| Section | Purpose | Source |
|---------|---------|--------|
| **Hero** | Outcome-first headline + specific sub-headline | Transformation Framework formula |
| **The Gap** | Paint the current pain (Problem) then show the future state (Solution) | Stakes from Step 3 |
| **Social Proof** | Reframe career accomplishments as case studies — quantified results, not job titles | accomplishments.md STAR stories |
| **The Stack** | Tools, methods, frameworks you use — the "how" that builds credibility | skills-inventory.md |
| **Pricing** | Tiered packages from low-commitment to full engagement | See [Pricing & Packaging](#pricing--packaging) |
| **Risk Reversal** | Guarantee or risk-free entry point that neutralizes objections | Objections from Step 3 |
| **CTA** | Single, clear next step — repeated at top and bottom | CTA from Step 3 |

---

## Pricing & Packaging

Most experts undercharge because they price by time instead of value. Use the 3-tier model:

| Tier | Name | What It Is | Pricing Logic |
|------|------|-----------|---------------|
| **Entry** | Audit / Assessment / Review | Low-commitment diagnostic — the CTA on your landing page | Price at 1-2% of the value you'll uncover. Free is OK for lead gen. |
| **Core** | Implementation / Build / Sprint | The main deliverable — where the transformation happens | Price at 10-20% of the quantified ROI from your Peak Win |
| **Premium** | Retainer / Advisory / Ongoing | Continuous access — insurance against regression | Monthly: 5-10% of Core price |

### Value-Based Pricing Formula

```
Your Price = (Client's Annual Cost of the Problem) × 0.10 to 0.20
```

If your Peak Win saved $500K/year → price your Core service at $50K-$100K.

**Rules:**
- Never show hourly rates on a landing page — it anchors to commodity pricing
- Always frame price relative to cost of inaction: "This costs $X. Not fixing it costs $Y/month."
- If the user hasn't quantified their Peak Win, go back to accomplishments.md and push for numbers

---

## Output Formats

Ask the user which format they want:

| Format | When to Use | What You Produce |
|--------|-------------|-----------------|
| **Markdown draft** (default) | Planning, review, iteration | Structured .md with all sections filled in using `assets/landing-page-template.md` |
| **HTML + Tailwind** | Ready to deploy | Single-file HTML with Tailwind CDN, responsive, dark/light |
| **Site builder prompt** | Using v0, Cursor, Bolt, etc. | Structured prompt with sections, copy, and layout instructions |

For HTML output, use a clean single-column layout: hero with CTA → gap/pain → social proof → pricing → final CTA. Mobile-first. No JavaScript required for the initial version.

---

## Anti-Patterns

| Anti-Pattern | Why It Fails | The Fix |
|---|---|---|
| "Freelance Developer" | Commodity positioning → price wars | "AI Infrastructure Architect" (niche expert) |
| Focusing on "Years of Experience" | Clients care about their future, not your past | Focus on the ROI you deliver next month |
| Vague CTA ("Contact Me") | High friction; requires buyer to do work | "Get your free Performance Audit" (value-first) |
| Hourly rates on the page | Anchors to commodity; invites comparison shopping | Value-based tiers with ROI framing |
| No case studies | Claims without proof → zero trust | Mine accomplishments.md for 2-3 quantified wins |
| Building the page before Customer Clarification | Generic copy that converts nobody | Always run Step 3 first — even if the user is impatient |

---

## Related Skills

| Skill | When to Use |
|-------|-------------|
| `career-advisor` | Build the accomplishments vault and skills inventory this skill reads from |
| `startup-explorer` | If consulting reveals a product opportunity, explore it as a startup hypothesis |
| `idea-validation` | After framing a hypothesis, test assumptions with Mom Test interviews |
| `business-model` | Select revenue model, pricing strategy, and unit economics |
| `go-to-market` | Launch strategy for the service or product |

---

## Power Move

"I'm ready to turn my career into a service. Run an 'Accomplishment Audit' on my career folder, identify my 'Peak Win', walk me through the 4 Customer Clarification questions, suggest a 3-tier pricing model, and generate a deployable HTML landing page with Tailwind."
