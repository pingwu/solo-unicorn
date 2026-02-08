# INIT_UNICORN.md — First-Time Setup

Run these steps once after cloning or forking the Unicorn project.

## 1. Create Agent Skill Symlinks

**Natural Language (Recommended)**:
```
"Set up the agent skill symlinks for .gemini, .claude, and .agent directories"
```

### macOS / Linux

```bash
mkdir -p .claude && ln -s skills .claude/skills
mkdir -p .agent && ln -s skills .agent/skills
mkdir -p .gemini && ln -s skills .gemini/skills
```

Verify: `ls -la .claude/skills .agent/skills .gemini/skills`

### Windows

Use junctions (no admin privileges required). Junctions need **absolute paths**.

**PowerShell** (run from project root):
```powershell
$repoRoot = (Get-Location).Path

New-Item -ItemType Directory -Force -Path "$repoRoot\.agent"
New-Item -ItemType Directory -Force -Path "$repoRoot\.gemini"
New-Item -ItemType Directory -Force -Path "$repoRoot\.claude"

cmd /c mklink /J "$repoRoot\.agent\skills" "$repoRoot\skills"
cmd /c mklink /J "$repoRoot\.gemini\skills" "$repoRoot\skills"
cmd /c mklink /J "$repoRoot\.claude\skills" "$repoRoot\skills"
```

> **Note:** Windows symlinks (`mklink /D`) require Administrator privileges. Junctions (`mklink /J`) work without elevation.

Verify: `dir .gemini\skills`, `dir .claude\skills`, `dir .agent\skills`

## 2. Start the Dev Container

All dev tools live inside the container. **Never install tools or npm packages on the host.**

**Natural Language (Recommended)**:
```
"Start the dev container for the agentic-landing-template project"
```

**CLI Reference**:
```bash
cd projects/agentic-landing-template
npm run docker:dev
```

Use the container for all commands:
```bash
npm run docker:shell
docker compose run --rm --no-deps dev sh -c "<command>"
```

## 3. Initialize Personal Knowledge

Initialize your `personal_knowledge/` vault. See [AGENTS.md Section 11](AGENTS.md#11-personal-development-and-knowledge-management) for usage guidelines.

**Natural Language (Recommended)**:
```
"Initialize my personal knowledge vault"
```

**CLI Reference**:
```bash
cp -R template_knowledge/* personal_knowledge/
```
