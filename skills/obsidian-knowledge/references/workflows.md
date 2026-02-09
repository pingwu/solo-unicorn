# Knowledge Management Workflows

Practical workflows for managing your personal knowledge vault with AI assistance.

## Daily Capture Workflow

Start each day by creating or updating your daily note:

```
Create a daily note for today with sections for:
- Morning intentions
- Key tasks
- Learnings
- End of day reflections
```

At end of day:
```
Append my learnings from today to my daily note:
- Discovered that...
- Realized that...
- Next step is to...
```

---

## Idea Capture Workflow

When inspiration strikes:

```
Create a new note at ideas/[idea-name].md with:
- Title: [Idea Name]
- Tags: idea, [domain]
- Status: captured
- Content: [your idea description]
- Related: [any related notes]
```

Later, review and develop:
```
Search for all notes tagged "idea" with status "captured"
```

---

## People & Relationship Tracking

Create notes for key relationships:

```yaml
---
name: John Smith
company: Acme Corp
role: CTO
met: 2025-01-15
tags:
  - person
  - tech-leader
  - mentor
related:
  - projects/ai-collaboration.md
  - ideas/partnership-concept.md
---

# John Smith

## Background
- CTO at Acme Corp
- Expert in distributed systems

## Conversations
### 2025-02-09
- Discussed AI strategy
- Key insight: Start small, iterate fast
```

Find relationship insights:
```
Search for notes mentioning "John Smith" to find all related conversations and projects
```

---

## Learning & Study Notes

Structure learning notes:

```yaml
---
topic: Machine Learning Fundamentals
source: Coursera Course
started: 2025-02-01
status: in-progress
tags:
  - learning
  - machine-learning
  - course
---

# Machine Learning Fundamentals

## Key Concepts
- Supervised vs unsupervised learning
- Feature engineering importance

## Insights
- Connection to [existing idea]...

## Action Items
- [ ] Apply concept to project X
- [ ] Research topic Y further
```

---

## Project Knowledge Base

Create a knowledge hub for each project:

```yaml
---
project: Unicorn Incubator
status: active
team:
  - people/john-smith.md
  - people/jane-doe.md
tags:
  - project
  - active
  - incubator
---

# Unicorn Incubator

## Overview
[Project description]

## Decisions Log
### 2025-02-09 - Chose Next.js for frontend
- Rationale: SSR support, great DX
- Alternatives considered: Remix, Astro

## Lessons Learned
- Start with MVP, iterate based on feedback
```

---

## Weekly Review Workflow

End of week synthesis:

```
Search for all notes modified this week and summarize key themes
```

Create weekly summary:
```
Create a note at daily/weekly/2025-W06.md summarizing:
- Key accomplishments
- Important learnings
- People connected with
- Ideas generated
- Next week priorities
```

---

## Finding Connections

Discover unexpected links between ideas:

```
Search for notes that share tags with ideas/new-concept.md
```

```
Find all notes in my vault that mention both "AI" and "education"
```

```
List all notes with the frontmatter key "related" pointing to projects/unicorn.md
```

---

## Knowledge Graph Building

Use consistent frontmatter to build a queryable knowledge graph:

```yaml
---
type: idea | person | project | learning | daily
status: captured | developing | active | completed | archived
tags: [list of tags]
related: [list of related note paths]
created: YYYY-MM-DD
modified: YYYY-MM-DD
---
```

Query your graph:
```
Find all "idea" type notes with status "developing" that are related to any "project" type notes
```
