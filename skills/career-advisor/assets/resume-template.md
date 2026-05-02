---
name: resume-output
description: Handlebars template for generating tailored resumes. Variables are populated from accomplishments tracker and job description analysis.
---

# {{USER_NAME}}

**{{CONTACT_PHONE}}** | **{{CONTACT_EMAIL}}**{{#if CONTACT_LINKEDIN}} | **{{CONTACT_LINKEDIN}}**{{/if}}

---

## Objective

{{OBJECTIVE}}

---

## Skill Highlights

{{#each SKILL_HIGHLIGHTS}}
- **{{this.category}}:** {{this.description}}
{{/each}}

---

## Professional Experience

{{#each EXPERIENCES}}
### {{this.title}} | {{this.company}} | {{this.dates}}

{{#each this.bullets}}
- {{this}}
{{/each}}

{{/each}}

---

## Technical Skills

{{#each SKILL_CATEGORIES}}
**{{this.name}}:**
{{this.skills}}

{{/each}}

---

## Certifications

{{#each CERTIFICATIONS}}
- {{this}}
{{/each}}

---

## Education

{{#each EDUCATION}}
- **{{this.degree}}**, {{this.school}}, {{this.years}}
{{/each}}

{{#if ADDITIONAL}}
---

## Additional

{{#each ADDITIONAL}}
- {{this}}
{{/each}}
{{/if}}
