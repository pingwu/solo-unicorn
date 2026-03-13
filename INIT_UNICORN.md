---
name: init-unicorn
description: First-time setup guide for Solo Unicorn Builder. Creates agent skill symlinks, starts the dev container, initializes your knowledge vault, and sets up version control for your private directories.
---

# INIT_UNICORN.md — First-Time Setup

Run these steps once after cloning or forking the Solo Unicorn Builder project.

> **Windows Users:** Clone or fork this project into your user folder (e.g., `C:\Users\YourName\Projects\unicorn`) to avoid file permission issues that require Administrator privileges.

## 1. Create Agent Skill Symlinks

**Natural Language (Recommended)**:
```
"Set up the agent skill symlinks for .gemini, .claude, and .agent directories"
```

### macOS / Linux

```bash
mkdir -p .claude && ln -s ../skills .claude/skills
mkdir -p .agent && ln -s ../skills .agent/skills
mkdir -p .gemini && ln -s ../skills .gemini/skills
mkdir -p .kiro && ln -s ../skills .kiro/steering
mkdir -p .opencode && ln -s ../skills .opencode/skills
```

Verify: `ls -la .claude/skills .agent/skills .gemini/skills .kiro/steering .opencode/skills`

### Windows

Use junctions (no admin privileges required). Junctions need **absolute paths**.

**PowerShell** (run from project root):
```powershell
$repoRoot = (Get-Location).Path

New-Item -ItemType Directory -Force -Path "$repoRoot\.agent"
New-Item -ItemType Directory -Force -Path "$repoRoot\.gemini"
New-Item -ItemType Directory -Force -Path "$repoRoot\.claude"
New-Item -ItemType Directory -Force -Path "$repoRoot\.kiro"
New-Item -ItemType Directory -Force -Path "$repoRoot\.opencode"

cmd /c mklink /J "$repoRoot\.agent\skills" "$repoRoot\skills"
cmd /c mklink /J "$repoRoot\.gemini\skills" "$repoRoot\skills"
cmd /c mklink /J "$repoRoot\.claude\skills" "$repoRoot\skills"
cmd /c mklink /J "$repoRoot\.kiro\steering" "$repoRoot\skills"
cmd /c mklink /J "$repoRoot\.opencode\skills" "$repoRoot\skills"
```

> **Note:** Windows symlinks (`mklink /D`) require Administrator privileges. Junctions (`mklink /J`) work without elevation.

Verify: `dir .gemini\skills`, `dir .claude\skills`, `dir .agent\skills`, `dir .kiro\steering`

## 2. Initialize Your Knowledge Vault

Copy the template knowledge into your private vault. See [UNICORN_CONSTITUTION.md Section 11](UNICORN_CONSTITUTION.md#11-personal-development-and-knowledge-management) for usage guidelines.

**Natural Language (Recommended)**:
```
"Initialize my knowledge vault from the template"
```

**CLI Reference**:
```bash
mkdir -p my_knowledge
cp -R template_knowledge/* my_knowledge/
```

## 3. Create Your First Project

Copy a starter project from `template_projects/` into `my_projects/` — this is where your code lives.

**Natural Language (Recommended)**:
```
"Copy the landing-page template into my_projects and start the dev container"
```

**CLI Reference**:
```bash
mkdir -p my_projects
cp -R template_projects/landing-page my_projects/landing-page
```

## 4. Start the Dev Container

All dev tools live inside the container. **Never install tools or npm packages on the host.**

**Natural Language (Recommended)**:
```
"Start the dev container for my landing-page project"
```

**CLI Reference**:
```bash
cd my_projects/landing-page
npm run docker:dev
```

Use the container for all commands:
```bash
npm run docker:shell
docker compose run --rm --no-deps dev sh -c "<command>"
```

## 5. Version Control Your Private Directories

The `my_knowledge/` and `my_projects/` directories are git-ignored by the Unicorn repo (via the `my_*` wildcard in `.gitignore`). To track your own changes, **create a separate git repo inside each one**:

```bash
# Track your knowledge vault
cd my_knowledge && git init && git add . && git commit -m "Initial knowledge vault"

# Track each project separately
cd ../my_projects/landing-page && git init && git add . && git commit -m "Initial landing page"
```

> **Why separate repos?** The Unicorn repo is the command center — it receives updates to skills and templates. Your knowledge and projects are *yours* and should have their own version history, pushed to your own private repositories.
