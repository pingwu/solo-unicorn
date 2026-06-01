---
name: finance-accounting
description: Manage startup finances—burn rate analysis, runway calculations, cash flow forecasting, and monthly close templates with decision criteria for when to hire finance help. Use when tracking burn, projecting runway, building financial models, or setting up accounting processes.
---

# Finance & Accounting

## Core Principle

Cash is oxygen. You don't need perfect books — you need to know exactly when the money runs out and what levers you can pull.

## Burn Rate Analysis

### Gross vs. Net Burn

```
GROSS BURN = Total monthly expenses (all cash out the door)
NET BURN = Total expenses - Total revenue (actual cash drain)

Example:
  Monthly expenses: $80K
  Monthly revenue: $30K
  Gross burn: $80K
  Net burn: $50K

Track both. Gross burn shows cost structure. Net burn shows survival math.
```

### Burn Rate Breakdown Template

| Category | Monthly $ | % of Burn | Notes |
|----------|-----------|-----------|-------|
| Salaries & benefits | | | Largest line — typically 60-75% |
| Infrastructure (AWS, tools) | | | Should scale with revenue |
| Office / remote stipends | | | Fixed cost |
| Marketing & sales | | | Variable — should generate ROI |
| Legal & accounting | | | Often underestimated |
| Misc / buffer | | | 5-10% of total |
| **Total Gross Burn** | | 100% | |

## Runway Calculations

### Basic Runway

```
Runway (months) = Cash in bank / Net monthly burn

Example:
  Cash: $500K
  Net burn: $50K/mo
  Runway: 10 months
```

### Adjusted Runway (with growth)

```
If revenue is growing, runway is longer than simple division suggests.

Month 1: $500K - ($80K - $30K) = $450K
Month 2: $450K - ($80K - $33K) = $403K  (10% MoM revenue growth)
Month 3: $403K - ($80K - $36K) = $359K
...

Model month-by-month. The spreadsheet matters more than the formula.
```

### Runway Decision Triggers

```
12+ months: Comfortable. Focus on growth.
 9 months:  Start fundraising prep. Update deck and data room.
 6 months:  ACTIVELY fundraising or cutting costs. No other priority.
 3 months:  Emergency mode. Cut to essentials. Bridge or pivot.
```

## Cash Flow Forecasting

### 13-Week Cash Flow Template

```
Week | Starting Cash | Cash In | Cash Out | Ending Cash | Notes
-----|---------------|---------|----------|-------------|------
W1   | $500K         | $12K    | $18K     | $494K       |
W2   | $494K         | $8K     | $20K     | $482K       | Payroll
W3   | $482K         | $15K    | $12K     | $485K       |
W4   | $485K         | $10K    | $35K     | $460K       | Annual tool renewal
...
```

### Cash Flow Forecasting Rules

```
1. Revenue: Use conservative estimates (80% of expected)
2. Expenses: Use aggressive estimates (110% of expected)
3. Timing: Model when cash ACTUALLY moves, not when it's invoiced
4. Seasonality: Note months with unusual patterns (annual contracts, tax)
5. Update weekly: Forecasts are only useful if they're current
```

## Monthly Close Template

### Close Checklist (Target: Complete by 10th of following month)

```
WEEK 1 (Days 1-5):
  - [ ] Reconcile all bank accounts
  - [ ] Reconcile credit card statements
  - [ ] Categorize all transactions
  - [ ] Record revenue (recognized, not just invoiced)
  - [ ] Record payroll and benefits

WEEK 2 (Days 5-10):
  - [ ] Review accounts receivable aging
  - [ ] Reconcile accounts payable
  - [ ] Review prepaid expenses and amortization
  - [ ] Generate P&L, Balance Sheet, Cash Flow Statement
  - [ ] Compare actuals to budget — note variances > 10%
  - [ ] Update runway forecast
```

### Three Financial Statements to Know

```
P&L (Profit & Loss / Income Statement)
  → Are we making or losing money? How much?
  → Revenue - COGS = Gross Profit - OpEx = Net Income

Balance Sheet
  → What do we own (assets) vs. owe (liabilities)?
  → Assets = Liabilities + Equity

Cash Flow Statement
  → Where did cash actually go?
  → Operating + Investing + Financing = Net Cash Change
```

## When to Hire Finance Help

### Decision Matrix

| Stage | Action | When |
|-------|--------|------|
| Pre-seed / bootstrapping | Founder does books + QuickBooks | $0-$25K MRR |
| Seed | Bookkeeper (part-time or outsourced) | $25K-$100K MRR |
| Series A | Controller or outsourced CFO | $100K-$500K MRR |
| Series B+ | Full-time CFO | $500K+ MRR or complex financials |

### Signs You Need Help Now

```
- You're more than 2 months behind on reconciliation
- You can't answer "what's our burn rate?" in under 60 seconds
- You're preparing for fundraising and need clean financials
- You have more than 50 customers and complex invoicing
- Tax filing gives you anxiety because the books aren't ready
```

## Anti-Patterns

| Finance Theater | Real Finance |
|-----------------|--------------|
| "We'll figure out the books later" | Monthly close from month 1 |
| Checking bank balance = financial management | P&L + runway forecast updated monthly |
| Mixing personal and business accounts | Separate accounts from day 1 |
| Revenue = cash received | Revenue = value delivered (accrual accounting) |
| Ignoring burn until fundraising | Weekly burn awareness, monthly reporting |

## Power Move

"Build me a 13-week cash flow forecast based on [current cash, monthly revenue, monthly expenses]. Show me adjusted runway assuming [growth rate]. Flag the month I should start fundraising and identify the top 3 expenses I should cut if runway drops below 6 months."

The agent becomes your fractional CFO — turning financial uncertainty into clear decision points.
