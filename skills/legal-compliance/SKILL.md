---
name: legal-compliance
description: Navigate startup legal fundamentals—entity selection, founder agreements, vesting schedules, ESOP, SAFEs, and cap table management. The goal isn't to replace lawyers but to help founders know what questions to ask. Use when forming a company, structuring equity, raising on SAFEs, or setting up option pools.
---

# Legal & Compliance

## Core Principle

Legal isn't a cost center — it's risk management. The goal isn't to replace lawyers. It's to walk into the room knowing exactly what questions to ask and what answers to expect.

## Entity Selection

### Common Structures

| Entity Type | Best For | Tax Treatment | Fundraising |
|-------------|----------|---------------|-------------|
| Delaware C-Corp | VC-backed startups | Corporate tax (double taxation) | Standard — VCs require it |
| LLC | Bootstrapped, consulting, real estate | Pass-through (flexible) | Harder to raise VC |
| S-Corp | Small businesses with profits | Pass-through (salary + distributions) | Not suitable for VC |
| B-Corp | Mission-driven companies | Same as C-Corp | Compatible with impact investors |

### Why Delaware C-Corp for VC-Track Startups

```
1. VCs expect it — their legal docs are built for Delaware C-Corps
2. Established case law — predictable legal outcomes
3. Stock classes — can issue preferred shares for investors
4. 83(b) election compatible — founders can minimize tax on vesting shares
5. Franchise tax is manageable — don't let it surprise you though
```

### Questions to Ask Your Lawyer

```
- "Should we incorporate in Delaware even though we operate in [state]?"
- "Do we need to register as a foreign corporation in our operating state?"
- "What's the cost difference between C-Corp and LLC for our situation?"
- "When does entity choice actually matter vs. when can we convert later?"
```

## Founder Agreements

### Critical Terms

| Term | What It Covers | Why It Matters |
|------|---------------|----------------|
| Equity split | Who owns what percentage | Must be explicit from day 1 |
| Vesting schedule | How equity is earned over time | Protects against early departures |
| IP assignment | Who owns what's built | Company must own the IP, not founders |
| Roles & responsibilities | Who does what | Prevents confusion and conflict |
| Decision-making | How decisions/deadlocks are resolved | Voting rights, tie-breakers |
| Departure terms | What happens when someone leaves | Buyback rights, non-compete |

### Vesting Schedules

```
Standard: 4-year vest with 1-year cliff

Timeline:
  Month 0:   0% vested (clock starts)
  Month 12:  25% vested (cliff — first chunk)
  Month 13+: ~2.08% per month (monthly vesting)
  Month 48:  100% vested

Example: Founder with 40% equity
  At cliff (12 months): 10% vested
  At month 24: 20% vested
  At month 48: 40% fully vested
```

### 83(b) Election — Don't Forget This

```
CRITICAL: File within 30 days of receiving restricted stock.

What it does: You pay tax on the stock's value TODAY (usually near $0)
             instead of paying tax when it vests (potentially much higher).

Miss the deadline? You owe income tax on each vesting event
                    at the fair market value at that time.

Action: File with IRS within 30 days. Keep proof. Tell your lawyer.
```

## ESOP (Employee Stock Option Pool)

### Standard Terms

```
Pool size: 10-20% of fully diluted shares (typically set pre-fundraise)
Vesting: 4-year vest, 1-year cliff (same as founders)
Strike price: 409A valuation (usually 25-35% of preferred share price)
Exercise window: 90 days after departure (standard but negotiate)
```

### Option Grant Guidelines

| Role Level | Equity Range (% of pool) | Notes |
|------------|--------------------------|-------|
| VP / C-level (early) | 1-5% | Depends on stage and cash comp |
| Director | 0.5-1.5% | |
| Senior engineer | 0.25-0.75% | |
| Junior hire | 0.05-0.25% | |

### Questions Employees Should Ask

```
- "How many total shares outstanding?" (to calculate actual %)
- "What's the current 409A valuation / strike price?"
- "What happens to my options if the company is acquired?"
- "Is there a post-termination exercise window beyond 90 days?"
- "When is the next 409A valuation scheduled?"
```

## SAFEs (Simple Agreement for Future Equity)

### SAFE Terms Explained

```
Valuation Cap: Maximum valuation at which your SAFE converts to equity
  → Lower cap = better deal for investor

Discount: Percentage discount on the next round's price
  → Typical: 15-25%

Most Favored Nation (MFN): If you issue a SAFE with better terms later,
  → Earlier investors get upgraded to the better terms

Pro-rata rights: Right to invest in future rounds to maintain ownership %
```

### SAFE vs. Convertible Note

| Feature | SAFE | Convertible Note |
|---------|------|-------------------|
| Debt? | No | Yes (accrues interest) |
| Maturity date? | No | Yes (triggers repayment) |
| Interest? | No | Yes (typically 2-8%) |
| Complexity | Simple | More complex |
| YC standard? | Yes | No |
| Best for | Pre-seed, seed | Bridge rounds |

### Common SAFE Scenarios

```
Post-money SAFE at $10M cap, raising $1M:
  Investor owns: $1M / ($10M) = 10% (post-money, so dilution is clear)

Pre-money SAFE at $8M cap, raising $1M:
  Investor owns: $1M / ($8M + $1M) = 11.1% (pre-money, so math is less predictable)

YC standard: Post-money SAFEs (since 2018) — makes dilution transparent.
```

## Cap Table Management

### What to Track

```
Shareholder     | Shares    | Type      | % Ownership | Vesting Status
----------------|-----------|-----------|-------------|---------------
Founder A       | 4,000,000 | Common    | 40%         | 24/48 months
Founder B       | 3,000,000 | Common    | 30%         | 24/48 months
ESOP Pool       | 1,500,000 | Reserved  | 15%         | —
Seed Investor   | 1,000,000 | Preferred | 10%         | Fully vested
Angel Investor  |   500,000 | SAFE      | 5%          | Converts at Series A
----------------|-----------|-----------|-------------|
Total           | 10,000,000|           | 100%        |
```

### Cap Table Rules

```
1. Keep it updated after EVERY transaction (grant, exercise, transfer)
2. Model dilution BEFORE agreeing to new rounds
3. Understand fully-diluted vs. issued-and-outstanding
4. Use software (Carta, Pulley, Captable.io) — spreadsheets break at scale
5. Your lawyer should review before every financing event
```

## Anti-Patterns

| Legal Theater | Real Legal Thinking |
|---------------|---------------------|
| "We'll figure out equity later" | Founder agreement signed before writing code |
| Skipping 83(b) election | Filed within 30 days, proof kept |
| "We don't need a lawyer yet" | Lawyer for incorporation and first financing |
| Cap table in a spreadsheet at Series A | Carta or equivalent from seed stage |
| Not understanding your own SAFE terms | Can explain cap, discount, and conversion math |
| Equal equity split "because it's fair" | Equity reflects contribution, role, and risk |

## Power Move

"Walk me through the legal setup for a new startup: entity selection rationale, founder agreement terms with vesting, ESOP pool sizing, and a cap table model showing dilution through a $2M seed round on a post-money SAFE. Then list the 5 questions I should ask my lawyer before signing anything."

The agent becomes your legal prep partner — not replacing counsel but ensuring you arrive informed and ask the right questions.
