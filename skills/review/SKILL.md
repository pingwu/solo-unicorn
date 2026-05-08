---
name: review
description: >-
  Review code for bugs, security issues, and improvements.
  Use when the user asks to: (1) review code or a diff,
  (2) check code quality, (3) find bugs or issues,
  (4) audit for security problems.
  Trigger on phrases like 'review this', 'check my code',
  'any issues with this', 'code review'.
---

# Code Review

Review the provided code or diff with focus on:

1. **Correctness** — Logic errors, off-by-one bugs, unhandled edge cases
2. **Security** — Injection, auth issues, secrets in code, unsafe deserialization
3. **Performance** — Unnecessary allocations, N+1 queries, missing indexes
4. **Readability** — Unclear naming, overly complex logic, missing context

## Process

1. Read the code or diff carefully
2. Identify concrete issues (not style nitpicks)
3. For each issue: state what's wrong, why it matters, and suggest a fix
4. If the code looks good, say so — don't invent problems

## Output format

For each issue found:

- **File:line** — Brief description of the problem
  - Why it matters
  - Suggested fix

Keep feedback actionable. Skip praise for things that are simply correct.
