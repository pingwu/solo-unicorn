---
name: test-first-development
description: Write tests before code using BDD or TDD approaches. Use BDD (Gherkin) when cross-functional alignment matters, TDD when you're a solo/small dev team. Covers acceptance criteria, step definitions, refactoring safety nets, and outside-in development.
---

# Test-First Development

## Core Principle

Define the behavior before you write the code. Tests are specifications in executable form — whether written in Gherkin for stakeholder collaboration or in Jest for developer speed.

## Choose Your Approach

| Question | BDD (Gherkin) | TDD (Tests as Specs) |
|----------|--------------|---------------------|
| **Who writes the specs?** | Business + dev + QA together | Developer alone or small team |
| **Format?** | Natural language `.feature` files | Test files (Jest, Vitest, pytest) |
| **Best when?** | Cross-functional alignment matters | Clear requirements, fast iteration |
| **Overhead?** | Higher (meetings, Gherkin tooling) | Lower (just tests) |
| **Audience?** | Non-technical stakeholders can read specs | Developers only |

**Rule of thumb**: If a product manager or client needs to validate the spec, use BDD. If you're building from clear requirements and need speed, use TDD.

---

## TDD: Tests as Specifications

### The Inversion Pattern

```
❌ Traditional: "Build a shopping cart" → code → "now write tests"

✅ Inverted: "Write tests for a shopping cart that can add items, remove items,
   calculate totals with tax, and apply discount codes" → tests → implement to pass
```

### Acceptance Criteria as Test Specs

Transform requirements into testable assertions:

| Requirement | Test Specification |
|-------------|-------------------|
| "Users can log in" | "Valid credentials return JWT; invalid credentials return 401; locked accounts return 403" |
| "Fast page load" | "Homepage renders in <2s; API responds in <200ms" |
| "Handle errors gracefully" | "Network failure shows retry button; invalid input shows field-specific message" |

### TDD Prompt Patterns

**Feature Development:**
```
"Write Jest tests for a password reset flow:
- Requesting reset with valid email sends token
- Requesting reset with unknown email returns same success (no enumeration)
- Valid token within 1hr allows password change
- Expired token returns 410
- Used token cannot be reused

Then implement the resetPassword service to pass all tests."
```

**Refactoring Safety Net:**
```
"Before refactoring the payment processor:
1. Write tests capturing current behavior for all edge cases
2. Verify tests pass with existing code
3. Refactor
4. Verify tests still pass"
```

### When to Use TDD

- ✅ Clear business rules exist
- ✅ Multiple edge cases need handling
- ✅ Code will be maintained long-term
- ✅ Refactoring existing functionality
- ⚠️ Skip for throwaway prototypes

---

## BDD: Behavior-Driven Development

### The BDD Workflow

BDD is a collaborative process following the "Define, Develop, Test" cycle.

#### Step 1: Define Behavior with Gherkin

Translate feature ideas into `.feature` files collaboratively.

**Example Prompt:** "I need to build a shopping cart feature. A user should be able to add items, view the cart, and see the total price. Create a feature file for this."

```gherkin
Feature: Shopping Cart
  As a shopper
  I want to manage items in my cart
  So that I can purchase what I need.

  Scenario: Add item to empty cart
    Given I am on the product page for "Wireless Mouse"
    When I click the "Add to Cart" button
    Then the cart count should be 1
    And I should see "Wireless Mouse" in my cart

  Scenario Outline: Login with various roles
    Given I am a registered user with the role "<role>"
    When I log in
    Then I should be granted access to the "<page>"

    Examples:
      | role    | page        |
      | admin   | /admin      |
      | editor  | /editor     |
      | viewer  | /dashboard  |
```

**Reference:** See [gherkin-cheatsheet.md](references/gherkin-cheatsheet.md) for full Gherkin syntax.

#### Step 2: Generate Step Definitions

Provide a `.feature` file and your testing framework. The agent generates boilerplate step definitions.

```javascript
// Generated stubs for Jest/Playwright
import { Given, When, Then } from '@cucumber/cucumber';
import { expect } from '@playwright/test';

Given('I am on the product page for {string}', async function (product) {
  await this.page.goto(`/products/${product}`);
});

When('I click the {string} button', async function (buttonText) {
  await this.page.click(`button:text("${buttonText}")`);
});

Then('the cart count should be {int}', async function (count) {
  const cartCount = await this.page.textContent('.cart-count');
  expect(parseInt(cartCount)).toBe(count);
});
```

#### Step 3: Implement Outside-In

Run the tests (they fail). Write the application code to make them pass. Every piece of code is directly tied to a user-facing behavior.

### The Three Amigos

BDD works best when three perspectives collaborate before development:

| Role | Focus | Question |
|------|-------|----------|
| **Business** (PM/BA) | Value and scope | "What problem are we solving?" |
| **Development** (Engineer) | Feasibility | "How can we build this?" |
| **Testing** (QA) | Edge cases | "What if the user does something unexpected?" |

The output of a Three Amigos session is one or more `.feature` files that everyone agrees on.

### Ubiquitous Language

Use the same terms across business conversations, Gherkin files, and code. When a PM says "customer," the developer implements a `Customer` class, and the tester writes tests for a "customer" — all referring to the exact same concept.

**Reference:** See [bdd-concepts.md](references/bdd-concepts.md) for deeper coverage.

---

## Anti-Patterns

| Anti-Pattern | Why It Hurts | Do This Instead |
|--------------|-------------|-----------------|
| Writing tests after code | Tests confirm what you built, not what you should build | Write tests first — they're your spec |
| Gherkin for solo dev work | Overhead without collaboration benefit | Use plain test files (Jest/Vitest) |
| Vague scenarios ("it works") | Untestable, no clear pass/fail | Specify exact inputs and expected outputs |
| Testing implementation details | Tests break on refactor | Test behavior and outcomes, not internals |
| Skipping edge cases in specs | Bugs hide in unspecified behavior | Ask "what if?" for every scenario |
| BDD without the "Three Amigos" | Gherkin becomes developer-only docs | Involve business and QA in spec writing |

## Power Move

**TDD Power Move:**
```
"Write the tests, show me for approval, THEN implement.
I want to validate the spec before you write production code."
```

**BDD Power Move:**
```
"I'm the business analyst. Our feature needs to do X.
The developer is concerned about Y. The tester is worried about Z.
Synthesize this into a Gherkin feature file that addresses all three perspectives.
Then generate step definitions and implement outside-in."
```

You become the QA gatekeeper. The agent handles both specification and implementation.
