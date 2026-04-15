---
name: open-source-contribution
description: Build credibility and real-world experience through open-source contributions. Covers finding the right project, reading unfamiliar codebases, forking and PR workflow, writing effective PR descriptions, responding to code review, contribution etiquette, non-code contributions, and building community relationships. Use when preparing to contribute to open source, improving contribution quality, or building a public portfolio through open-source work.
---

# Open-Source Contribution

## Core Principle

Open-source contribution is not about writing code for free. It is about building a public track record of competence — proof that you can read unfamiliar codebases, communicate clearly with strangers, ship work that meets someone else's standards, and collaborate asynchronously. For job seekers, a well-chosen open-source contribution is worth more than ten private side projects nobody can verify.

## Finding the Right Project

### Project Selection Criteria

```
Score each dimension 1-5:

1. RELEVANCE TO YOUR GOALS
   Does the project use your target tech stack?
   Will contributions here impress the employers you want?
   Does it appear on job descriptions in your field?

2. PROJECT HEALTH
   Are issues being responded to within days, not months?
   Have PRs been merged in the last 30 days?
   Is there more than one active maintainer?
   Does the project have a CONTRIBUTING.md or contributor guide?

3. ACCESSIBILITY
   Are there issues labeled "good first issue" or "help wanted"?
   Is the codebase small enough to understand in a weekend?
   Is the documentation sufficient to get a local dev environment running?

4. COMMUNITY
   Are maintainers respectful in issue comments and PR reviews?
   Is there a Code of Conduct?
   Do contributors get acknowledged?

Score:
  16-20: Ideal first project — start here
  11-15: Worth trying if it aligns with your goals
  6-10:  High friction, consider alternatives
  1-5:   Walk away
```

### Where to Find Good First Projects

```
CURATED LISTS
  - GitHub "good first issue" label search
  - goodfirstissue.dev — aggregates beginner-friendly issues
  - up-for-grabs.net — curated list across languages
  - GitHub Explore trending repos in your language

STRATEGIC PICKS
  - Tools you already use daily (you understand the problem space)
  - Libraries in your project's dependency tree (you can test changes locally)
  - Developer tools and CLIs (smaller scope, faster feedback loops)
  - Documentation-heavy projects (lower barrier, high impact)

RED FLAGS — AVOID THESE
  - No activity in 6+ months
  - Maintainer responds with hostility or dismissiveness
  - No contributing guide and no response to "how can I help?" issues
  - Thousands of open issues with no triage system
```

## Reading Unfamiliar Codebases

### The 30-Minute Orientation

Before touching any code, spend 30 minutes reading:

```
1. README.md — What does this project do? Who is it for?
2. CONTRIBUTING.md — How do they want contributions submitted?
3. Directory structure — What's the high-level architecture?
4. Recent merged PRs — What does a successful contribution look like?
5. Open issues labeled "good first issue" — What's available?
```

### Going Deeper

```
UNDERSTAND THE ARCHITECTURE
  - Find the entry point (main.py, index.ts, cmd/root.go, etc.)
  - Trace one request or command from input to output
  - Identify the core abstractions: models, services, handlers, etc.
  - Read the tests — they document intended behavior better than comments

USE YOUR TOOLS
  - Clone the repo and get it running locally FIRST
  - Use your editor's "Go to Definition" and "Find References"
  - Run the test suite — does it pass? What does it cover?
  - Read git log --oneline -20 to see what's been changing recently

USE AI AGENTS TO ACCELERATE
  - Point an AI agent at the repo and ask:
    "Explain the architecture of this project in plain English"
  - Ask it to trace a specific code path:
    "Walk me through what happens when a user calls the /api/users endpoint"
  - Ask it to explain unfamiliar patterns:
    "What design pattern is this module using and why?"
  - Ask it to summarize conventions:
    "What naming conventions, file organization, and code style does this project follow?"
```

## Fork, Branch, and PR Workflow

### Step-by-Step Workflow

```
1. FORK
   Click "Fork" on GitHub to create your copy.
   Clone YOUR fork locally:
     git clone https://github.com/YOUR-USERNAME/project.git
   Add the original repo as "upstream":
     git remote add upstream https://github.com/ORIGINAL-OWNER/project.git

2. BRANCH
   Always branch from the latest upstream main:
     git fetch upstream
     git checkout -b fix/typo-in-readme upstream/main
   Use descriptive branch names:
     fix/null-check-user-service
     feat/add-csv-export
     docs/clarify-installation-steps

3. MAKE YOUR CHANGES
   Keep changes small and focused — one logical change per PR.
   Follow existing code style exactly (indentation, naming, patterns).
   Add or update tests if the project has them.
   Run the full test suite before pushing.

4. COMMIT
   Write clear, conventional commit messages:
     fix: handle null user in profile endpoint
     docs: add Docker setup instructions to README
     test: add edge case coverage for CSV parser
   Keep commits atomic — each commit should compile and pass tests.

5. PUSH AND OPEN PR
   Push to YOUR fork:
     git push origin fix/null-check-user-service
   Open a PR from your fork's branch to upstream's main.
   Fill out the PR template completely.

6. KEEP YOUR FORK UPDATED
   Before starting new work:
     git fetch upstream
     git rebase upstream/main
   Resolve any conflicts carefully.
```

## Writing Good PR Descriptions

### PR Description Template

```markdown
## What

One sentence: what does this PR do?

## Why

What problem does this solve? Link to the issue: Fixes #123

## How

Brief explanation of the approach. Why this approach over alternatives?

## Testing

How did you verify this works?
- [ ] Ran existing test suite
- [ ] Added new tests for [specific behavior]
- [ ] Tested manually by [what you did]

## Screenshots (if UI change)

Before | After

## Notes for Reviewers

Anything the reviewer should pay attention to.
Any trade-offs or decisions you want feedback on.
```

### What Makes a PR Stand Out

```
GOOD PR (gets merged):
  - Links to the issue it addresses
  - Explains WHY, not just WHAT
  - Small, focused diff (under 200 lines for a first contribution)
  - Tests included or explanation of why not
  - Follows project conventions perfectly
  - Author responds to feedback within 24-48 hours

BAD PR (gets ignored or closed):
  - No description beyond "fixed stuff"
  - Massive diff touching dozens of files
  - Reformats code the maintainer didn't ask to reformat
  - Breaks existing tests
  - No connection to any open issue or discussion
  - Author argues with every review comment
```

## Writing Good Commit Messages

```
FORMAT:
  <type>: <short description in imperative mood>

  <optional body explaining WHY, not WHAT>

  <optional footer: references, breaking changes>

TYPES:
  fix:      Bug fix
  feat:     New feature
  docs:     Documentation only
  test:     Adding or updating tests
  refactor: Code change that doesn't fix a bug or add a feature
  chore:    Build process, dependencies, tooling
  style:    Formatting, whitespace (no logic change)

EXAMPLES:
  fix: prevent crash when user email is null

  The profile endpoint assumed email was always present,
  but OAuth users can have null email fields.

  Fixes #247

BAD COMMIT MESSAGES:
  "fixed bug"
  "WIP"
  "updates"
  "addressing review comments"
  "asdfasdf"
```

## Responding to Code Review

### The Right Mindset

Code review on open-source PRs is not personal criticism. The maintainer is protecting a project used by thousands of people. Their feedback is a free education in professional software standards.

### How to Respond

```
WHEN YOU AGREE WITH THE FEEDBACK:
  "Good catch, fixed in [commit hash]."
  "Makes sense. Updated to use the existing helper instead."
  Keep it brief. Fix it. Push the update.

WHEN YOU DISAGREE:
  "I chose this approach because [reasoning]. Would you prefer [alternative]?"
  Never: "But my way works fine."
  Present your reasoning, but defer to the maintainer's decision.
  They know the codebase and the project's direction better than you.

WHEN YOU DON'T UNDERSTAND:
  "Could you point me to an example of how this is done elsewhere in the codebase?"
  "I'm not familiar with this pattern — could you explain why it's preferred here?"
  Asking good questions is a sign of strength, not weakness.

WHEN REVIEW TAKES A WHILE:
  Wait patiently. Maintainers are volunteers.
  A polite bump after 2 weeks is fine: "Hi — just checking if there's anything else
  needed on this PR. Happy to make changes."
  Never: "Hello?? Anyone going to review this?"

AFTER YOUR PR IS MERGED:
  "Thanks for the review and for maintaining this project!"
  A short thank-you goes a long way. Maintainers remember contributors who
  are pleasant to work with.
```

## Contribution Etiquette

### The Rules

```
1. READ BEFORE YOU WRITE
   Read CONTRIBUTING.md cover to cover.
   Read the Code of Conduct.
   Read 3-5 recent merged PRs to see what "good" looks like here.

2. ASK BEFORE YOU BUILD
   Comment on the issue: "I'd like to work on this. Here's my approach: [brief plan]."
   Wait for a maintainer to confirm before writing code.
   This prevents wasted effort on an approach they won't accept.

3. FOLLOW CONVENTIONS EXACTLY
   Use their code style, not yours.
   Use their commit message format, not yours.
   Use their PR template, not yours.
   If they use tabs, you use tabs. End of discussion.

4. KEEP SCOPE TIGHT
   Fix the issue you claimed. Nothing more.
   Don't refactor "while you're in there."
   Don't add features nobody asked for.
   Don't fix other bugs in the same PR.
   One PR = one logical change.

5. BE PATIENT AND GRACIOUS
   Maintainers owe you nothing. They review on their own schedule.
   Rejection is not failure. "Not right now" is a valid response.
   Thank them regardless of outcome.

6. DON'T GHOST
   If you claimed an issue but can't finish, say so.
   "I won't be able to finish this — unassigning myself so someone else can pick it up."
   Ghosting blocks other contributors.
```

## Contributions Beyond Code

Not every valuable contribution involves writing source code. Some of the most impactful contributions require no coding at all.

```
DOCUMENTATION
  Fix typos, improve explanations, add missing setup steps.
  Write a tutorial or guide for a common use case.
  Translate docs into another language.
  This is the single easiest way to make your first contribution.

TESTING
  Add test cases for untested code paths.
  Report bugs with detailed reproduction steps.
  Test on different platforms or environments.

BUG REPORTS
  A well-written bug report is a gift to maintainers:
    - Version of the software
    - Steps to reproduce (exact commands)
    - Expected behavior vs. actual behavior
    - Environment details (OS, runtime version)
    - Minimal reproduction case

TRIAGE AND SUPPORT
  Reproduce bugs others have reported and confirm them.
  Answer questions in issues or discussions.
  Label and categorize issues (if you have permissions).

DESIGN AND UX
  Propose UI improvements with mockups.
  Improve error messages to be more helpful.
  Write better CLI help text.

TRANSLATIONS
  Translate UI strings or documentation.
  Review existing translations for accuracy.

EXAMPLES AND DEMOS
  Create example projects that use the library.
  Record screencasts or walkthroughs.
  Write blog posts explaining how the tool works.
```

## Building Relationships in Open-Source Communities

### The Long Game

```
ONE-TIME CONTRIBUTORS:
  Make a PR, get it merged, disappear.
  No relationship built. Minimal credibility signal.

REPEAT CONTRIBUTORS:
  Make 3-5 quality contributions over weeks or months.
  Maintainers start recognizing your name.
  You get faster reviews and more trust on larger changes.
  THIS is where the career value compounds.

COMMUNITY MEMBERS:
  Help triage issues. Answer questions. Review other PRs.
  Join the Discord, Slack, or mailing list.
  Attend community meetings or office hours.
  Maintainers start recommending you for opportunities.
```

### Building Your Reputation

```
WEEK 1-2: Observer
  Read issues, PRs, and discussions. Understand the culture.
  Make one small contribution (docs fix, typo, small bug fix).

WEEK 3-4: Contributor
  Pick a "good first issue" and complete it end to end.
  Respond to feedback promptly and graciously.

MONTH 2-3: Regular
  Take on slightly larger issues.
  Start helping others in issues and discussions.
  Your name becomes familiar to maintainers.

MONTH 3+: Trusted Contributor
  Propose improvements. Review other PRs.
  Maintainers ask for your opinion on design decisions.
  You get mentioned in release notes and contributor lists.
  This is what shows up on your resume and LinkedIn.
```

## Using AI Agents to Contribute Better

```
BEFORE YOU START:
  "Summarize this repository's architecture, tech stack, and contribution guidelines."
  "What testing framework does this project use and how do I run the tests?"
  "Show me examples of well-structured PRs that have been merged recently."

WHILE UNDERSTANDING THE ISSUE:
  "Explain issue #247 and trace the code path where this bug could occur."
  "What files would I need to modify to add CSV export to the CLI?"
  "What are the project's conventions for error handling?"

WHILE WRITING YOUR CONTRIBUTION:
  "Review my changes against this project's code style and conventions."
  "Write tests for this function following the patterns in the existing test suite."
  "Does my commit message follow this project's conventions?"

BEFORE SUBMITTING:
  "Review my PR description. Is it clear? Does it explain the WHY?"
  "Check my diff for anything I might have missed — unused imports,
   inconsistent naming, missing edge cases."
  "Compare my changes to the project's CONTRIBUTING.md requirements."

RESPONDING TO REVIEW:
  "The maintainer asked me to use X pattern instead. Explain that pattern
   and help me refactor my code to use it."
  "Help me understand this review comment: [paste comment]."
```

## Anti-Patterns

| What NOT to Do | What to Do Instead |
|-----------------|-------------------|
| Submit a massive first PR touching 50 files | Start with a 10-line docs fix to learn the workflow |
| Open a PR without reading CONTRIBUTING.md | Read the guide, then follow it to the letter |
| Ignore maintainer feedback or argue with every comment | Thank them, make the changes, push an update |
| Claim an issue and then disappear for weeks | If you can't finish, unassign yourself and say so |
| Refactor code nobody asked you to refactor | Fix what you said you'd fix, nothing more |
| Open a PR that only reformats whitespace or style | Only make style changes if the project explicitly requests them |
| Submit AI-generated code without understanding it | Use AI to help you learn and write, but understand every line you submit |
| Treat open source as a checkbox for your resume | Choose projects you actually care about and contribute meaningfully |
| Ping maintainers repeatedly for reviews | Wait two weeks, then send one polite follow-up |
| Copy-paste the same generic PR to multiple projects | Tailor every contribution to the specific project's needs and standards |

## Contribution Readiness Checklist

Before submitting any PR, verify:

```
PRE-FLIGHT CHECK:
  [ ] I read CONTRIBUTING.md and followed every instruction
  [ ] I read the Code of Conduct
  [ ] My PR addresses a specific issue or was discussed with maintainers first
  [ ] I branched from the latest upstream main
  [ ] My changes are focused — one logical change only
  [ ] I followed the project's code style exactly
  [ ] I ran the full test suite and it passes
  [ ] I added or updated tests (if applicable)
  [ ] My commit messages follow the project's format
  [ ] My PR description explains WHAT, WHY, and HOW
  [ ] I linked to the relevant issue
  [ ] I reviewed my own diff one more time before submitting
```

## Measuring Your Progress

| Metric | What It Signals | Target |
|--------|----------------|--------|
| PRs merged | Your code meets real-world standards | 1-2 per month in a target project |
| Review turnaround | How responsive and collaborative you are | Respond within 48 hours |
| Projects contributed to | Breadth of experience | 2-3 projects in your target stack |
| Non-code contributions | Community citizenship | At least 1 docs/test/triage contribution |
| Repeat contributions | Depth and commitment | 3+ merged PRs in one project |
| Community interactions | Relationship building | Active in issues and discussions |

## Power Move

"Find an open-source project that uses [my target tech stack] and has active maintainers. Identify 3 'good first issue' tickets I could realistically complete this week. For the best candidate, read the CONTRIBUTING.md, trace the relevant code path, and draft a comment I can post on the issue to claim it — including a brief description of my planned approach. Then help me set up my fork, create a branch, and outline the changes I need to make."

The agent becomes your open-source mentor — turning you from a nervous first-timer into a contributor who ships work that gets merged.
