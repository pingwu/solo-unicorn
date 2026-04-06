# UV Package Governance Policy (unicorn)

last_updated: 2026-03-05

Scope: This policy applies to the Solo Unicorn Builder repository. For this repo, Python package installation and lockfile management SHOULD use the `uv` tool for project-level scripts and agent utilities. Prefer `uv` over ad-hoc `pip install` when managing repo dependencies.

Recommended workflow (developer):
1. Create or activate a per-project environment: python3 -m venv .venv && source .venv/bin/activate
2. Install uv: python3 -m pip install uv
3. Create/update lockfile and keep it in agents/: uv lock > agents/requirements.lock
4. Install from lockfile: uv sync --from-lock agents/requirements.lock
5. CI enforcement: run `uv sync --check` (or equivalent) to fail builds on drift.

Notes:
- Adjust uv subcommands to match the installed uv version (`uv --help`).
- Add `.venv/` to .gitignore and avoid committing secrets.
- Placing the policy and lockfile in `agents/` keeps the repository root uncluttered and aligns with agent governance.

I can create initial lockfiles and update CI on request.
