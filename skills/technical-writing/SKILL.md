---
name: technical-writing
description: Practical technical writing for developers — READMEs, tutorials, how-to guides, reference docs, ADRs, changelogs, commit messages, PR descriptions, and API documentation. Write for two audiences (humans and AI agents), avoid common anti-patterns, and ship docs that actually get read.
---

# Technical Writing

## Core Principle

Documentation is a product. If nobody reads it, it does not exist. Write less, write better, and keep it current.

## The Two-Audience Rule

Every piece of documentation you write today has two readers:

```
HUMAN READER
  → Scans headings, skips to examples, copies code blocks
  → Needs context: "why should I care?"
  → Trusts docs that look maintained

AI AGENT READER
  → Parses structure, front matter, and explicit instructions
  → Needs consistency: predictable patterns across files
  → Performs better with constraints than with vague guidance
```

Write for both. Structured docs with clear headings, front matter, and examples serve humans and AI agents equally well.

## README: Your Project's Front Door

### Structure That Works

```markdown
# Project Name

One sentence: what it does and who it's for.

## Quick Start

3-5 steps to go from zero to "it works."

## Installation

Prerequisites, install commands, verification step.

## Usage

The most common use case with a real code example.

## Configuration

Environment variables, config files, flags.

## Contributing

How to set up the dev environment. Link to CONTRIBUTING.md if it's long.

## License

One line. Link to LICENSE file.
```

### What to Include

| Section | Why It Matters |
|---------|----------------|
| One-line description | Tells people if they're in the right place |
| Quick Start | Converts visitors into users |
| Real code examples | People copy-paste first, read second |
| Prerequisites | Prevents "it doesn't work" issues |
| Badges (build, coverage) | Signals the project is alive |

### What to Skip

- Project history and origin story nobody asked for
- Exhaustive API reference in the README (link to it instead)
- Screenshots of every single screen (pick 1-2 that matter)
- Badges for tools nobody cares about

## Documentation Types

### Tutorials (Learning-Oriented)

```
Goal: Help a beginner accomplish something specific.
Structure: Step-by-step, numbered, one path, no detours.
Tone: "Follow along with me."

GOOD: "Build a REST API in 15 Minutes"
BAD: "Everything You Need to Know About REST APIs"

Rules:
  → Every step must produce a visible result
  → Test every step yourself before publishing
  → Assume nothing about prior knowledge
  → Provide the complete working code at the end
```

### How-To Guides (Problem-Oriented)

```
Goal: Help an experienced user solve a specific problem.
Structure: Steps with context, multiple options where relevant.
Tone: "Here's how to do the thing."

GOOD: "How to Add Authentication to Your Express App"
BAD: "Authentication Tutorial for Beginners"

Rules:
  → State the problem in the title
  → Assume the reader has working knowledge
  → Offer alternatives where they exist
  → Include troubleshooting at the end
```

### Reference Docs (Information-Oriented)

```
Goal: Describe the system accurately and completely.
Structure: Consistent format, alphabetical or logical grouping.
Tone: Neutral, precise, no opinions.

GOOD: A function signature with parameters, types, return value, and one example
BAD: A paragraph explaining when you might want to use the function

Rules:
  → One format, every entry, no exceptions
  → Generated from code when possible
  → Examples for every non-obvious function
  → Keep descriptions under two sentences
```

### Architecture Decision Records (ADRs)

```
Goal: Capture WHY a decision was made, not just what.
Structure: Status, context, decision, consequences.
Tone: Honest, direct, including trade-offs.

File naming: docs/adr/ADR-001-use-postgres-over-mongo.md
```

ADR Template:

```markdown
# ADR-001: Use PostgreSQL Over MongoDB

**Status:** Accepted
**Date:** 2026-02-10
**Deciders:** @alice, @bob

## Context

We need a primary datastore. Our data is relational (users, orders, items).
The team has more SQL experience than NoSQL experience.

## Decision

Use PostgreSQL as our primary database.

## Consequences

### Positive
- Strong data integrity with foreign keys and constraints
- Team can be productive immediately
- Mature ecosystem of tools and ORMs

### Negative
- Schema migrations add deployment complexity
- Horizontal scaling is harder than with MongoDB

### Neutral
- We can still use Redis for caching alongside Postgres
```

## YAML Front Matter Convention

Solo Unicorn Builder skills and many documentation systems use YAML front matter for metadata. Keep it minimal.

```yaml
---
name: kebab-case-name
description: One sentence. What it does and when to use it.
---
```

Why this matters:

```
For Humans:   Quick scan of what a file is about without reading the body.
For AI Agents: Structured metadata for indexing, routing, and context loading.
For Tooling:  Static site generators, search indexes, and linters can parse it.
```

Rules:
- `name` is always kebab-case
- `description` is one sentence, maximum two
- Do not stuff keywords into the description; write it for a human reader
- If you need more metadata (author, date, tags), add it — but start with just these two

## Changelogs and Release Notes

### Changelog Format (Keep a Changelog)

```markdown
# Changelog

## [1.2.0] - 2026-02-12

### Added
- User profile avatars with upload and crop
- Rate limiting on authentication endpoints

### Changed
- Dashboard loads 40% faster (Redis caching)

### Fixed
- Login redirect loop on expired sessions
- CSV export truncating Unicode characters

### Removed
- Deprecated v1 API endpoints (deprecated since 1.0.0)
```

### Rules for Good Changelogs

| Do | Don't |
|----|-------|
| Group by Added, Changed, Fixed, Removed | Dump a flat list of commits |
| Write for users, not developers | Use internal jargon or ticket numbers only |
| Include the version number and date | Skip dates — they matter for audits |
| Mention breaking changes prominently | Bury breaking changes in the middle |

### Release Notes vs. Changelog

```
Changelog: Comprehensive, every version, developer-facing.
Release Notes: Highlights only, user-facing, often with context.

Release notes answer: "Should I upgrade, and what do I get?"
Changelogs answer: "What exactly changed between version X and Y?"
```

## Commit Message Conventions

### The Conventional Commits Format

```
<type>(<scope>): <short summary>

<body — optional, explains WHY>

<footer — optional, references issues>
```

### Types That Matter

| Type | When to Use |
|------|-------------|
| `feat` | New feature for the user |
| `fix` | Bug fix for the user |
| `docs` | Documentation only |
| `refactor` | Code change that doesn't fix a bug or add a feature |
| `test` | Adding or updating tests |
| `chore` | Build process, dependencies, CI |

### Examples

```
GOOD:
  feat(auth): add OAuth2 login with Google
  fix(export): handle Unicode characters in CSV output
  docs(readme): add quick start section for new contributors
  refactor(api): extract validation logic into middleware

BAD:
  fixed stuff
  WIP
  update
  addressing PR feedback
  misc changes
```

### Commit Message Rules

```
1. Subject line: imperative mood, under 72 characters
   YES: "add user avatar upload"
   NO:  "added user avatar upload" / "adds user avatar upload"

2. Body: explain WHY, not WHAT (the diff shows WHAT)
   YES: "Sessions were expiring silently, causing redirect loops
        for users who stayed logged in longer than 24 hours."
   NO:  "Changed the session timeout value from 24 to 48."

3. Footer: reference issues, note breaking changes
   Closes #142
   BREAKING CHANGE: /api/v1/users endpoint removed
```

## PR Descriptions That Get Approved

### Structure

```markdown
## What

One sentence: what does this PR do?

## Why

The problem this solves or the goal it achieves. Link to the issue.

## How

Brief explanation of the approach. Call out non-obvious decisions.

## Testing

How you tested it. Include steps reviewers can follow.

## Screenshots (if UI change)

Before/after, or a short screen recording.

## Checklist

- [ ] Tests pass
- [ ] No new warnings
- [ ] Documentation updated (if applicable)
```

### What Gets PRs Approved Fast

```
1. Small PRs — under 400 lines changed. Split big work into stacked PRs.
2. One concern per PR — don't mix refactoring with new features.
3. Self-review first — leave comments on your own code explaining decisions.
4. Context in the description — reviewers should not have to ask "why?"
5. Screenshots for visual changes — a picture saves three rounds of review.
```

### What Gets PRs Stuck

```
- 1,200 lines with "please review" and no description
- Mixing formatting changes with logic changes
- No tests, no explanation of how you tested manually
- Force-pushing without telling reviewers
- Responding to feedback with "it works on my machine"
```

## API Documentation Basics

### Minimum Viable API Doc

For every endpoint, document:

```markdown
### POST /api/users

Create a new user account.

**Authentication:** Bearer token (admin role required)

**Request Body:**

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| email | string | yes | Valid email address |
| name | string | yes | Display name, 1-100 chars |
| role | string | no | Default: "member" |

**Example Request:**

    curl -X POST https://api.example.com/api/users \
      -H "Authorization: Bearer <token>" \
      -H "Content-Type: application/json" \
      -d '{"email": "ada@example.com", "name": "Ada Lovelace"}'

**Success Response (201):**

    {
      "id": "usr_abc123",
      "email": "ada@example.com",
      "name": "Ada Lovelace",
      "role": "member",
      "created_at": "2026-02-12T10:00:00Z"
    }

**Error Responses:**

| Status | Reason |
|--------|--------|
| 400 | Validation error (missing or invalid fields) |
| 401 | Missing or invalid authentication token |
| 403 | Insufficient permissions |
| 409 | Email already registered |
```

### API Doc Rules

```
1. Every endpoint needs a working example — curl, not pseudocode.
2. Show real response shapes, not "returns a user object."
3. Document error responses, not just happy paths.
4. Include authentication requirements on every endpoint.
5. Version your API docs alongside your API code.
```

## Doc Co-Authoring Workflow

When writing substantial documentation — proposals, technical specs, decision docs, RFCs, PRDs — use this three-stage workflow instead of trying to draft everything in one pass.

### Stage 1: Context Gathering

Close the gap between what you know and what the AI knows.

```
1. Define the document:
   - Type (tech spec, decision doc, proposal, RFC)
   - Primary audience
   - Desired impact when someone reads it
   - Template or format to follow

2. Dump all context — don't organize, just get it out:
   - Background on the project/problem
   - Why alternatives don't work
   - Organizational context (team dynamics, past incidents)
   - Timeline pressures and constraints
   - Technical architecture and dependencies
   - Stakeholder concerns

3. Answer clarifying questions:
   - AI generates 5-10 questions based on gaps
   - Answer in shorthand — efficiency over formality

EXIT CONDITION: Edge cases and trade-offs can be discussed
without needing basics explained.
```

### Stage 2: Refinement & Structure

Build section by section through brainstorming, curation, and iterative refinement.

```
For each section:
  1. Clarifying questions — what should this section cover?
  2. Brainstorm 5-20 points that might belong here
  3. Curate — keep, remove, or combine ("Keep 1,4,7" / "Remove 3")
  4. Draft the section from curated points
  5. Refine through surgical edits (not full rewrites)

Section ordering:
  → Start with the section that has the most unknowns
  → For decision docs: core proposal first
  → For specs: technical approach first
  → Summary sections last

Near completion (80%+ done):
  → Review full document for flow, consistency, redundancy
  → Ask: "Can anything be removed without losing information?"
```

### Stage 3: Reader Testing

Test the document with a fresh perspective to catch blind spots.

```
1. Predict 5-10 questions a reader would realistically ask
2. Test with a fresh AI instance (no prior context):
   - Paste only the document + one question at a time
   - Check: does the AI answer correctly from the doc alone?
3. Run additional checks:
   - Ambiguity: are any statements open to misinterpretation?
   - Assumptions: what knowledge does the doc assume?
   - Contradictions: do any sections conflict?
4. Fix gaps, then re-test affected sections

EXIT CONDITION: Fresh reader consistently answers questions
correctly and surfaces no new gaps.
```

### When to Use This Workflow

```
USE for:    PRDs, design docs, decision docs, RFCs, proposals,
            specs — anything where "the doc must work for readers"
SKIP for:   READMEs, changelogs, commit messages, quick how-to guides
            — use the specific templates in other sections instead
```

## Anti-Patterns

| Documentation Theater | Real Documentation |
|----------------------|-------------------|
| Wall of text with no headings | Scannable structure with clear hierarchy |
| "This is self-documenting code" | Code explains WHAT; docs explain WHY |
| Docs written once, never updated | Docs reviewed in every PR that changes behavior |
| No examples anywhere | Every concept has a copy-pasteable example |
| README that's 2,000 lines long | README links to dedicated docs for deep topics |
| Internal jargon with no glossary | Terms defined on first use or in a glossary |
| Outdated screenshots | Automated screenshots or text descriptions that age better |
| "See Confluence" (link is dead) | Docs live next to code, in the repo |
| Writing for yourself | Writing for someone seeing the project for the first time |

### The Freshness Test

```
Ask yourself:
  → If I deleted this doc, would anyone notice?
  → If a new contributor reads only this doc, can they get started?
  → When was the last time someone updated this? (check git blame)
  → Does this doc match what the code actually does right now?

If any answer is "no" or "I don't know," the doc needs work.
```

## Writing for Open Source

### What Maintainers Look For in Contributors

```
1. A clear CONTRIBUTING.md — lowers the barrier for first PRs
2. Issue templates — prevents "it's broken" with no details
3. Good first issues — labeled and scoped for newcomers
4. Up-to-date docs — signals the project is active
5. ADRs — shows decisions are thoughtful, not arbitrary
```

### What Job Seekers Should Document

```
Your open source contributions tell a story. Make sure docs reinforce it:

  → README on your project: "I can communicate clearly."
  → PR descriptions on others' projects: "I respect maintainers' time."
  → ADRs in your portfolio: "I think before I build."
  → Changelogs: "I ship consistently."
  → Commit history: "I work in clean, reviewable increments."
```

## Power Move

"Audit the documentation for [project or repo]. Identify the top 5 gaps — missing README sections, undocumented APIs, stale guides, missing ADRs for key decisions. Then create a documentation plan with priorities and write the single most impactful missing doc first. Make it so clear that a new contributor can go from clone to first PR in under 10 minutes."

The agent becomes your documentation partner — finding what is missing, writing what matters most, and helping you ship docs that make your project (and your portfolio) stand out.
