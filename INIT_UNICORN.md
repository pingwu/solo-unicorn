---
name: init-unicorn
description: First-time setup guide for Solo Unicorn Builder. Creates agent skill symlinks, starts the dev container, initializes your knowledge vault, and sets up version control for your private directories.
---

# INIT_UNICORN.md — First-Time Setup

Run these steps once after cloning or forking the Solo Unicorn Builder project.

> **Windows Users:** Clone or fork this project into your user folder (e.g., `C:\Users\YourName\Projects\unicorn`) to avoid file permission issues that require Administrator privileges.

## 0. Locate the Workspace

AI coding agents may start in either the cloned repo (`solo-unicorn/`) or its parent workspace. The setup uses two folders:

- `UNICORN_DIR` — the cloned Solo Unicorn command-center repo.
- `PROJECT_ROOT` — the parent workspace that holds `solo-unicorn/`, `my_knowledge/`, and `my_projects/` as siblings.

Run this once in your shell before the CLI references below:

```bash
if [ -d "template_knowledge" ] && [ -d "skills" ]; then
  UNICORN_DIR="$(pwd)"
elif [ -d "solo-unicorn/template_knowledge" ]; then
  UNICORN_DIR="$(pwd)/solo-unicorn"
elif [ -d "unicorn/template_knowledge" ]; then
  UNICORN_DIR="$(pwd)/unicorn"
else
  echo "Could not find the Solo Unicorn repo. cd into the repo or its parent workspace." >&2
  exit 1
fi

PROJECT_ROOT="$(dirname "$UNICORN_DIR")"
echo "Project root: $PROJECT_ROOT"
echo "Unicorn repo:  $UNICORN_DIR"
```

## 1. Create Agent Skill Symlinks

**Natural Language (Recommended)**:
```
"Set up the agent skill symlinks for .gemini, .claude, and .agent directories"
```

### macOS / Linux

```bash
mkdir -p "$UNICORN_DIR/.claude" && ln -s "$UNICORN_DIR/skills" "$UNICORN_DIR/.claude/skills"
mkdir -p "$UNICORN_DIR/.agent" && ln -s "$UNICORN_DIR/skills" "$UNICORN_DIR/.agent/skills"
mkdir -p "$UNICORN_DIR/.gemini" && ln -s "$UNICORN_DIR/skills" "$UNICORN_DIR/.gemini/skills"
mkdir -p "$UNICORN_DIR/.kiro" && ln -s "$UNICORN_DIR/skills" "$UNICORN_DIR/.kiro/steering"
mkdir -p "$UNICORN_DIR/.opencode" && ln -s "$UNICORN_DIR/skills" "$UNICORN_DIR/.opencode/skills"
```

Verify:
```bash
ls -la "$UNICORN_DIR/.claude/skills" "$UNICORN_DIR/.agent/skills" "$UNICORN_DIR/.gemini/skills" "$UNICORN_DIR/.kiro/steering" "$UNICORN_DIR/.opencode/skills"
```

### Windows

Use junctions (no admin privileges required). Junctions need **absolute paths**.

**PowerShell** (run from the repo or its parent workspace):
```powershell
if (Test-Path ".\template_knowledge") {
  $unicornDir = (Get-Location).Path
} elseif (Test-Path ".\solo-unicorn\template_knowledge") {
  $unicornDir = Join-Path (Get-Location).Path "solo-unicorn"
} elseif (Test-Path ".\unicorn\template_knowledge") {
  $unicornDir = Join-Path (Get-Location).Path "unicorn"
} else {
  throw "Could not find the Solo Unicorn repo. cd into the repo or its parent workspace."
}
$projectRoot = Split-Path -Path $unicornDir -Parent

New-Item -ItemType Directory -Force -Path "$unicornDir\.agent"
New-Item -ItemType Directory -Force -Path "$unicornDir\.gemini"
New-Item -ItemType Directory -Force -Path "$unicornDir\.claude"
New-Item -ItemType Directory -Force -Path "$unicornDir\.kiro"
New-Item -ItemType Directory -Force -Path "$unicornDir\.opencode"

cmd /c mklink /J "$unicornDir\.agent\skills" "$unicornDir\skills"
cmd /c mklink /J "$unicornDir\.gemini\skills" "$unicornDir\skills"
cmd /c mklink /J "$unicornDir\.claude\skills" "$unicornDir\skills"
cmd /c mklink /J "$unicornDir\.kiro\steering" "$unicornDir\skills"
cmd /c mklink /J "$unicornDir\.opencode\skills" "$unicornDir\skills"
```

> **Note:** Windows symlinks (`mklink /D`) require Administrator privileges. Junctions (`mklink /J`) work without elevation.

Verify: `dir $unicornDir\.gemini\skills`, `dir $unicornDir\.claude\skills`, `dir $unicornDir\.agent\skills`, `dir $unicornDir\.kiro\steering`

## 2. Initialize Your Knowledge Vault

Copy the template knowledge into your private vault. See [UNICORN_CONSTITUTION.md Section 11](UNICORN_CONSTITUTION.md#11-personal-development-and-knowledge-management) for usage guidelines.

**Natural Language (Recommended)**:
```
"Initialize my knowledge vault from the template"
```

**CLI Reference**:
```bash
mkdir -p "$PROJECT_ROOT/my_knowledge"
# Copy only if my_knowledge is empty, don't overwrite existing files
if [ -z "$(ls -A "$PROJECT_ROOT/my_knowledge")" ]; then
  cp -R "$UNICORN_DIR/template_knowledge/"* "$PROJECT_ROOT/my_knowledge/"
else
  echo "Knowledge vault already contains files. Skipping copy to avoid overwriting."
fi
```

## 3. Create Your First Project

Copy a starter project from `template_projects/` into `my_projects/` — this is where your code lives.

**Natural Language (Recommended)**:
```
"Copy the landing-page template into my_projects and start the dev container"
```

**CLI Reference**:
```bash
mkdir -p "$PROJECT_ROOT/my_projects"
# Copy only if landing-page project doesn't exist, don't overwrite existing files
if [ ! -d "$PROJECT_ROOT/my_projects/landing-page" ]; then
  cp -R "$UNICORN_DIR/template_projects/landing-page" "$PROJECT_ROOT/my_projects/landing-page"
else
  echo "Landing-page project already exists. Skipping copy to avoid overwriting."
fi
```

## 4. Start the Dev Container

All dev tools live inside the container. **Never install tools or npm packages on the host.**

**Natural Language (Recommended)**:
```
"Start the dev container for my landing-page project"
```

**CLI Reference**:
```bash
cd "$PROJECT_ROOT/my_projects/landing-page"
npm run docker:dev
```

Use the container for all commands:
```bash
npm run docker:shell
docker compose run --rm --no-deps dev sh -c "<command>"
```

## 5. Version Control Your Private Directories

The `my_knowledge/` and `my_projects/` directories live next to the Unicorn repo. To track your own changes, **create a separate git repo inside each one**:

```bash
# Track your knowledge vault
cd "$PROJECT_ROOT/my_knowledge" && git init && git add . && git commit -m "Initial knowledge vault"

# Track each project separately
cd "$PROJECT_ROOT/my_projects/landing-page" && git init && git add . && git commit -m "Initial landing page"
```

> **Why separate repos?** The Unicorn repo is the command center — it receives updates to skills and templates. Your knowledge and projects are *yours* and should have their own version history, pushed to your own private repositories.
