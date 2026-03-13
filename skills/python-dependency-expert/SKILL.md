---
name: python-dependency-expert
description: Resolve Python dependency conflicts, build reproducible environments, and navigate the AI/ML packaging ecosystem with confidence. Use when hitting version conflicts, setting up new projects, debugging import errors, containerizing ML pipelines, or when pip install fails and you don't know why.
---

# Python Dependency Expert

## Core Principle

Dependency management is environment management. A project that installs cleanly on one machine and breaks on another has no dependency strategy -- it has dependency luck.

## Why Python Dependencies Break (Especially in AI/ML)

Python's packaging ecosystem is uniquely fragile for AI/ML work:

- **Binary compatibility**: numpy, scipy, torch, and tensorflow ship compiled C/C++/CUDA code. A numpy built against one BLAS library can segfault with a scipy expecting another.
- **Transitive dependency sprawl**: `langchain` pulls in 50+ packages. `transformers` pulls in tokenizers, safetensors, huggingface-hub -- each with their own version constraints.
- **Platform-specific builds**: PyTorch ships separate wheels for CPU, CUDA 11.8, CUDA 12.1, and ROCm. Pick the wrong one and nothing works.
- **No global resolver (historically)**: pip installed packages one at a time, happily overwriting what it just installed. Modern pip has a resolver, but it's still not as robust as conda's SAT solver.

This is dependency hell. The fix is discipline, not hope.

## Virtual Environments: venv vs. conda vs. pyenv

### When to Use Which

| Tool | Use When | Avoid When |
|------|----------|------------|
| `venv` | Pure Python projects, quick isolation, CI pipelines | You need CUDA toolkit, system-level C libraries |
| `conda` | GPU/CUDA workflows, scientific computing, cross-language deps (C, Fortran) | Lightweight projects where pip is sufficient |
| `pyenv` | Managing multiple Python versions on one machine | Environment isolation (pyenv manages Pythons, not environments) |

### The Practical Setup

```bash
# venv: fast, built-in, sufficient for most projects
python -m venv .venv
source .venv/bin/activate  # Linux/macOS
.venv\Scripts\activate     # Windows

# conda: when you need CUDA or compiled scientific libraries
conda create -n ml-project python=3.11
conda activate ml-project

# pyenv + venv: best of both worlds for Python version control
pyenv install 3.11.9
pyenv local 3.11.9
python -m venv .venv
```

**Rule of thumb**: If your project imports `torch`, `tensorflow`, or anything that talks to a GPU, start with conda. Otherwise, `venv` is fine.

## Package Managers: pip vs. pip-tools vs. poetry vs. uv

### Comparison

| Tool | Resolver | Lock File | Speed | Best For |
|------|----------|-----------|-------|----------|
| `pip` | Yes (backtracking) | No native lock | Moderate | Simple installs, CI |
| `pip-tools` | pip's resolver | `requirements.txt` (compiled) | Moderate | Reproducible pip-based workflows |
| `poetry` | Own resolver | `poetry.lock` | Slow | Application packaging, library publishing |
| `uv` | Own resolver (Rust) | `uv.lock` | Very fast | Drop-in pip replacement, speed-critical CI |

### Recommendations

- **Starting a new AI/ML project?** Use `uv` or `pip-tools`. Both give you lock files without reinventing your workflow.
- **Publishing a library to PyPI?** Use `poetry` or `flit` with `pyproject.toml`.
- **Existing project with requirements.txt?** Add `pip-tools` on top. Zero migration cost.
- **Need maximum speed in CI?** `uv` installs packages 10-100x faster than pip.

```bash
# pip-tools workflow
pip install pip-tools
pip-compile requirements.in          # generates pinned requirements.txt
pip-sync requirements.txt            # installs exactly what's in the lock file

# uv workflow (drop-in pip replacement)
pip install uv
uv pip install -r requirements.txt   # fast install
uv pip compile requirements.in       # fast resolve + lock
```

## Configuration Files: requirements.txt vs. pyproject.toml vs. setup.cfg

| File | Purpose | When to Use |
|------|---------|-------------|
| `requirements.txt` | Flat list of pinned dependencies | Deployments, Docker builds, CI |
| `requirements.in` | Unpinned/loosely pinned top-level deps | Input for pip-compile |
| `pyproject.toml` | Project metadata + dependencies + tool config | New projects, libraries, anything modern |
| `setup.cfg` / `setup.py` | Legacy packaging config | Maintaining older projects only |

**Modern default**: Use `pyproject.toml` as the source of truth. Generate `requirements.txt` from it for deployment.

```toml
# pyproject.toml -- define what you need
[project]
name = "my-ml-project"
requires-python = ">=3.10"
dependencies = [
    "torch>=2.1,<2.3",
    "transformers>=4.36,<5.0",
    "numpy>=1.24,<2.0",
]

[project.optional-dependencies]
dev = ["pytest", "ruff", "mypy"]
```

## Version Pinning: Ranges vs. Exact Pins

### The Spectrum

```
numpy              # no pin -- chaos
numpy>=1.24        # floor only -- slightly less chaos
numpy>=1.24,<2.0   # range -- good for libraries
numpy==1.26.4      # exact pin -- good for applications
```

### AI/ML Projects Need Tight Pinning

AI/ML code is unusually sensitive to dependency versions:

- numpy 2.0 broke backward compatibility with almost every scientific library
- A minor torch update can change model outputs at the floating-point level
- transformers model loading can break between patch versions if saved weights assume specific internal APIs

**Rule**: Pin exact versions in your lock file. Use ranges only in `pyproject.toml` or `requirements.in` (your top-level declarations). Let the resolver figure out compatible combinations.

## Resolving Common AI/ML Conflicts

### numpy / scipy Version Mismatches

```
ERROR: scipy 1.11.4 requires numpy<1.28.0,>=1.21.6, but you have numpy 2.0.0
```

```bash
# Diagnose
pip check
pipdeptree --reverse --packages numpy

# Fix: pin numpy below 2.0 until your stack supports it
pip install "numpy>=1.24,<2.0" scipy
```

### PyTorch + CUDA Compatibility

```bash
# Wrong: installs CPU-only torch from PyPI
pip install torch

# Right: install from PyTorch's index with CUDA support
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

# Verify CUDA is available
python -c "import torch; print(torch.cuda.is_available())"
```

**Conda alternative** (handles CUDA toolkit automatically):
```bash
conda install pytorch torchvision torchaudio pytorch-cuda=12.1 -c pytorch -c nvidia
```

### LangChain Dependency Chains

LangChain's modular packaging (`langchain-core`, `langchain-community`, `langchain-openai`) creates version lock-step requirements.

```bash
# Don't mix langchain ecosystem versions
# Bad: langchain==0.2.0 with langchain-core==0.1.x
# Good: install from the same release cohort
pip install langchain langchain-openai langchain-community --upgrade
```

### tensorflow vs. keras Version Hell

```bash
# TensorFlow 2.16+ uses Keras 3 by default
# If your code expects tf.keras (Keras 2), pin it:
pip install "tensorflow>=2.15,<2.16"

# Or migrate to standalone Keras 3:
pip install keras>=3.0 tensorflow
```

## pip-compile for Reproducible Builds

```bash
# 1. Define your top-level dependencies
# requirements.in
torch>=2.1,<2.3
transformers>=4.36,<5.0
numpy>=1.24,<2.0
fastapi>=0.104

# 2. Compile to a fully pinned lock file
pip-compile requirements.in --output-file requirements.txt --strip-extras

# 3. Result: every transitive dependency pinned
# requirements.txt (auto-generated -- DO NOT EDIT)
# torch==2.2.1
# transformers==4.38.2
# numpy==1.26.4
# tokenizers==0.15.2
# ...every sub-dependency pinned

# 4. Install exactly what was resolved
pip-sync requirements.txt

# 5. Upgrade a single package and re-resolve
pip-compile --upgrade-package transformers requirements.in
```

## Lock Files and Why They Matter

A lock file captures the exact resolved versions of every dependency, including transitive ones.

Without a lock file:
- `pip install -r requirements.txt` today gives you numpy 1.26.4
- `pip install -r requirements.txt` next month gives you numpy 2.0.0
- Your tests pass locally, break in CI, and fail in production

With a lock file:
- Every install is identical, on every machine, every time
- You upgrade intentionally, not accidentally

**Every serious Python project needs a lock file.** Use `pip-compile`, `poetry.lock`, or `uv.lock`.

## Debugging Dependency Conflicts

### The Diagnostic Toolkit

```bash
# Check for broken dependencies in current environment
pip check

# Visualize the full dependency tree
pipdeptree

# Show who depends on a specific package
pipdeptree --reverse --packages numpy

# Test what an install WOULD do without installing
pip install --dry-run transformers==4.38.0

# Show installed package details and dependencies
pip show torch

# Nuclear option: export everything, recreate from scratch
pip freeze > backup.txt
pip install -r requirements.txt --force-reinstall
```

### Diagnostic Prompt

```
"I'm getting this dependency conflict:

[paste full error]

Here is my dependency tree:
[paste output of pipdeptree]

My Python version is 3.11, running on [OS]. I need [package X] and [package Y]
to coexist. Find a compatible version set."
```

## Docker + Python Dependencies

### Layer Caching for Fast Builds

```dockerfile
# Copy dependency files FIRST (changes less often)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code SECOND (changes frequently)
COPY . .
```

### Multi-Stage Build for ML Projects

```dockerfile
# Stage 1: Build wheels for compiled packages
FROM python:3.11-slim AS builder
RUN apt-get update && apt-get install -y build-essential
COPY requirements.txt .
RUN pip wheel --no-cache-dir --wheel-dir /wheels -r requirements.txt

# Stage 2: Slim runtime image
FROM python:3.11-slim AS runtime
COPY --from=builder /wheels /wheels
RUN pip install --no-cache-dir --no-index --find-links=/wheels -r requirements.txt && rm -rf /wheels
COPY . /app
WORKDIR /app
CMD ["python", "main.py"]
```

### GPU Docker Images

```dockerfile
# Start from NVIDIA's CUDA base image
FROM nvidia/cuda:12.1.1-runtime-ubuntu22.04

# Install Python, then torch with matching CUDA
RUN apt-get update && apt-get install -y python3 python3-pip
RUN pip install torch --index-url https://download.pytorch.org/whl/cu121
COPY requirements.txt .
RUN pip install -r requirements.txt
```

## Conda for CUDA/GPU Workflows

```bash
# Conda handles CUDA toolkit, cuDNN, and NCCL as packages
conda create -n gpu-env python=3.11
conda activate gpu-env
conda install pytorch torchvision pytorch-cuda=12.1 -c pytorch -c nvidia

# Export environment for reproducibility
conda env export --from-history > environment.yml

# Recreate on another machine
conda env create -f environment.yml
```

**Key advantage**: conda installs CUDA as a conda package. No system-level CUDA install required. Different projects can use different CUDA versions.

### Mixing Conda and pip (Carefully)

```bash
# Rule: install conda packages FIRST, pip packages LAST
conda install numpy scipy pandas pytorch -c pytorch
pip install transformers langchain  # only for packages not in conda

# NEVER do this: conda install X after pip install X
# It corrupts the environment's dependency tracking
```

## Common AI/ML Dependency Traps

| Trap | What Happens | Fix |
|------|-------------|-----|
| `pip install torch` (from PyPI) | Gets CPU-only build | Use `--index-url` for CUDA wheels |
| tensorflow + keras version mismatch | Import errors, behavior changes | Pin both from same release |
| `pip install` inside conda env after conda packages | Broken environment metadata | Install conda packages first, pip last |
| transformers model saved with v4.35, loaded with v4.38 | Silent weight loading errors | Pin transformers version in model card |
| numpy 2.0 upgrade | Breaks scipy, pandas, torch, everything | Pin `numpy<2.0` until ecosystem catches up |
| No lock file in ML training repo | "It worked on my laptop" | Use pip-compile or uv lock |
| `pip install -r requirements.txt` with unpinned versions | Different results every run | Always generate from a lock file |

## Anti-Patterns

| Anti-Pattern | Why It Hurts | Do This Instead |
|--------------|-------------|-----------------|
| `pip install` in global Python | Pollutes system, version collisions | Always use a virtual environment |
| `conda install X` then `pip install X` | Breaks conda's solver, duplicate packages | Pick one package manager per dependency |
| `requirements.txt` with no version pins | Installs change over time, builds break silently | Use pip-compile to generate pinned files |
| Committing `.venv/` to git | Huge repo, platform-specific binaries | Add `.venv/` to `.gitignore`, commit lock files |
| `pip freeze > requirements.txt` as your lock strategy | Captures everything including dev tools and transitive noise | Use `requirements.in` + `pip-compile` to separate intent from resolution |
| Ignoring `pip check` warnings | Silent incompatibilities cause runtime errors | Run `pip check` in CI |

## Power Move

```
"Audit my Python project for dependency health:
1. Run pip check and report any conflicts
2. Show the dependency tree for my heaviest packages (torch, transformers, etc.)
3. Identify any unpinned or loosely pinned dependencies that could break on next install
4. Check if my torch build matches my CUDA version
5. Generate a pip-compile-compatible requirements.in from my current state
6. Flag any anti-patterns in my setup (global installs, mixed conda/pip, missing lock file)"
```

The agent becomes your dependency auditor -- catching the problems that surface at 2 AM when your training job crashes on a different machine.

## Related Skills

| Skill | When to use it |
|-------|---------------|
| `docker-expert` | Containerize Python apps — Dockerfile best practices, multi-stage builds, compose workflows |
