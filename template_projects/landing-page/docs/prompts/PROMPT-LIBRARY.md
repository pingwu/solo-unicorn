---
name: prompt-library
description: Ready-to-use natural language prompts for content customization, styling, Docker operations, and AWS deployment.
---

# Prompt Library

Copy and paste these natural language prompts to your AI agent. Replace bracketed content with your information.

---

## Content Customization

### Hero Section
```
"Update the hero section with:
- Name: [Your Name]
- Title: [Your Title/Profession]
- Tagline: [Your value proposition in one sentence]
- Primary CTA button: [Button text] linking to [#section or URL]
- Secondary CTA: [Button text] linking to [URL]"
```

### Services Section
```
"Replace the services section with these 3 services:
1. [Service Name]: [Description] - $[Price] or [Pricing model]
2. [Service Name]: [Description] - $[Price] or [Pricing model]
3. [Service Name]: [Description] - $[Price] or [Pricing model]
Include icons that match each service theme."
```

### About/Authority Section
```
"Update the authority/about section with:
- Years of experience: [X years]
- Key credential 1: [Certification/Degree/Achievement]
- Key credential 2: [Notable client/project/publication]
- Key credential 3: [Award/Recognition]
- Brief bio: [2-3 sentences about your background]"
```

### Case Studies / Portfolio
```
"Add a case studies section with these projects:
1. [Project Name]: [Problem solved] → [Result achieved] for [Client type]
2. [Project Name]: [Problem solved] → [Result achieved] for [Client type]
3. [Project Name]: [Problem solved] → [Result achieved] for [Client type]
Include metrics where possible (%, $, time saved)."
```

### Testimonials
```
"Add a testimonials section with these quotes:
1. '[Quote]' - [Name], [Title] at [Company]
2. '[Quote]' - [Name], [Title] at [Company]
3. '[Quote]' - [Name], [Title] at [Company]"
```

### FAQ Section
```
"Create an FAQ section answering these questions:
1. [Common question about your services]
2. [Question about pricing/process]
3. [Question about qualifications/experience]
4. [Question about getting started]
Make answers concise (2-3 sentences each)."
```

### Contact Section
```
"Update the contact section with:
- Email: [your@email.com]
- Calendly link: [https://calendly.com/yourusername]
- LinkedIn: [https://linkedin.com/in/yourusername]
- GitHub: [https://github.com/yourusername] (optional)
- Location: [City, State/Country]"
```

---

## Styling & Design

| Prompt | What It Does |
|--------|--------------|
| "Change the primary color from blue to [green/purple/teal]" | Updates color scheme site-wide |
| "Change the fonts to Poppins for headings and Open Sans for body" | Updates typography |
| "Make sure all sections have proper dark mode styling" | Fixes dark mode issues |
| "Fix the mobile responsiveness in the [section name]" | Improves mobile layout |
| "Add subtle fade-in animations when sections scroll into view" | Adds scroll animations |

---

## Template Customization

### Services Template
```
"Customize the services template with:
- Name: Sarah Chen
- Specialty: AI Strategy Consulting
- Tier 1: AI Readiness Assessment - $497
- Tier 2: Implementation Coaching - $2,500/month
- Tier 3: Full-Service AI Transformation - Custom"
```

### Portfolio Template
```
"Update the portfolio template with:
- Name: Alex Rivera
- Role: Product Designer
- Add 5 projects from my work at [Company]
- Skills: Figma, Framer, React, TailwindCSS"
```

### Resume Template
```
"Customize the resume with:
- Name: Jordan Park
- Target role: Senior Software Engineer
- Current: Tech Lead at StartupCo (2022-present)
- Previous: SDE II at BigTech (2019-2022)
- Skills: TypeScript, React, AWS, Go"
```

### Enterprise Initiative Template
```
"Customize the enterprise template for 'Project Phoenix':
- Initiative: Cloud Migration Program
- Sponsor: CTO Jane Wilson
- Phase 1: Assessment (Complete)
- Phase 2: Pilot Migration (Active - 65%)
- Phase 3: Full Migration (Upcoming)
- Key metric: 40% cost reduction target"
```

---

## Enterprise Initiative Prompts

### Transform to Initiative Site
```
"Transform this landing page into an internal initiative communication site
for [Initiative Name] sponsored by [Executive Name, Title]"
```

### Vision & Business Context
```
"Replace the about section with a Vision & Business Context section explaining:
- The Challenge: [Current business problem]
- Our Vision: [Future state we're creating]
- Why Now: [Market forces, competitive pressure, opportunity]
- Strategic Alignment: [How this supports company OKRs]"
```

### Benefits by Stakeholder
```
"Replace the services section with a Benefits section for three audiences:
- For Employees: [How this improves their work]
- For Customers: [How this improves their experience]
- For the Business: [Revenue, cost, competitive impact]"
```

### Program Roadmap
```
"Replace case studies with a Roadmap showing:
- Phase 1 [Name] (Q1-Q2): [Deliverables] - Status: Active
- Phase 2 [Name] (Q3-Q4): [Deliverables] - Status: Upcoming
- Phase 3 [Name] (Next Year): [Deliverables] - Status: Future
Include success metrics for each phase."
```

### Internal FAQ
```
"Update FAQ for an internal initiative addressing:
- How will this affect my day-to-day work?
- Will there be job losses?
- What if I have concerns or ideas?
- What's the timeline for my team?"
```

### Get Involved Section
```
"Replace contact section with a Get Involved section:
- Ways to Participate: [Champion role, working groups, pilot program]
- Stay Informed: [Newsletter, town halls, Slack channel]
- Key Contacts: [Program lead, change management, support]"
```

### Progress Metrics
```
"Add a Metrics Dashboard section showing current vs target:
- Adoption: [X]% → [Y]% employees using new system
- Efficiency: [X] days → [Y] days cycle time
- Savings: $[X]M → $[Y]M annual cost reduction
- Satisfaction: [X] → [Y] employee NPS"
```

---

## Docker & Container Operations

| Prompt | CLI Command |
|--------|-------------|
| "Start the development container with hot-reload" | `npm run docker:dev` |
| "Build and run the production container" | `npm run docker:prod` |
| "Stop all running containers" | `npm run docker:down` |
| "Show me the container logs" | `npm run docker:logs` |
| "What's the status of my containers?" | `npm run docker:status` |
| "Open a shell in the dev container" | `npm run docker:shell` |
| "Clean up all containers and volumes" | `npm run docker:clean` |

---

## AWS Deployment

| Prompt | CLI Command |
|--------|-------------|
| "Help me configure AWS CLI with my credentials" | `aws configure` |
| "Create an ECR repository named my-landing-page" | `aws ecr create-repository --repository-name my-landing-page --region us-west-2` |
| "Log Docker into my ECR registry" | `aws ecr get-login-password --region us-west-2 \| docker login ...` |
| "Tag and push my image to ECR" | `docker tag ... && docker push ...` |
| "Deploy my ECR image to App Runner" | `aws apprunner create-service ...` |
| "Show me the public URL of my App Runner service" | `aws apprunner describe-service --service-arn <arn>` |
| "Delete my App Runner service to avoid charges" | `aws apprunner delete-service --service-arn <arn>` |

See [AWS-DEPLOYMENT-GUIDE.md](../guides/AWS-DEPLOYMENT-GUIDE.md) for complete step-by-step instructions.

---

## Git & Version Control

| Prompt | CLI Command |
|--------|-------------|
| "Initialize git and create the first commit" | `git init && git add . && git commit -m "Initial commit"` |
| "Create a new branch for adding [feature name]" | `git checkout -b feature/[feature-name]` |
| "Commit my changes with a good message" | `git add . && git commit -m "[message]"` |
| "Push my branch to GitHub" | `git push -u origin [branch-name]` |
| "Create a pull request for my changes" | `gh pr create --title "[title]" --body "[description]"` |

---

## Troubleshooting

| Prompt | What Happens |
|--------|-------------|
| "The build is failing with this error: [paste error]" | AI analyzes and fixes the error |
| "The [section] looks broken on mobile" | AI fixes responsive design |
| "My Docker container exits immediately" | AI debugs container issues |
| "I'm getting this AWS error: [paste error]" | AI diagnoses AWS configuration |
| "Fix all TypeScript errors in the project" | AI runs typecheck and fixes errors |
