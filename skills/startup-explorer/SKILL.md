---
name: startup-explorer
description: >
  Pre-validation startup idea explorer — bridges career expertise to a testable startup hypothesis.
  Triggers when a user wants to explore startup ideas, find a customer niche, discover what to build,
  identify product-market fit opportunities, or turn domain expertise into a business concept.
  Also triggers on: "startup idea", "what should I build", "find my niche", "explore business ideas",
  "side project to startup", "monetize my expertise", "customer discovery", "who would pay for this",
  "problem worth solving". Reads from career-advisor data. Feeds into idea-validation and business-model skills.
---

# Startup Explorer

Go from "I'm good at X" to "here's a testable startup hypothesis with a specific customer" — before writing a line of code or a pitch deck.

## Core Principle

**"The best startup ideas come from expertise you already have, aimed at pain you've already witnessed."**

Most first-time founders fail because they start with a solution ("I'll build an app for X") instead of a problem they deeply understand. This skill mines YOUR career for problems worth solving and customers you already know how to reach.

---

## Prerequisites: Career Data

Read from the career-advisor folder. Detect career root:

```
Check in order:
1. my_knowledge/career/   (preferred)
2. knowledge/career/      (alternative)
```

If not found: "Run `/career-advisor init` and `/career-advisor backfill` first. Startup ideas built on documented expertise are 10x stronger than ideas from a blank page."

**Key files to scan:**
- `{CAREER_ROOT}/1-identity/accomplishments.md` — problems you've solved, at what scale
- `{CAREER_ROOT}/1-identity/skills-inventory.md` — your unfair advantages
- `{CAREER_ROOT}/1-identity/my-identity.md` — values, ikigai, what energizes you
- `{CAREER_ROOT}/2-target/dream-job.md` — conditions you want (informs founder fit)

---

## The Exploration Workflow

```
MINE EXPERTISE → SPOT PROBLEMS → PICK A NICHE → FRAME HYPOTHESIS → HAND OFF TO VALIDATION
```

### Step 1: Expertise Mining

Scan the user's career data and extract:

| What to Find | Where to Look | Why It Matters |
|---|---|---|
| **Repeated problems** | accomplishments.md — what broke, what you fixed | Problems you've solved 3+ times are startup candidates |
| **Expensive problems** | Achievement results — $, time, risk quantified | Expensive problems = willingness to pay |
| **Domain depth** | skills-inventory.md — hard skills, years, proficiency | Your unfair advantage over generic founders |
| **Network access** | Past roles, industries, company sizes | Who you can reach for customer discovery |
| **Energy patterns** | my-identity.md — ikigai, values, archetypes | Founders quit when the problem bores them |

Output: A ranked list of **Problem-Expertise Pairs** — problems you understand deeply AND have the skills to solve.

### Step 2: Problem Expansion

For each top Problem-Expertise Pair, expand into adjacent pain:

**The "Who Else" Question Chain:**
1. "You solved this at [Company]. Who else has this problem?"
2. "What size company hits this problem? At what stage?"
3. "What do they do today? (DIY, hire someone, use a tool, ignore it)"
4. "What does ignoring it cost them per month/quarter/year?"
5. "How would you find 10 of these people this week?"

**The "Why Now" Filter:**
- What changed in the market that makes this problem solvable now?
- New technology? Regulation? Behavior shift? Platform change?
- If you can't answer "why now" — the idea may be valid but poorly timed.

### Step 3: Niche Selection

Narrow from "this is a problem" to "this is MY customer":

**The Niche Scorecard:**

| Criterion | Score (1-5) | Notes |
|---|---|---|
| **Problem severity** | | How painful is this? Hair-on-fire (5) vs. mild annoyance (1) |
| **Willingness to pay** | | Do they already spend money on this? Budget exists? |
| **Your access** | | Can you reach 10 prospects this week without cold outreach? |
| **Your expertise** | | Could you solve this faster/better than 95% of people? |
| **Market size** | | Enough customers to build a real business? (>$1M TAM for solo) |
| **Founder fit** | | Does this align with your ikigai? Would you work on it for 3 years? |

**Scoring rules:**
- Any criterion < 2 = disqualify
- Total < 18 = weak niche, explore more
- Total 18-24 = promising, worth validating
- Total 25+ = strong candidate, move to hypothesis

**The Beachhead:**
Pick the narrowest possible first customer: "[Job title] at [company stage/size] in [industry] who [specific situation]."

Example: "DevOps leads at Series A startups with 5-20 engineers who just got their first $10K cloud bill."

### Step 4: Hypothesis Framing

Convert the niche into a testable hypothesis using this template:

```markdown
# Startup Hypothesis: [Working Name]

## The Problem
[Specific audience] struggles with [specific problem] because [root cause].
Today they [current solution], which costs them [quantified pain].

## The Insight
Because of my experience [doing X at Y], I know that [non-obvious insight
about the problem that outsiders miss].

## The Solution (Directional — NOT a spec)
A [product type] that [key capability], enabling [audience] to [outcome].

## Why Me
- [Relevant accomplishment from vault]
- [Unique skill or access]
- [Network advantage]

## Why Now
[Market change that creates the opening]

## Beachhead Customer
[Job title] at [company type] who [trigger event].
I can reach 10 of them by [specific channel].

## Key Assumptions to Test
1. [ ] [Assumption about the problem] — Test by: [method]
2. [ ] [Assumption about willingness to pay] — Test by: [method]
3. [ ] [Assumption about the solution] — Test by: [method]

## Next Step
→ Run `/idea-validation` with this hypothesis
```

Save to `{CAREER_ROOT}/3-research/startup-ideas/` or a user-specified location.

### Save-to-Disk Rules

**Nothing stays in conversation only.** Every exploration session must produce saved files:

| Output | Location | Format |
|--------|----------|--------|
| Problem-Expertise Pairs | `{CAREER_ROOT}/3-research/startup-ideas/explorations.md` | Ranked list with scores and notes |
| Niche Scorecard | Append to `explorations.md` | Scorecard table per niche evaluated |
| Hypothesis | `{CAREER_ROOT}/3-research/startup-ideas/HYPO-NNN-name.md` | One file per hypothesis using template above |
| Pivot notes | Append to existing `HYPO-NNN` file | New section with what changed and why |

Create `3-research/startup-ideas/` on first use if it doesn't exist.

After saving, prompt: "Review what I wrote — I may have made the opportunity sound bigger than the evidence supports. Check that every claim maps to a real accomplishment or a real conversation."

---

## Exploration Modes

| Command | What It Does |
|---------|-------------|
| `/startup-explorer mine` | Scan career data, produce ranked Problem-Expertise Pairs |
| `/startup-explorer expand [problem]` | Run "Who Else" questions + "Why Now" filter on a specific problem |
| `/startup-explorer niche [problem]` | Score a problem with the Niche Scorecard, define beachhead |
| `/startup-explorer hypothesis [niche]` | Frame the testable hypothesis document |
| `/startup-explorer full` | Run all 4 steps end-to-end |
| `/startup-explorer compare` | Side-by-side scorecard of multiple niche candidates |
| `/startup-explorer pivot [hypothesis]` | Rework an existing hypothesis after validation feedback |

---

## Integration with Other Skills

| When | Skill | What Happens |
|------|-------|-------------|
| **Before** this skill | `career-advisor` | Backfill roles, document accomplishments, build skills inventory |
| **Parallel path** | `landing-page-service-discovery` | Consulting-first path — package expertise as a service instead of (or before) building a product |
| **After** hypothesis | `idea-validation` | Test assumptions with Mom Test interviews, GO/PIVOT/KILL |
| **After** validation | `business-model` | Select revenue model, pricing, unit economics |
| **After** business model | `fundraising` | Build pitch deck if raising capital |
| **After** business model | `go-to-market` | Launch strategy if bootstrapping |

```
career-advisor ──→ startup-explorer ──→ idea-validation ──→ business-model ──→ fundraising
       │                                                                           │
       └──→ landing-page-service-discovery (consulting path)              go-to-market
```

---

## The Consulting-First Path

Many solo founders should start consulting before building a product. If the user's niche score is high on **access** and **expertise** but unclear on **market size**, recommend:

1. Run `/landing-page-service-discovery` to package expertise as a service
2. Serve 5-10 clients manually — this IS customer discovery
3. Notice the patterns: what every client asks for, what you automate, what scales
4. THEN frame the startup hypothesis from real client pain, not imagination

This is the "do things that don't scale" approach. The career-advisor vault captures the evidence.

---

## Anti-Patterns

| Anti-Pattern | Why | Do This Instead |
|---|---|---|
| Starting with the solution | "I want to build an AI tool for X" — you skipped the problem | Start with problems you've witnessed, not tools you want to build |
| Niche too broad | "Small businesses" = nobody | Narrow until you can name 10 specific people |
| No unfair advantage | "Anyone could build this" = commoditized on day one | Your startup should leverage YOUR specific expertise + network |
| Skipping "Why Now" | A good idea at the wrong time is a failed startup | If nothing changed recently, the timing may be wrong |
| Analysis paralysis | Exploring 20 ideas forever, validating none | Score 3-5 with the Niche Scorecard, pick the highest, go validate |
| Ignoring founder fit | High-scoring niche you don't care about = burnout in 6 months | Your ikigai matters — check it against my-identity.md |
| Building before talking | "Let me code the MVP first" — classic founder mistake | Talk to 10 potential customers before writing any code |

---

## Power Move

"Scan my career folder and find the 3 most promising startup ideas hiding in my experience. Score each with the Niche Scorecard, recommend the strongest one, define the beachhead customer, and write a testable hypothesis I can take into `/idea-validation` today."
