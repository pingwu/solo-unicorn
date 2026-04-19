# Narrative Hats: Role-Specific Positioning

The bridge between identity and job search. Before applying anywhere, define the **role-specific stories** you'll tell. Recruiters and hiring managers need a clear, coherent signal aligned to their organizational goals — conflicting stories kill candidacy.

## Table of Contents

1. [The Narrative Hat Concept](#the-narrative-hat-concept)
2. [Hat Rules](#hat-rules)
3. [Building a Narrative Hat](#building-a-narrative-hat)
4. [Who Needs Multiple Hats](#who-needs-multiple-hats)
5. [Anti-Patterns](#anti-patterns)

---

## The Narrative Hat Concept

You are one person with many facets. But each application needs **one clear story**. A "narrative hat" is a role-specific lens on your identity, accomplishments, and portfolio.

```
ONE IDENTITY (my-identity.md)
    │
    ├── Hat: "AI Infrastructure Engineer"
    │     ├── Positioning pitch (30 sec)
    │     ├── Top 5 accomplishments (filtered + reframed)
    │     ├── GitHub pins (curated for this role)
    │     ├── LinkedIn headline variant
    │     └── Gap narrative (what you're building toward)
    │
    ├── Hat: "Developer Tools Lead"
    │     ├── Positioning pitch (30 sec)
    │     ├── Top 5 accomplishments (different selection + framing)
    │     ├── GitHub pins (different curation)
    │     ├── LinkedIn headline variant
    │     └── Gap narrative
    │
    └── Hat: "Technical Educator / DevRel"
          ├── ...
          └── ...
```

### Why Separate Hats Matter

| Problem | What Happens | Fix |
|---------|-------------|-----|
| Mixed signals on GitHub | Hiring manager sees AI repos + teaching repos + ops repos — "unfocused" | Each hat defines which repos to pin |
| Generic LinkedIn headline | Invisible to every recruiter because it targets no one | Each hat has a headline variant |
| One-size resume | ATS filters it; interviewer sees misfit | Resume factory already handles this — hats feed it |
| Conflicting stories in interviews | "So are you an engineer or a manager?" | Each hat has a clear positioning pitch |

---

## Hat Rules

1. **Max 3 active hats.** More than 3 means you haven't decided — narrow down.
2. **Every hat draws from the same accomplishments vault.** You're not lying — you're curating.
3. **Each hat must pass the "no surprise" test.** If someone sees your GitHub, LinkedIn, AND resume for a given hat, does it tell one consistent story?
4. **Hats are not permanent.** Retire hats as you narrow your search. Archive to `6-archive/`.
5. **One hat = one active search track.** When you apply to a role, tag it with the hat you're wearing.

---

## Building a Narrative Hat

For each hat, define:

1. **Positioning Pitch (30 seconds):** "I'm a [role-level descriptor] who [what you do] to [outcome]. Most recently I [strongest relevant accomplishment]. I'm looking for [what you want] because [genuine motivation]."

2. **Top 5 Accomplishments (from vault):** Select and reframe the 5 that best support THIS narrative. Same achievement, different emphasis.

3. **Portfolio Curation:** Which 6 repos to pin for this hat. Which README angles to emphasize.

4. **LinkedIn Variant:** Headline, About section hook, and Featured items optimized for this hat's target audience.

5. **Gap Narrative:** For each HARD or SOFT gap, how does this hat frame it? "I haven't done X at scale yet, but I've done Y which requires the same fundamentals, and I'm actively building Z to close the gap."

6. **Signal Checklist:**
```
[ ] Positioning pitch passes the "would I hire this person?" test
[ ] Top 5 accomplishments are all quantified and relevant
[ ] GitHub pins tell this hat's story (no conflicting signals)
[ ] LinkedIn headline uses this hat's target keywords
[ ] Resume factory has hat-specific keyword priorities
[ ] No accomplishment contradicts the hat's narrative
```

### Narrative Hat File Template

Store in `2-target/narratives/NAR-NNN-hat-name.md`:

```markdown
# Narrative Hat: [Hat Name]

**ID:** NAR-NNN
**Created:** YYYY-MM-DD
**Status:** Active / Retired
**Target Roles:** [specific job titles this hat targets]

---

## Positioning Pitch (30 seconds)
[Write it out verbatim. Practice until it's natural.]

## Top 5 Accomplishments (for this hat)
| # | Achievement | From | Reframed Angle |
|---|------------|------|----------------|
| 1 | | accomplishments.md reference | How it supports THIS narrative |
| 2 | | | |
| 3 | | | |
| 4 | | | |
| 5 | | | |

## Portfolio Curation
### GitHub Pins (for this hat)
| Position | Repo | Why This Hat |
|----------|------|-------------|
| 1-6 | | |

### Profile README Adjustments
[What headline, about, and featured projects to use when wearing this hat]

## LinkedIn Variant
**Headline:** [220 chars, optimized for this hat's target keywords]
**About Hook:** [First 2 lines of About section for this hat]
**Featured Items:** [3-5 items to pin when wearing this hat]

## Gap Narrative
| Gap | Type | How This Hat Frames It |
|-----|------|----------------------|
| | HARD/SOFT/NARRATIVE | |

## Signal Checklist
- [ ] Positioning pitch tested (say it out loud, time it)
- [ ] Top 5 accomplishments are all quantified
- [ ] GitHub pins tell this hat's story without conflicting signals
- [ ] LinkedIn headline uses target role keywords
- [ ] No accomplishment contradicts this hat's narrative
- [ ] At least one deployed project supports this hat

## Applications Using This Hat
| APP ID | Company | Role | Status |
|--------|---------|------|--------|
| | | | |
```

---

## Who Needs Multiple Hats

| Situation | Example Hats |
|-----------|-------------|
| **Exploring roles** (student, career changer) | "Frontend Engineer" / "UX Engineer" / "Design Technologist" |
| **Pivoting domains** (AI + traditional) | "ML Engineer" / "Backend Engineer (AI-integrated)" |
| **Dual-track ambitions** (IC + management) | "Staff Engineer" / "Engineering Manager" |
| **Diverse skills** (technical + creative) | "Full-Stack Developer" / "Developer Educator" |

### Who Needs One Hat

If you know exactly what you want, one hat is better. Skip `narrative new` and just fill in the single narrative. The system still works — it just has one hat that's always active.

---

## Anti-Patterns

| Anti-Pattern | Why | Do This Instead |
|---|---|---|
| 5+ active hats | You haven't decided — spray-and-pray doesn't work | Narrow to 3 max, retire the rest |
| Hats that contradict each other | "I want to lead people" + "I want deep IC focus" confuses YOU | Pick a primary, keep the other as H2/H3 horizon |
| Same resume for different hats | The whole point is targeted curation | One resume per application, hat-informed |
| Changing hats mid-interview process | Company saw "AI Engineer" on LinkedIn, you interview as "PM" | Commit to a hat per company |
| Hat with no supporting evidence | Aspirational hat with zero accomplishments behind it | That's a gap to close first, not a hat to wear |
