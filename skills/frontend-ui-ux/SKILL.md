---
name: frontend-ui-ux
description: Build user-centered, mobile-first, accessible, and performant interfaces with modern frontend practices. Use when designing components, writing CSS, optimizing Core Web Vitals, implementing responsive layouts, auditing accessibility, or when the UI feels wrong but you cannot pinpoint why.
---

# Frontend UI/UX Expert

## Core Principle

Design for the smallest screen first, the weakest network second, and the most constrained user always. Every pixel must earn its place.

## Mobile-First Design

Mobile-first is not about shrinking a desktop layout. It is about starting with the essential content and progressively enhancing for larger viewports.

### Why Mobile-First Matters

- Over 60% of web traffic is mobile. Design for the majority first.
- Constraints force clarity. If it works on a 320px screen, it works everywhere.
- Performance is non-negotiable on 3G connections and budget devices.

### Responsive Breakpoints

Start with no media query (mobile), then layer upward.

```css
/* Base: mobile (no media query needed) */
.container {
  padding: 1rem;
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

/* Tablet */
@media (min-width: 768px) {
  .container {
    flex-direction: row;
    padding: 2rem;
  }
}

/* Desktop */
@media (min-width: 1024px) {
  .container {
    max-width: 1200px;
    margin-inline: auto;
  }
}

/* Large desktop */
@media (min-width: 1440px) {
  .container {
    max-width: 1400px;
  }
}
```

Tailwind CSS 4 equivalent:

```html
<div class="flex flex-col gap-4 p-4 md:flex-row md:p-8 lg:mx-auto lg:max-w-5xl xl:max-w-7xl">
  <!-- content -->
</div>
```

### Touch Targets

- Minimum 44x44px for all interactive elements (WCAG 2.5.8).
- Add padding, not just width/height -- the tap area must be real.
- Space interactive elements at least 8px apart to prevent mis-taps.

```css
.btn-touch {
  min-height: 44px;
  min-width: 44px;
  padding: 12px 24px;
}

/* Increase tap area without increasing visual size */
.icon-button {
  position: relative;
}
.icon-button::after {
  content: "";
  position: absolute;
  inset: -8px;
}
```

### Viewport Considerations

```html
<meta name="viewport" content="width=device-width, initial-scale=1" />
```

- Never use `maximum-scale=1` or `user-scalable=no` -- these block pinch-to-zoom and violate WCAG.
- Use `dvh` (dynamic viewport height) instead of `vh` to handle mobile browser chrome correctly.

```css
.full-screen {
  min-height: 100dvh;
}
```

## Component Architecture

### Design System Thinking

A design system is not a component library. It is a shared language between design and engineering.

| Layer | Contains | Example |
|-------|----------|---------|
| **Tokens** | Colors, spacing, typography, radii, shadows | `--color-primary-600`, `--space-4` |
| **Primitives** | Atoms with no business logic | `<Button>`, `<Input>`, `<Badge>` |
| **Composites** | Molecules combining primitives | `<SearchBar>`, `<UserCard>` |
| **Features** | Organisms with business logic | `<JobApplicationForm>`, `<DashboardMetrics>` |
| **Layouts** | Page shells and navigation | `<AppShell>`, `<SidebarLayout>` |

### Atomic Design in React

```tsx
// Primitive: Button (no business logic, fully controlled via props)
interface ButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  variant: "primary" | "secondary" | "ghost";
  size: "sm" | "md" | "lg";
  loading?: boolean;
}

function Button({ variant, size, loading, children, ...props }: ButtonProps) {
  return (
    <button
      className={cn(
        "inline-flex items-center justify-center rounded-lg font-medium transition-colors",
        "focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-primary-600",
        variants[variant],
        sizes[size],
        loading && "pointer-events-none opacity-60"
      )}
      disabled={loading || props.disabled}
      aria-busy={loading}
      {...props}
    >
      {loading && <Spinner className="mr-2 h-4 w-4" aria-hidden="true" />}
      {children}
    </button>
  );
}
```

### Props and State Management for UI

| Concern | Where It Lives | Why |
|---------|---------------|-----|
| Visual state (open, hovered, focused) | Component-local `useState` | No other component needs it |
| Form field values | Form library (react-hook-form) or parent state | Controlled inputs need a single source of truth |
| Server data (user profile, job listings) | Server state (React Query, SWR, or RSC) | Cache invalidation, background refetch |
| Global UI state (theme, sidebar open) | Context or lightweight store (Zustand) | Shared across distant components |
| URL-driven state (filters, pagination) | URL search params | Shareable, bookmarkable, survives refresh |

Rule of thumb: if the state belongs in the URL, put it in the URL. If it comes from the server, let a cache manage it. Local `useState` is the last resort, not the first.

## CSS Architecture

### Modern CSS Primitives

Use flexbox for one-dimensional layouts, grid for two-dimensional layouts, and container queries when the component's size matters more than the viewport's size.

```css
/* Flexbox: navigation bar */
.nav {
  display: flex;
  align-items: center;
  gap: 1rem;
}

/* Grid: card grid that auto-fills based on available space */
.card-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(min(100%, 300px), 1fr));
  gap: 1.5rem;
}

/* Container queries: component responds to its own container, not the viewport */
.card-container {
  container-type: inline-size;
}

@container (min-width: 400px) {
  .card {
    flex-direction: row;
  }
}
```

### Tailwind CSS 4 Patterns

```html
<!-- Responsive card with dark mode -->
<article class="rounded-xl bg-white p-4 shadow-sm ring-1 ring-gray-100
                dark:bg-gray-900 dark:ring-gray-800
                md:p-6">
  <h2 class="text-lg font-semibold text-gray-900 dark:text-gray-100">
    Job Title
  </h2>
  <p class="mt-1 text-sm text-gray-600 dark:text-gray-400">
    Company Name
  </p>
</article>
```

### Dark Mode

Respect the user's OS preference by default. Provide a toggle that overrides it.

```css
:root {
  --bg: #ffffff;
  --text: #111827;
}

@media (prefers-color-scheme: dark) {
  :root {
    --bg: #0f172a;
    --text: #f1f5f9;
  }
}

/* Override class applied via JS toggle */
[data-theme="dark"] {
  --bg: #0f172a;
  --text: #f1f5f9;
}
```

### Responsive Typography

Use `clamp()` for fluid type that scales between breakpoints without media queries.

```css
h1 {
  font-size: clamp(1.75rem, 1.25rem + 2vw, 3rem);
  line-height: 1.2;
}

body {
  font-size: clamp(1rem, 0.95rem + 0.25vw, 1.125rem);
  line-height: 1.6;
}
```

## Accessibility (a11y)

Accessibility is not a feature. It is a baseline. Target WCAG 2.1 AA as a minimum.

### Semantic HTML First

```html
<!-- Bad: div soup -->
<div class="header">
  <div class="nav">
    <div class="link" onclick="navigate()">Home</div>
  </div>
</div>

<!-- Good: semantic structure -->
<header>
  <nav aria-label="Main navigation">
    <a href="/">Home</a>
  </nav>
</header>
```

Semantic elements provide built-in keyboard navigation, screen reader announcements, and focus management -- for free.

### ARIA: Use Only When HTML Falls Short

```tsx
// Custom dropdown needs ARIA because there is no native equivalent
<div role="listbox" aria-label="Select job category" aria-activedescendant={activeId}>
  {options.map((opt) => (
    <div
      key={opt.id}
      id={opt.id}
      role="option"
      aria-selected={opt.id === selectedId}
    >
      {opt.label}
    </div>
  ))}
</div>
```

The first rule of ARIA: do not use ARIA if a native HTML element does the job.

### Keyboard Navigation Checklist

- [ ] All interactive elements reachable with Tab
- [ ] Focus order follows visual order (no positive `tabindex` values)
- [ ] Escape closes modals, dropdowns, and overlays
- [ ] Arrow keys navigate within composite widgets (tabs, menus, listboxes)
- [ ] Focus is trapped inside open modals
- [ ] Focus returns to the trigger element when a modal closes

### Screen Reader Testing

Test with real screen readers, not just automated tools.

| OS | Screen Reader | Browser |
|----|--------------|---------|
| macOS | VoiceOver | Safari |
| Windows | NVDA (free) | Firefox or Chrome |
| Windows | JAWS | Chrome |
| iOS | VoiceOver | Safari |
| Android | TalkBack | Chrome |

### Color Contrast

- Normal text: minimum 4.5:1 contrast ratio against background.
- Large text (18px bold or 24px regular): minimum 3:1.
- UI components and graphical objects: minimum 3:1.
- Never convey information through color alone -- pair with icons, patterns, or text.

## Performance

### Core Web Vitals Targets

| Metric | What It Measures | Good | Needs Work | Poor |
|--------|-----------------|------|-----------|------|
| **LCP** (Largest Contentful Paint) | Loading speed | < 2.5s | 2.5-4s | > 4s |
| **INP** (Interaction to Next Paint) | Responsiveness | < 200ms | 200-500ms | > 500ms |
| **CLS** (Cumulative Layout Shift) | Visual stability | < 0.1 | 0.1-0.25 | > 0.25 |

### Image Optimization

```tsx
// Next.js Image component handles format, sizing, and lazy loading
import Image from "next/image";

<Image
  src="/hero.jpg"
  alt="AI developer working on a laptop"
  width={1200}
  height={630}
  priority                    // above-the-fold: skip lazy loading
  sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw, 1200px"
/>
```

- Use `WebP` or `AVIF` formats -- 25-50% smaller than JPEG at equivalent quality.
- Always set explicit `width` and `height` (or `aspect-ratio` in CSS) to prevent CLS.
- Use `loading="lazy"` for below-the-fold images. Use `fetchpriority="high"` for hero images.

### Lazy Loading and Code Splitting

```tsx
// Route-level code splitting in Next.js App Router happens automatically.
// For component-level splitting:
import dynamic from "next/dynamic";

const HeavyChart = dynamic(() => import("@/components/HeavyChart"), {
  loading: () => <ChartSkeleton />,
  ssr: false,
});
```

```tsx
// React Server Components (RSC): heavy data fetching stays on the server
// app/jobs/page.tsx (Server Component by default in Next.js App Router)
export default async function JobsPage() {
  const jobs = await getJobs();       // runs on server, zero client JS
  return <JobList jobs={jobs} />;     // JobList can be a client component for interactivity
}
```

### Font Loading Strategy

Fonts are a top cause of layout shift and invisible text.

```css
/* Preload the critical font */
/* In <head>: <link rel="preload" href="/fonts/Inter.woff2" as="font" type="font/woff2" crossorigin /> */

@font-face {
  font-family: "Inter";
  src: url("/fonts/Inter.woff2") format("woff2");
  font-display: swap;          /* show fallback text immediately, swap when loaded */
  font-weight: 100 900;
  unicode-range: U+0000-00FF;  /* subset to Latin characters if appropriate */
}
```

- Use `font-display: swap` to prevent Flash of Invisible Text (FOIT).
- Subset fonts to only the character ranges you need.
- Self-host fonts instead of loading from Google Fonts to avoid extra DNS lookups.

## UX Patterns for Common Flows

### Forms

```tsx
// react-hook-form with field-level validation and accessible errors
function ApplyForm() {
  const { register, handleSubmit, formState: { errors } } = useForm<ApplyFormData>();

  return (
    <form onSubmit={handleSubmit(onSubmit)} noValidate>
      <div>
        <label htmlFor="name">Full Name</label>
        <input
          id="name"
          aria-describedby={errors.name ? "name-error" : undefined}
          aria-invalid={!!errors.name}
          {...register("name", { required: "Name is required" })}
        />
        {errors.name && (
          <p id="name-error" role="alert" className="text-sm text-red-600">
            {errors.name.message}
          </p>
        )}
      </div>
      <button type="submit">Apply</button>
    </form>
  );
}
```

Rules:
- Label every input. Placeholder text is not a label.
- Show validation errors inline, next to the field.
- Use `aria-invalid` and `aria-describedby` to connect errors to inputs.
- Disable submit buttons only while submitting -- not while the form is invalid.

### Navigation

- Sticky or fixed header on mobile -- but keep it thin (max 56px).
- Bottom navigation bar for primary actions on mobile apps.
- Breadcrumbs on desktop for deep content hierarchies.
- Always indicate the current page in navigation with `aria-current="page"`.

### Modals and Dialogs

```tsx
// Use the native <dialog> element when possible
function ConfirmDialog({ open, onClose, onConfirm, title, message }: Props) {
  const ref = useRef<HTMLDialogElement>(null);

  useEffect(() => {
    if (open) ref.current?.showModal();
    else ref.current?.close();
  }, [open]);

  return (
    <dialog ref={ref} onClose={onClose} className="rounded-xl p-6 backdrop:bg-black/50">
      <h2 className="text-lg font-semibold">{title}</h2>
      <p className="mt-2 text-gray-600">{message}</p>
      <div className="mt-4 flex justify-end gap-3">
        <button onClick={onClose}>Cancel</button>
        <button onClick={onConfirm} className="bg-primary-600 text-white rounded-lg px-4 py-2">
          Confirm
        </button>
      </div>
    </dialog>
  );
}
```

Rules:
- Trap focus inside the modal.
- Close on Escape key press.
- Return focus to the trigger element when the modal closes.
- Prevent background scroll while the modal is open.
- The native `<dialog>` element handles most of this automatically.

### Loading, Empty, and Error States

Every data-fetching view needs three states beyond the happy path:

| State | UX Pattern | Implementation |
|-------|-----------|----------------|
| **Loading** | Skeleton screens (not spinners) -- they reduce perceived load time | Render placeholder shapes matching the layout |
| **Empty** | Helpful message + primary action ("No jobs saved yet. Browse open roles.") | Check `data.length === 0` after loading completes |
| **Error** | Clear message + retry action ("Something went wrong. Try again.") | Catch at the boundary, show inline or toast |

```tsx
function JobList({ jobs, isLoading, error }: Props) {
  if (isLoading) return <JobListSkeleton count={6} />;
  if (error) return <ErrorState message="Failed to load jobs" onRetry={refetch} />;
  if (jobs.length === 0) return <EmptyState icon={<BriefcaseIcon />} message="No jobs found" action={<Link href="/explore">Explore roles</Link>} />;
  return <ul>{jobs.map(job => <JobCard key={job.id} job={job} />)}</ul>;
}
```

### Toasts and Notifications

- Auto-dismiss after 5 seconds for informational messages.
- Persist until dismissed for errors and actions.
- Use `role="status"` for informational toasts and `role="alert"` for errors.
- Position at the bottom on mobile, top-right on desktop.
- Stack multiple toasts vertically without overlapping content.

### Infinite Scroll vs Pagination

| Factor | Infinite Scroll | Pagination |
|--------|----------------|------------|
| Content discovery | Good for feeds and social content | Good for search results and catalogs |
| Back button behavior | Loses scroll position without extra work | Naturally bookmarkable |
| Accessibility | Harder -- announce new content to screen readers | Simpler -- standard navigation |
| Performance | Can degrade with thousands of DOM nodes | Constant DOM size |
| SEO | Requires special handling | Each page is independently indexable |

Recommendation: Use pagination for search results and job listings. Use infinite scroll only for social feeds, and virtualize the list with a library like `@tanstack/react-virtual`.

## Testing UI

### Visual Regression Testing

- Use Chromatic or Percy to capture screenshots on every PR.
- Storybook stories double as visual test cases -- one story per state (default, loading, error, empty, mobile, dark mode).
- Review visual diffs before merging.

### Component Testing

```tsx
// Vitest + Testing Library: test behavior, not implementation
import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { Button } from "./Button";

test("shows loading spinner and disables button when loading", async () => {
  render(<Button loading>Submit</Button>);
  expect(screen.getByRole("button")).toBeDisabled();
  expect(screen.getByRole("button")).toHaveAttribute("aria-busy", "true");
});

test("calls onClick when clicked", async () => {
  const onClick = vi.fn();
  render(<Button variant="primary" size="md" onClick={onClick}>Save</Button>);
  await userEvent.click(screen.getByRole("button", { name: "Save" }));
  expect(onClick).toHaveBeenCalledOnce();
});
```

### Accessibility Audits

Automated tools catch approximately 30-50% of accessibility issues. Use them as a baseline, not a finish line.

```bash
# Lighthouse CI in your pipeline
npx @lhci/cli autorun --collect.url=http://localhost:3000

# axe-core in tests
npm install --save-dev @axe-core/react   # runtime warnings in dev
npm install --save-dev jest-axe           # assertions in tests
```

```tsx
// axe-core in component tests
import { axe, toHaveNoViolations } from "jest-axe";
expect.extend(toHaveNoViolations);

test("form has no accessibility violations", async () => {
  const { container } = render(<ApplyForm />);
  const results = await axe(container);
  expect(results).toHaveNoViolations();
});
```

### Responsive Testing

- Test at 320px (small phone), 375px (standard phone), 768px (tablet), 1024px (small desktop), and 1440px (large desktop).
- Use Playwright's `page.setViewportSize()` to automate responsive checks.
- Test touch interactions on real devices -- emulators miss gesture nuances.

## Design Thinking Phase

Before writing code, commit to a bold aesthetic direction. Generic "AI slop" aesthetics — purple gradients on white, centered layouts, Inter/Roboto fonts — are the fastest way to make a project look like every other AI-generated site.

### Pre-Code Checklist

```
1. PURPOSE: What problem does this interface solve? Who uses it?
2. TONE: Pick a direction and commit — brutally minimal, maximalist,
   retro-futuristic, organic/natural, luxury/refined, editorial,
   brutalist/raw, art deco, soft/pastel, industrial, playful.
3. CONSTRAINTS: Framework, performance budget, accessibility level.
4. DIFFERENTIATOR: What's the one thing someone will remember?
```

Bold maximalism and refined minimalism both work. The key is intentionality, not intensity.

### Distinctive Typography

Choose fonts that have character. Pair a distinctive display font with a refined body font.

```
NEVER default to:
  Inter, Roboto, Arial, system-ui, sans-serif

INSTEAD choose fonts with personality:
  Display: Space Grotesk, Clash Display, Satoshi, Cabinet Grotesk,
           General Sans, Switzer, Zodiak, Gambetta
  Body: Outfit, Plus Jakarta Sans, DM Sans, Figtree, Geist

Pair a distinctive display font with a refined body font.
Vary choices between projects — never converge on the same pairing.
```

### Color & Theme Commitment

```css
/* Use CSS variables for consistency. Dominant color with sharp accent. */
:root {
  --color-dominant: #1a1a2e;   /* 60-70% visual weight */
  --color-support: #16213e;    /* supporting tone */
  --color-accent: #e94560;     /* sharp accent — used sparingly */
}
```

Dominant colors with sharp accents outperform timid, evenly-distributed palettes. Commit to a cohesive palette — do not spread colors equally.

### Motion & Micro-Interactions

```
High-impact moments over scattered effects:
  → One well-orchestrated page load with staggered reveals
    (animation-delay) creates more delight than random micro-interactions
  → Scroll-triggered reveals and hover states that surprise
  → Prefer CSS-only animations for HTML; use Motion (Framer Motion)
    for React when available
```

### Spatial Composition

Break out of predictable layouts: asymmetry, overlap, diagonal flow, grid-breaking elements, generous negative space OR controlled density. Unexpected layouts make interfaces memorable.

### Backgrounds & Visual Details

Create atmosphere and depth instead of defaulting to flat solid colors:

```
Consider: gradient meshes, noise textures, geometric patterns,
layered transparencies, dramatic shadows, decorative borders,
custom cursors, grain overlays.
Match the effect to the overall aesthetic — not every project
needs every technique.
```

## Anti-Patterns

| Anti-Pattern | Why It Hurts | Do This Instead |
|---|---|---|
| Div soup (`<div>` for everything) | No semantic meaning, broken screen reader experience, poor SEO | Use `<header>`, `<nav>`, `<main>`, `<section>`, `<article>`, `<button>`, `<a>` |
| Ignoring touch targets (32px buttons) | Mis-taps frustrate users, WCAG violation | Minimum 44x44px with 8px spacing between targets |
| Flash of Unstyled Text (FOUT/FOIT) | Layout shift, invisible text during load | `font-display: swap` + preload critical fonts + size-adjust fallback |
| Layout shift from images without dimensions | CLS penalty, visual jank | Always set `width`/`height` or `aspect-ratio` on images and media |
| Inaccessible modals (no focus trap) | Keyboard users get stuck, screen readers read background content | Use native `<dialog>`, trap focus, close on Escape, restore focus on close |
| CSS `!important` everywhere | Specificity wars, unmaintainable stylesheets | Fix the cascade: use layers, lower specificity selectors, or Tailwind utilities |
| Client-fetching data that could be server-rendered | Slower LCP, loading spinners, duplicated logic | Use React Server Components or `getServerSideProps` for initial data |
| Inline styles for responsive design | Cannot use media queries or container queries, duplicated values | Use utility classes (Tailwind) or CSS custom properties |
| Disabling zoom (`user-scalable=no`) | WCAG violation, excludes users with low vision | Remove it. Let users zoom. Design to accommodate zoomed-in layouts |
| Building custom components that already exist natively | Larger bundle, more bugs, worse accessibility | Use native `<select>`, `<details>`, `<dialog>`, `<input type="date">` first |

## Power Move

```prompt
"Audit this page for frontend quality. Check these dimensions and give me a scorecard with pass/fail and specific fixes:
1. Mobile responsiveness: test at 320px, 375px, 768px, 1024px
2. Touch targets: are all interactive elements at least 44x44px?
3. Accessibility: run axe-core, check heading hierarchy, verify keyboard navigation, test with VoiceOver
4. Performance: measure LCP, INP, CLS via Lighthouse -- flag anything outside 'Good' thresholds
5. Semantic HTML: identify any div-soup or missing landmarks
6. Loading states: does every async view handle loading, empty, and error?
7. Dark mode: does the color scheme respect prefers-color-scheme and maintain contrast ratios?
8. Image optimization: are images using modern formats, explicit dimensions, and lazy loading?
Prioritize fixes by user impact. Ship the top 3 fixes first."
```

The agent becomes your frontend quality gate -- accessibility, performance, and mobile experience validated before the PR merges.
