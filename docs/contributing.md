---
name: contributing
description: Step-by-step guide for contributing skills to the Solo Unicorn Builder project via fork, AI agent, and pull request.
---

# Contributing Skills

Solo Unicorn Builder's skills are open and community-driven. If you've built expertise in a domain — recruiting, accounting, coaching, design, anything — you can package it as a skill and contribute it to the project.

## Why Contribute?

The best skills come from people who do the work — not people who theorize about it. If you've solved a real problem for real people, that's a skill worth sharing.

Contributing also builds your portfolio. An open-source contribution to an AI-native project is exactly what employers want to see.

## Prerequisites

- A [GitHub account](https://github.com)
- [GitHub CLI (`gh`)](https://cli.github.com/) installed
- An AI coding agent installed — pick one or more:
  - [Claude Code](https://docs.anthropic.com/en/docs/claude-code) (`npm install -g @anthropic-ai/claude-code`)
  - [Gemini CLI](https://github.com/google-gemini/gemini-cli) (`npm install -g @google/gemini-cli`)
  - Or any agentic CLI that reads `SKILL.md` files

## Step-by-Step: Fork, Build, Contribute

### Step 1: Authenticate with GitHub

Tell your AI agent:
```
"Authenticate me with GitHub CLI"
```

Shell command:
```bash
gh auth login
```

### Step 2: Fork and clone the Solo Unicorn Builder project

Tell your AI agent:
```
"Fork the pingwu/solo-unicorn repo and clone it to my machine"
```

Shell commands:
```bash
gh repo fork pingwu/solo-unicorn --clone
cd solo-unicorn
```

This creates your own copy on GitHub and clones it locally. The original repo is set as the `upstream` remote automatically.

### Step 3: Run the Solo Unicorn Builder init setup

Tell your AI agent:
```
"Run the init unicorn setup"
```

Or follow [INIT_UNICORN.md](../INIT_UNICORN.md) manually. This creates your personal knowledge vault and connects the skills.

### Step 4: Create a branch for your skill

Tell your AI agent:
```
"Create a new branch called add-skill-[your-skill-name]"
```

Shell command:
```bash
git checkout -b add-skill-your-skill-name
```

### Step 5: Build your skill

Tell your AI agent:
```
"Help me create a new skill called [your-skill-name] in the skills directory.
Look at an existing skill like career-resume or sales as a template."
```

This is where the AI agent shines. Describe your domain expertise and the agent will help you structure it into a proper `SKILL.md` file.

Your skill needs:

```
skills/
  your-skill-name/
    SKILL.md        # The skill definition (required)
```

The `SKILL.md` file needs:
- YAML front matter with `name` and `description`
- Clear frameworks, templates, and actionable guidance
- Anti-patterns (what NOT to do)
- A "Power Move" — a prompt that showcases the skill's full capability

Look at any existing skill in `skills/` for the pattern. Keep it practical and grounded in real experience.

### Step 6: Test your skill

Tell your AI agent:
```
"Use the [your-skill-name] skill to help me with [a real scenario]"
```

Try your skill on a real problem. Does the AI give useful, specific guidance? If it's too generic, make the skill more concrete. If it's too narrow, broaden it.

### Step 7: Commit your changes

Tell your AI agent:
```
"Commit my new skill with a descriptive message"
```

Shell commands:
```bash
git add skills/your-skill-name/
git commit -m "Add [your-skill-name] skill: [brief description]"
```

### Step 8: Push to your fork

Tell your AI agent:
```
"Push my branch to my fork on GitHub"
```

Shell command:
```bash
git push -u origin add-skill-your-skill-name
```

### Step 9: Create a pull request

Tell your AI agent:
```
"Create a pull request to contribute my new skill back to the original Solo Unicorn Builder project"
```

Shell command:
```bash
gh pr create --title "Add [your-skill-name] skill" --body "## What this skill does
[Describe the domain expertise this skill provides]

## Who it's for
[Describe the target user]

## How I tested it
[Describe a real scenario you tested it on]"
```

### Step 10: Respond to feedback

The maintainers may request changes. Your AI agent can help:
```
"Show me the review comments on my pull request and help me address them"
```

Shell command to check PR status:
```bash
gh pr status
gh pr checks
```

## Keeping Your Fork Up to Date

Before starting new work, sync with the original project:

Tell your AI agent:
```
"Sync my fork with the latest changes from the upstream Solo Unicorn Builder project"
```

Shell commands:
```bash
gh repo sync
git pull
```

## Resolving Merge Conflicts

If your branch has changes that conflict with the upstream project, you'll need to resolve them before your PR can be merged.

Tell your AI agent:
```
"I have merge conflicts. Help me rebase my branch on the latest upstream main and resolve the conflicts."
```

Shell commands:
```bash
# 1. Fetch the latest from upstream
git fetch upstream

# 2. Rebase your branch on top of upstream/main
git rebase upstream/main

# 3. If conflicts appear, Git will pause and show which files conflict.
#    Open each conflicted file — look for <<<<<<< and >>>>>>> markers.
#    Decide which version to keep (yours, theirs, or a combination).

# 4. After resolving each file:
git add <resolved-file>
git rebase --continue

# 5. If things get messy and you want to start over:
git rebase --abort

# 6. Once resolved, force-push your branch (safe because it's your fork):
git push --force-with-lease
```

**Tip:** Your AI agent is great at resolving conflicts. Just tell it:
```
"Show me the merge conflicts and help me resolve them one by one"
```

It will read each conflicted file, explain what both sides changed, and help you pick the right resolution.

## Architecture

The skills architecture follows the pattern established by Anthropic's [knowledge-work-plugins](https://github.com/anthropics/knowledge-work-plugins/) — open-source, documented processes for AI to augment knowledge worker tasks. Solo Unicorn Builder extends this into a community-driven marketplace where practitioners contribute skills from their real-world expertise.
