# Customizing Your Landing Page with AI

> Phases 2-3 of your build journey: Personalize content using natural language, then preview the production build.

## The Natural Language Workflow

You do not need to write code. Open your AI assistant (Claude Code, Gemini CLI, or Codex) and describe what you want in plain English. The AI reads your code, understands the structure, and makes targeted edits.

## Phase 2: Personalize Your Content

Try these prompts with your AI assistant:

```
"Update the hero section with my name 'Your Name' and title 'Your Title'"
```

```
"Change the services section to list my three main offerings"
```

```
"Update the contact section with my email and LinkedIn"
```

### Using Templates

This project includes ready-to-use templates for different use cases:

| Template | Best For | Command |
|----------|----------|---------|
| **Default** (`app/page.tsx`) | General personal branding | Already active |
| **Services** (`templates/services.tsx`) | Consultants, freelancers | "Switch to the services template" |
| **Portfolio** (`templates/portfolio.tsx`) | Designers, developers | "Switch to the portfolio template" |
| **Resume** (`templates/resume.tsx`) | Job seekers | "Switch to the resume template" |
| **Enterprise** (`templates/enterprise.tsx`) | Internal initiatives | "Switch to the enterprise template" |

Each template has placeholder content marked with `[brackets]`. Tell your AI agent what to customize. The agent will copy the template file to `app/page.tsx` for you.

### Prompt and Content Resources

- [Prompt Library](../../projects/agentic-landing-template/docs/prompts/PROMPT-LIBRARY.md) -- Copy-paste prompts for common customizations
- [Content Templates](../../projects/agentic-landing-template/docs/prompts/CONTENT-TEMPLATES.md) -- Detailed content examples for each template

## Phase 3: Production Preview

Once you are happy with your customizations, test the optimized production build:

**Tell your AI agent:**
```
"Stop the dev container and start a production preview build"
```

**CLI Reference:**
```bash
npm run docker:down
npm run docker:prod
```

Open [http://localhost:3001](http://localhost:3001) to see the production version.

**What just happened?** Docker built an optimized, smaller version of your site -- the same thing that will run in the cloud. Production builds remove development tools and optimize for speed.

## Verification Checklist

- [ ] Your personal content appears correctly at localhost:3000
- [ ] The production build at localhost:3001 looks correct
- [ ] All sections reflect your brand and offerings

## Checkpoints

> **Phase 2:** Does the site reflect your personal brand?
>
> **Phase 3:** Does the production build look correct?

---

**Previous:** [Setting Up Your Development Environment](setup.md) | **Next:** [Deploying to the Cloud](deploy.md)
