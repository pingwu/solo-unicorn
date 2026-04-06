---
name: skill-creator
description: Meta-skill for creating new Solo Unicorn Builder skills. Covers skill anatomy, YAML front matter, progressive disclosure, bundled resources, and the creation process. Use when building a new skill, updating an existing skill, or understanding how the skill system works.
---

# Skill Creator

## Core Principle

Skills are onboarding guides for AI agents. They transform a general-purpose agent into a specialized one with procedural knowledge no model fully possesses. The context window is a shared resource — every token must earn its place.

## Anatomy of a Skill

```
skill-name/
├── SKILL.md (required)
│   ├── YAML frontmatter: name + description (required)
│   └── Markdown body: instructions and guidance
└── Bundled Resources (optional)
    ├── scripts/       — Executable code for deterministic tasks
    ├── references/    — Documentation loaded into context as needed
    └── assets/        — Files used in output (templates, images, fonts)
```

### SKILL.md Front Matter (Required)

```yaml
---
name: kebab-case-name
description: What the skill does and when to use it. Include trigger
  conditions — this is the primary mechanism for skill activation.
---
```

The `description` field is what the AI reads to decide whether to activate the skill. Put ALL "when to use" information here — not in the body (the body is only loaded after triggering).

### SKILL.md Body

Instructions for using the skill. Written for an AI agent, not a human user.

```
Default assumption: The AI is already very smart.
Only add context it doesn't already have.

Challenge each piece of information:
  → "Does the AI really need this explanation?"
  → "Does this paragraph justify its token cost?"
```

## Degrees of Freedom

Match specificity to fragility:

| Freedom | When | Example |
|---------|------|---------|
| **High** (text instructions) | Multiple valid approaches, context-dependent | "Choose a testing strategy appropriate for the project" |
| **Medium** (pseudocode/scripts with params) | Preferred pattern exists, some variation OK | Template with configurable sections |
| **Low** (specific scripts, few params) | Fragile operations, consistency critical | Exact XML manipulation steps for .docx editing |

Think of the AI exploring a path: narrow bridge with cliffs needs guardrails (low freedom), open field allows many routes (high freedom).

## Progressive Disclosure

Skills use three levels to manage context efficiently:

```
Level 1: METADATA (always in context)
  → name + description (~100 words)
  → Used to decide if skill triggers

Level 2: SKILL.md BODY (loaded when skill triggers)
  → Core instructions (<500 lines)
  → Workflows, decision trees, essential examples

Level 3: BUNDLED RESOURCES (loaded as needed)
  → scripts/ — can be executed without reading into context
  → references/ — loaded only for relevant sections
  → assets/ — used in output, never loaded into context
```

### Splitting Patterns

When SKILL.md approaches 500 lines, split content:

```markdown
# Main Skill

## Quick Start
[Essential workflow here]

## Advanced Features
- **Form filling**: See [FORMS.md](FORMS.md)
- **API reference**: See [REFERENCE.md](REFERENCE.md)
```

For skills with multiple domains or variants:

```
skill-name/
├── SKILL.md (overview + navigation)
└── references/
    ├── aws.md      — loaded only for AWS tasks
    ├── gcp.md      — loaded only for GCP tasks
    └── azure.md    — loaded only for Azure tasks
```

## Skill Creation Process

### Step 1: Understand with Concrete Examples

```
Ask:
  → What functionality should this skill support?
  → What are 3-5 example prompts that would trigger it?
  → What would a user say that should activate this skill?
  → What does the AI need to know that it doesn't already?

EXIT: Clear sense of the skill's scope and trigger conditions.
```

### Step 2: Plan Reusable Contents

```
For each example prompt, ask:
  → What code would I write from scratch each time?
    → Put in scripts/
  → What reference material would I look up each time?
    → Put in references/
  → What templates or assets would I start from each time?
    → Put in assets/

Most skills only need SKILL.md. Don't create empty directories.
```

### Step 3: Write the Skill

```
FRONT MATTER:
  → name: kebab-case, matches directory name
  → description: comprehensive trigger conditions

BODY STRUCTURE (Solo Unicorn Builder convention):
  ## Core Principle       — One sentence philosophy
  ## [Main Sections]      — Workflows, patterns, examples
  ## Anti-Patterns        — Table: Anti-Pattern | Why | Do This Instead
  ## Power Move           — A prompt that showcases the skill's full power

STYLE:
  → Imperative/infinitive form ("Use X" not "You should use X")
  → Concise examples over verbose explanations
  → Tables for structured comparisons
  → Code blocks for anything copy-pasteable
```

### Step 4: Test and Iterate

```
1. Use the skill on 2-3 real tasks
2. Note where the AI struggles or guesses wrong
3. Add the missing context to SKILL.md or references/
4. Remove anything the AI didn't need
5. Repeat until the skill reliably produces good results
```

## What NOT to Include

```
DO NOT create:
  → README.md (the skill IS the documentation)
  → INSTALLATION_GUIDE.md
  → CHANGELOG.md
  → Test files for the skill itself
  → User-facing documentation (skills are for AI agents)

The skill contains only what an AI agent needs to do the job.
```

## Anti-Patterns

| Anti-Pattern | Why It Hurts | Do This Instead |
|---|---|---|
| "When to use" in the body instead of description | AI never sees it before triggering | Put ALL trigger conditions in the YAML description |
| Explaining things the AI already knows | Wastes context window tokens | Only add knowledge the AI doesn't have |
| One massive SKILL.md with everything | Context window bloat on every activation | Progressive disclosure — split into references/ |
| Empty scripts/, references/, assets/ dirs | Clutter, confusing | Only create directories you need |
| Deeply nested reference files | Hard for AI to discover and navigate | Keep references one level deep from SKILL.md |
| Writing for human users | Wrong audience — skills are for AI agents | Write instructions the AI can follow, not tutorials |

## Power Move

"Create a new skill for [domain/task]. Start by listing 5 example prompts that should trigger it. Then identify what knowledge the AI needs that it doesn't already have. Write the SKILL.md with front matter, core sections, anti-patterns table, and a power move prompt. Keep it under 300 lines."

The agent becomes your skill architect — packaging expert knowledge into reusable AI capabilities.
