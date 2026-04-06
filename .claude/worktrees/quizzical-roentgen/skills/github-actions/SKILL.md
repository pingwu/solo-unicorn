---
name: github-actions
description: Provides practical guidance on GitHub Actions for CI/CD, automated testing, and deployment pipelines. Use when setting up workflows, debugging failed runs, optimizing build times, or automating any repository task triggered by Git events.
---

# GitHub Actions

This skill covers everything you need to ship portfolio projects with professional-grade automation. GitHub Actions turns your repository into a self-testing, self-deploying machine -- and recruiters notice when your projects have green checkmarks.

## Core Principle

"Automate everything that isn't a judgment call. If a human has to remember to run it, it will eventually be forgotten."

## When to Use This Skill

Use this skill when you need to:
*   Set up continuous integration (run tests on every push).
*   Add linting, type-checking, or formatting enforcement to a repo.
*   Automate deployments to Vercel, Netlify, AWS, or any hosting platform.
*   Build and publish Docker images or npm packages.
*   Create matrix builds that test across multiple Node/Python/Go versions.
*   Speed up slow CI pipelines with caching.
*   Manage secrets and environment variables safely in workflows.

## Why This Matters for Portfolio Projects

Every serious open-source project has CI. When a hiring manager clones your repo and sees a `.github/workflows/` directory with passing badges, it signals:
*   You understand professional development practices.
*   Your code actually works (proven by automation, not claimed in a README).
*   You think about maintainability, not just "it works on my machine."

## Setting Up Your First Workflow

Workflows live in `.github/workflows/` as YAML files. Here is the simplest useful workflow -- run tests on every push:

```yaml
# .github/workflows/ci.yml
name: CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 20
      - run: npm ci
      - run: npm test
```

That is it. Push this file and your repo now has continuous integration.

## Workflow Syntax Basics

### Triggers (`on`)

Control when workflows run:

| Trigger | Use Case |
|---------|----------|
| `push` | Run on every push to specified branches |
| `pull_request` | Run when PRs are opened or updated |
| `schedule` | Cron-based runs (e.g., nightly builds) |
| `workflow_dispatch` | Manual "Run workflow" button in GitHub UI |
| `release` | Run when a release is published |

### Jobs and Steps

*   **Jobs** run in parallel by default. Use `needs:` to create dependencies.
*   **Steps** run sequentially within a job.
*   **Actions** are reusable step packages from the marketplace (e.g., `actions/checkout@v4`).

```yaml
jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm ci
      - run: npm run lint

  test:
    runs-on: ubuntu-latest
    needs: lint  # Only run tests if linting passes
    steps:
      - uses: actions/checkout@v4
      - run: npm ci
      - run: npm test
```

## Common Workflows

### Full CI Pipeline (Lint + Type-Check + Test + Build)

```yaml
name: CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  quality:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 20
          cache: 'npm'
      - run: npm ci
      - run: npm run lint
      - run: npm run typecheck
      - run: npm test -- --coverage
      - run: npm run build
```

### Deploy to Vercel on Merge to Main

```yaml
name: Deploy

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: amondnet/vercel-action@v25
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
          vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}
          vercel-args: '--prod'
```

### Python CI

```yaml
name: Python CI

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with:
          python-version: '3.12'
          cache: 'pip'
      - run: pip install -r requirements.txt
      - run: pytest --cov
```

## Matrix Builds

Test across multiple versions or operating systems in parallel:

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        node-version: [18, 20, 22]
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}
      - run: npm ci
      - run: npm test
```

This spawns three parallel jobs. For portfolio projects, testing across at least two major versions shows thoroughness.

## Caching Dependencies

Slow CI kills momentum. Caching avoids reinstalling dependencies on every run:

```yaml
- uses: actions/setup-node@v4
  with:
    node-version: 20
    cache: 'npm'  # Built-in caching for npm/yarn/pnpm
```

For custom caches (e.g., Turborepo, build artifacts):

```yaml
- uses: actions/cache@v4
  with:
    path: |
      .turbo
      node_modules/.cache
    key: ${{ runner.os }}-turbo-${{ hashFiles('**/package-lock.json') }}
    restore-keys: |
      ${{ runner.os }}-turbo-
```

## Secrets Management

Never hardcode tokens, API keys, or passwords in workflow files.

1.  Go to your repo's **Settings > Secrets and variables > Actions**.
2.  Add secrets there (e.g., `VERCEL_TOKEN`, `DATABASE_URL`).
3.  Reference them in workflows:

```yaml
env:
  DATABASE_URL: ${{ secrets.DATABASE_URL }}
```

**Rules:**
*   Secrets are masked in logs automatically.
*   Secrets are not available in workflows triggered by forks (security feature).
*   Use environment-scoped secrets for staging vs. production separation.

## Reusable Workflows and Composite Actions

### Reusable Workflows

Define a workflow once, call it from others:

```yaml
# .github/workflows/reusable-test.yml
name: Reusable Test
on:
  workflow_call:
    inputs:
      node-version:
        required: true
        type: string

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ inputs.node-version }}
      - run: npm ci
      - run: npm test
```

```yaml
# .github/workflows/ci.yml
jobs:
  call-tests:
    uses: ./.github/workflows/reusable-test.yml
    with:
      node-version: '20'
```

### Composite Actions

Bundle multiple steps into a single reusable action within your repo:

```yaml
# .github/actions/setup-project/action.yml
name: 'Setup Project'
description: 'Install deps and build'
runs:
  using: 'composite'
  steps:
    - uses: actions/setup-node@v4
      with:
        node-version: 20
        cache: 'npm'
    - run: npm ci
      shell: bash
```

Then reference it:

```yaml
steps:
  - uses: actions/checkout@v4
  - uses: ./.github/actions/setup-project
  - run: npm test
```

Use these when you find yourself copying the same setup steps across multiple workflows.

## Anti-Patterns

| Do Not | Do Instead |
|--------|-----------|
| Run the entire pipeline on every push to every branch | Scope triggers to `main` and PRs targeting `main` |
| Store secrets in workflow YAML or committed `.env` files | Use GitHub's encrypted secrets |
| Use `@master` or `@main` for action versions | Pin to a specific version tag (e.g., `@v4`) for reproducibility |
| Install dependencies separately in every job | Use caching or a shared setup composite action |
| Ignore failing CI and merge anyway | Enforce branch protection rules requiring status checks to pass |
| Build massive monolithic workflows in a single file | Split into focused workflows (ci.yml, deploy.yml, release.yml) |
| Run expensive operations (full E2E suite) on every push | Run lightweight checks on push; full suite on PRs or nightly |

## Troubleshooting

*   **Workflow not triggering:** Check that the YAML file is on the default branch (for `push`/`pull_request` triggers) and that the file path is exactly `.github/workflows/`.
*   **"Permission denied" errors:** Verify the `GITHUB_TOKEN` permissions or add explicit `permissions:` to the workflow.
*   **Cache misses every time:** Ensure the `key` includes a hash of your lockfile so it invalidates only when dependencies change.
*   **Matrix job failing on one version:** Check version-specific breaking changes; pin dependencies if needed.

## Power Move

```
"Analyze my project and generate a complete CI/CD pipeline:
1. A ci.yml that lints, type-checks, tests, and builds on every PR
2. A deploy.yml that deploys to production when main is updated
3. Branch protection rules I should enable
4. A status badge I can add to my README

Make the pipeline fast -- use caching and only run expensive jobs when relevant files change."
```

You define what "production-ready" means. The agent wires it all up.
