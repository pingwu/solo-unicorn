---
name: notebooklm
description: Query Google NotebookLM notebooks directly from Claude Code for
  source-grounded, citation-backed answers. Use when user mentions NotebookLM,
  shares a notebooklm.google.com URL, asks to query their notebooks/docs, or
  says "ask my NotebookLM", "check my docs", "query my notebook". Provides
  browser automation, notebook library management, and persistent auth.
  Drastically reduced hallucinations through document-only responses from Gemini.
---

# NotebookLM Research Assistant

Query Google NotebookLM to get source-grounded answers from Gemini. Each question opens a browser session, retrieves the answer exclusively from uploaded documents, and closes.

Based on [PleasePrompto/notebooklm-skill](https://github.com/PleasePrompto/notebooklm-skill).

## Core Principle

NotebookLM answers come ONLY from user-uploaded documents — zero hallucination by design. Use this as a grounded research layer before synthesizing your own response.

## Critical Rules

1. **ALWAYS use `run.py` wrapper** — never call scripts directly
2. **NEVER guess notebook metadata** — use Smart Add or ask the user
3. **ALWAYS follow up** — when you see "Is that ALL you need to know?", analyze gaps before responding

```bash
# CORRECT:
python scripts/run.py ask_question.py --question "..."

# WRONG (fails without venv):
python scripts/ask_question.py --question "..."
```

## Decision Flow

```
User mentions NotebookLM / shares URL / asks to query docs
  |
  v
Check auth --> python scripts/run.py auth_manager.py status
  |
  v (if not authenticated)
Setup auth --> python scripts/run.py auth_manager.py setup
  |            (browser opens - user logs in manually)
  v
Check library --> python scripts/run.py notebook_manager.py list
  |
  v (if notebook not in library)
Smart Add --> query notebook first to discover content, then add
  |
  v
Ask question --> python scripts/run.py ask_question.py --question "..."
  |
  v
See "Is that ALL you need?" --> ask follow-ups until complete
  |
  v
Synthesize all answers --> respond to user
```

## Smart Add (Recommended for New Notebooks)

When user shares a URL without details, discover content first:

```bash
# Step 1: Discover content
python scripts/run.py ask_question.py \
  --question "What is the content of this notebook? What topics are covered? Provide a complete overview briefly and concisely" \
  --notebook-url "[URL]"

# Step 2: Add with discovered info
python scripts/run.py notebook_manager.py add \
  --url "[URL]" \
  --name "[Based on content]" \
  --description "[Based on content]" \
  --topics "[Based on content]"
```

If discovery fails, ask the user for `--name`, `--description`, and `--topics`.

## Script Reference

### Authentication (`auth_manager.py`)

```bash
python scripts/run.py auth_manager.py setup    # One-time login (browser visible)
python scripts/run.py auth_manager.py status   # Check auth state
python scripts/run.py auth_manager.py reauth   # Clear + re-login
python scripts/run.py auth_manager.py clear    # Remove auth data
```

### Notebook Library (`notebook_manager.py`)

```bash
python scripts/run.py notebook_manager.py list
python scripts/run.py notebook_manager.py add --url URL --name NAME --description DESC --topics TOPICS
python scripts/run.py notebook_manager.py search --query QUERY
python scripts/run.py notebook_manager.py activate --id ID
python scripts/run.py notebook_manager.py remove --id ID
python scripts/run.py notebook_manager.py stats
```

### Query (`ask_question.py`)

```bash
python scripts/run.py ask_question.py --question "..."                    # Uses active notebook
python scripts/run.py ask_question.py --question "..." --notebook-id ID   # Specific notebook
python scripts/run.py ask_question.py --question "..." --notebook-url URL # Direct URL
python scripts/run.py ask_question.py --question "..." --show-browser     # Debug mode
```

### Cleanup (`cleanup_manager.py`)

```bash
python scripts/run.py cleanup_manager.py                    # Preview
python scripts/run.py cleanup_manager.py --confirm          # Execute
python scripts/run.py cleanup_manager.py --preserve-library # Keep notebooks
```

## Follow-Up Protocol

Every NotebookLM answer ends with: "Is that ALL you need to know?"

Required behavior:
1. STOP — do not respond to user yet
2. ANALYZE — compare answer to user's original request
3. IDENTIFY GAPS — determine if more info is needed
4. ASK FOLLOW-UP — if gaps exist, query again with context
5. REPEAT — until information is complete
6. SYNTHESIZE — combine all answers, then respond to user

## Environment

- Auto-managed `.venv` — created on first `run.py` call
- Dependencies: `patchright` (browser automation) + `python-dotenv`
- Data stored in `data/` (gitignored): `library.json`, `auth_info.json`, `browser_state/`
- Optional `.env` for config: `HEADLESS`, `SHOW_BROWSER`, `STEALTH_ENABLED`

## Limitations

- No session persistence (each question = new browser session)
- Rate limit: ~50 queries/day on free Google accounts
- User must manually upload docs to NotebookLM
- Browser overhead: few seconds per question

## Troubleshooting

| Problem | Solution |
|---------|----------|
| ModuleNotFoundError | Use `run.py` wrapper |
| Auth fails | Browser must be visible for `setup` |
| Rate limit (50/day) | Wait or `reauth` with different account |
| Browser crashes | `cleanup_manager.py --preserve-library` then `auth_manager.py reauth` |
| Notebook not found | `notebook_manager.py list` to verify |

For detailed troubleshooting: [references/troubleshooting.md](references/troubleshooting.md)
For API details: [references/api_reference.md](references/api_reference.md)
For usage patterns: [references/usage_patterns.md](references/usage_patterns.md)

## Anti-Patterns

| Anti-Pattern | Why | Do This Instead |
|---|---|---|
| Calling scripts without `run.py` | Fails without venv | Always `python scripts/run.py [script].py` |
| Guessing notebook metadata | Wrong descriptions poison search | Smart Add or ask user |
| Responding after first answer | May miss critical info | Follow the follow-up protocol |
| Running auth in headless mode | Google blocks automated login | Always visible browser for auth |
| Ignoring rate limits | 50/day hard cap | Batch questions, be comprehensive |

## Power Move

"Query my NotebookLM docs about [topic], synthesize the findings with what you already know, and give me an implementation plan with citations from my sources."
