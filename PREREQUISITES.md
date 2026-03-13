# Prerequisites

This guide covers everything you need to use the Solo Unicorn Builder skills effectively.

## TL;DR — Container-First (Recommended)

**Install only Docker Desktop.** Everything else runs inside a pre-configured container.

```bash
# Option 1: VS Code Dev Containers (easiest)
# Open this repo in VS Code, then click "Reopen in Container" when prompted.

# Option 2: Run the container directly
docker build -t unicorn-dev .devcontainer/
docker run -it --rm -v $(pwd):/workspace unicorn-dev
```

This gives you a fully-equipped environment with Python, Node.js, gcloud, aws-cli, gh, git, ffmpeg, and more — without installing anything on your host machine.

---

## What's Inside the Dev Container

| Tool | Version | Purpose |
|------|---------|---------|
| **Python** | 3.11 | Run Python scripts, AI/ML tools |
| **Node.js** | 20 LTS | Run frontend builds, npm packages |
| **Git** | Latest | Version control |
| **GitHub CLI** (`gh`) | Latest | Create PRs, manage issues from terminal |
| **Google Cloud CLI** (`gcloud`) | Latest | Deploy to GCP (Cloud Run, GCS, etc.) |
| **AWS CLI** (`aws`) | v2 | Deploy to AWS (Lambda, S3, EC2, etc.) |
| **FFmpeg** | Latest | Media processing (video/audio) |
| **jq** | Latest | JSON processing in shell |
| **Docker-in-Docker** | Latest | Build containers inside the dev container |

---

## Manual Installation (Alternative)

If you prefer to install tools directly on your machine, here's what you need:

### Minimum Requirements

These 6 tools are the essential foundation — one in each category:

| Category | Tool | Download | Verify |
|----------|------|----------|--------|
| **IDE** | VS Code | [code.visualstudio.com](https://code.visualstudio.com) | Open the app |
| **AI Coding Agent** | Gemini CLI | [github.com/google-gemini/gemini-cli](https://github.com/google-gemini/gemini-cli) | `gemini --version` |
| **Cloud CLI** | Google Cloud CLI | [cloud.google.com/sdk/docs/install](https://cloud.google.com/sdk/docs/install) | `gcloud --version` |
| **Version Control** | Git | [git-scm.com](https://git-scm.com) | `git --version` |
| **GitHub CLI** | gh | [cli.github.com](https://cli.github.com) | `gh --version` |
| **Containerization** | Docker Desktop | [docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop) | `docker --version` |

**Quick install for Gemini CLI:**
```bash
npm install -g @google/gemini-cli
```

### Additional Runtime Tools

| Tool | Installation | Verify |
|------|--------------|--------|
| **Node.js 18+** | [nodejs.org](https://nodejs.org/) or `brew install node` | `node --version` |
| **Python 3.9+** | [python.org](https://www.python.org/) or `brew install python` | `python3 --version` |

### Cloud CLIs (install based on your cloud provider)

| Tool | Installation | Verify |
|------|--------------|--------|
| **Google Cloud CLI** | [cloud.google.com/sdk/docs/install](https://cloud.google.com/sdk/docs/install) | `gcloud --version` |
| **AWS CLI** | [aws.amazon.com/cli](https://aws.amazon.com/cli/) or `brew install awscli` | `aws --version` |

### Optional but Recommended

| Tool | Installation | Purpose |
|------|--------------|---------|
| **Obsidian** | [obsidian.md](https://obsidian.md) | Markdown editor for knowledge vault and skill files |
| **FFmpeg** | [ffmpeg.org/download](https://ffmpeg.org/download.html) or `brew install ffmpeg` | Video/audio processing |
| **Homebrew** (macOS) | [brew.sh](https://brew.sh/) | Makes installing everything else easier |

---

## AI Coding Agent

You need an AI coding agent that can use the skills in this repository. Choose one:

| Agent | Type | Download |
|-------|------|----------|
| **Gemini CLI** | CLI | [github.com/google-gemini/gemini-cli](https://github.com/google-gemini/gemini-cli) |
| **Claude Code** | CLI + Desktop | [claude.ai/download](https://claude.ai/download) |
| **Cursor** | IDE | [cursor.com](https://cursor.com) |
| **Windsurf** | IDE | [codeium.com/windsurf](https://codeium.com/windsurf) |
| **Kiro** | IDE + CLI | [kiro.dev](https://kiro.dev) |
| **Zed** | IDE | [zed.dev](https://zed.dev) |
| **VS Code + Copilot** | IDE + Extension | See IDE section below |

The skills in this repository are designed to work with any agent that supports tool use and can read the `SKILL.md` files.

---

## IDE (Recommended)

While you can use any text editor, these IDEs have the best AI integration:

| IDE | Best For | Download |
|-----|----------|----------|
| **VS Code** | General development, extensions | [code.visualstudio.com](https://code.visualstudio.com) |
| **Cursor** | AI-first workflow | [cursor.com](https://cursor.com) |
| **Windsurf** | AI-first workflow | [codeium.com/windsurf](https://codeium.com/windsurf) |
| **Kiro** | Spec-driven development | [kiro.dev/downloads](https://kiro.dev/downloads) |
| **Zed** | Performance, collaboration | [zed.dev](https://zed.dev) |

### VS Code Dev Containers

If you use VS Code, the easiest setup is:

1. Install the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
2. Open this repository in VS Code
3. Click "Reopen in Container" when prompted
4. Done — all tools are pre-installed

---

## Additional Supporting Tools to Consider

These tools are not required but can enhance your workflow depending on your project needs:

| Tool | Purpose | Download |
|------|---------|----------|
| **Postman** | API testing and development | [postman.com/downloads](https://www.postman.com/downloads/) |
| **Insomnia** | API testing (open-source alternative) | [insomnia.rest/download](https://insomnia.rest/download) |
| **DBeaver** | Universal database management | [dbeaver.io/download](https://dbeaver.io/download/) |
| **pgAdmin** | PostgreSQL database management | [pgadmin.org/download](https://www.pgadmin.org/download/) |
| **Figma** | UI/UX design and prototyping | [figma.com/downloads](https://www.figma.com/downloads/) |
| **TablePlus** | Modern database GUI (macOS/Windows) | [tableplus.com](https://tableplus.com/) |

---

## Authentication Setup

After installing the tools, authenticate with your cloud providers:

```bash
# GitHub CLI
gh auth login

# Google Cloud
gcloud auth login
gcloud config set project YOUR_PROJECT_ID

# AWS
aws configure
# Or use SSO: aws sso login --profile YOUR_PROFILE
```

---

## Verification Checklist

Run this script to verify your environment is ready:

```bash
echo "=== Checking Prerequisites ==="

# Docker
docker --version && echo "✓ Docker" || echo "✗ Docker"

# Git
git --version && echo "✓ Git" || echo "✗ Git"

# GitHub CLI
gh --version && echo "✓ GitHub CLI" || echo "✗ GitHub CLI"

# Node.js
node --version && echo "✓ Node.js" || echo "✗ Node.js"

# Python
python3 --version && echo "✓ Python" || echo "✗ Python"

# Google Cloud CLI
gcloud --version 2>/dev/null | head -1 && echo "✓ gcloud" || echo "✗ gcloud"

# Gemini CLI
gemini --version 2>/dev/null && echo "✓ Gemini CLI" || echo "✗ Gemini CLI"

# VS Code (check if code command exists)
code --version 2>/dev/null | head -1 && echo "✓ VS Code" || echo "- VS Code (optional)"

# AWS CLI (optional)
aws --version 2>/dev/null && echo "✓ AWS CLI" || echo "- AWS CLI (optional)"

# FFmpeg (optional)
ffmpeg -version 2>/dev/null | head -1 && echo "✓ FFmpeg" || echo "- FFmpeg (optional)"

echo "=== Done ==="
```

---

## Troubleshooting

### "command not found: docker"
Install Docker Desktop from [docker.com](https://www.docker.com/products/docker-desktop) and make sure it's running.

### "permission denied" when running docker
On Linux, add your user to the docker group:
```bash
sudo usermod -aG docker $USER
# Then log out and back in
```

### "gcloud: command not found" after installation
Add gcloud to your PATH. For macOS/Linux:
```bash
# Add to your ~/.zshrc or ~/.bashrc:
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
```

### Node.js version too old
Use a version manager like `nvm` to install Node.js 18+:
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install 20
nvm use 20
```

### Python version too old
Use `pyenv` to install Python 3.9+:
```bash
brew install pyenv
pyenv install 3.11
pyenv global 3.11
```

### "gemini: command not found"
Install Gemini CLI globally via npm:
```bash
npm install -g @google/gemini-cli
```

---

## Next Steps

Once your environment is ready:

1. Read the [README.md](./README.md) for an overview of the skill system
2. Browse the skills in [.claude/skills/](./.claude/skills/)
3. Try the landing page example: "Build me a SaaS landing page for a project management tool"
