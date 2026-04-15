---
name: webapp-testing
description: Test web applications using Playwright — decision tree for static vs dynamic apps, reconnaissance-then-action pattern, server lifecycle management, and browser automation. Use when testing frontend functionality, debugging UI behavior, capturing screenshots, or automating browser interactions.
---

# Web Application Testing

## Core Principle

Never trust the DOM before the page is ready. Wait for network idle, then inspect, then act. Reconnaissance before action prevents flaky tests and wasted debugging.

## Decision Tree

```
Your task → Is it static HTML?
  ├─ Yes → Read the HTML file directly to identify selectors
  │         ├─ Found selectors → Write Playwright script using them
  │         └─ Incomplete/dynamic content → Treat as dynamic (below)
  │
  └─ No (dynamic webapp) → Is the server already running?
      ├─ No → Start the server first, then write Playwright script
      │
      └─ Yes → Reconnaissance-then-action:
          1. Navigate and wait for networkidle
          2. Take screenshot or inspect DOM
          3. Identify selectors from rendered state
          4. Execute actions with discovered selectors
```

## Playwright Fundamentals

### Setup

```bash
# Install Playwright
npm install -D @playwright/test
npx playwright install chromium
```

### Basic Script Pattern

```python
from playwright.sync_api import sync_playwright

with sync_playwright() as p:
    browser = p.chromium.launch(headless=True)  # Always headless in CI
    page = browser.new_page()
    page.goto('http://localhost:3000')
    page.wait_for_load_state('networkidle')  # CRITICAL: wait for JS
    # ... your test logic
    browser.close()
```

### Server Lifecycle Management

When your app isn't running yet, manage the server within your test:

```python
import subprocess
import time

# Start server
server = subprocess.Popen(
    ["npm", "run", "dev"],
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE
)

# Wait for server to be ready
time.sleep(5)  # or poll the health endpoint

# Run tests...

# Cleanup
server.terminate()
server.wait()
```

For Playwright Test runner (TypeScript):

```typescript
// playwright.config.ts
import { defineConfig } from '@playwright/test';

export default defineConfig({
  webServer: {
    command: 'npm run dev',
    port: 3000,
    reuseExistingServer: !process.env.CI,
  },
  use: {
    baseURL: 'http://localhost:3000',
  },
});
```

## Reconnaissance-Then-Action Pattern

The most important pattern for testing dynamic web apps. Never guess selectors — discover them from the live page.

### Step 1: Inspect the Rendered DOM

```python
# Take a screenshot to see what's actually rendered
page.screenshot(path='/tmp/inspect.png', full_page=True)

# Get the full rendered HTML
content = page.content()

# Discover all interactive elements
buttons = page.locator('button').all()
links = page.locator('a').all()
inputs = page.locator('input').all()

for btn in buttons:
    print(f"Button: {btn.text_content()} | visible: {btn.is_visible()}")
```

### Step 2: Identify Selectors

```
Prefer selectors in this order:
  1. role-based:  page.get_by_role("button", name="Submit")
  2. text-based:  page.get_by_text("Sign in")
  3. test IDs:    page.get_by_test_id("login-form")
  4. CSS:         page.locator(".submit-btn")
  5. XPath:       page.locator("//button[@type='submit']")  # last resort
```

### Step 3: Execute Actions

```python
# Click with auto-wait
page.get_by_role("button", name="Submit").click()

# Fill a form
page.get_by_label("Email").fill("user@example.com")
page.get_by_label("Password").fill("password123")

# Wait for navigation
page.wait_for_url("**/dashboard")

# Assert content
assert page.get_by_text("Welcome back").is_visible()
```

## Common Test Patterns

### Form Submission

```python
def test_login_form(page):
    page.goto("/login")
    page.get_by_label("Email").fill("test@example.com")
    page.get_by_label("Password").fill("password")
    page.get_by_role("button", name="Sign in").click()
    page.wait_for_url("**/dashboard")
    assert page.get_by_text("Welcome").is_visible()
```

### Visual Regression

```python
def test_homepage_visual(page):
    page.goto("/")
    page.wait_for_load_state("networkidle")
    page.screenshot(path="screenshots/homepage.png", full_page=True)
    # Compare with baseline using image diff tools
```

### Console Log Capture

```python
console_messages = []
page.on("console", lambda msg: console_messages.append(msg))

page.goto("/")
page.wait_for_load_state("networkidle")

errors = [m for m in console_messages if m.type == "error"]
assert len(errors) == 0, f"Console errors found: {errors}"
```

### Responsive Testing

```python
viewports = [
    {"width": 320, "height": 568, "name": "iPhone SE"},
    {"width": 768, "height": 1024, "name": "iPad"},
    {"width": 1440, "height": 900, "name": "Desktop"},
]

for vp in viewports:
    page.set_viewport_size({"width": vp["width"], "height": vp["height"]})
    page.goto("/")
    page.wait_for_load_state("networkidle")
    page.screenshot(path=f"screenshots/{vp['name']}.png")
```

## Anti-Patterns

| Anti-Pattern | Why It Hurts | Do This Instead |
|---|---|---|
| Inspecting DOM before networkidle | Gets stale/incomplete elements | Always `wait_for_load_state('networkidle')` first |
| Hardcoded selectors without verification | Selectors break when UI changes | Reconnaissance first, then act on discovered selectors |
| `time.sleep()` instead of proper waits | Slow and flaky | Use `wait_for_selector()`, `wait_for_url()`, or `wait_for_load_state()` |
| Running browser in headed mode in CI | Fails in headless environments | Always `headless=True` in CI; headed only for local debugging |
| No server lifecycle management | Tests fail because server isn't ready | Use Playwright's `webServer` config or health-check polling |
| Testing only the happy path | Misses real bugs | Test error states, empty states, loading states, edge cases |

## Power Move

"Write Playwright tests for [my web app]. Start with reconnaissance — screenshot the page, discover all interactive elements, then write tests for the 3 most critical user flows. Include responsive testing at mobile, tablet, and desktop breakpoints. Capture console errors and assert zero errors on every page."

The agent becomes your QA engineer — systematically testing every user flow and catching issues before users do.
