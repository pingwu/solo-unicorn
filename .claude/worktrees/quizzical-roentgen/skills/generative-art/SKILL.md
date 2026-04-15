---
name: generative-art
description: Create algorithmic generative art using p5.js with seeded randomness, and static visual art using canvas design philosophy. Use when users request generative art, algorithmic art, flow fields, particle systems, posters, visual designs, or any code-driven creative visual output.
---

# Generative Art

## Core Principle

Beauty lives in the process, not the final frame. Generative art is about creating algorithms that produce visual output — each seed reveals a different facet of the same system. The goal is controlled chaos, not random noise.

## Two Modes

| Mode | Output | When to Use |
|------|--------|-------------|
| **Algorithmic Art** | Interactive HTML with p5.js | Animated or parameter-driven generative pieces |
| **Canvas Design** | Static PDF or PNG | Posters, visual designs, print-ready art |

## Algorithmic Art (p5.js)

### The Creative Process

```
1. PHILOSOPHY: Create an algorithmic philosophy (4-6 paragraphs)
   — Name the movement: "Organic Turbulence", "Quantum Harmonics"
   — Describe how it manifests through computation
   — Emphasize: process over product, parametric expression

2. IMPLEMENTATION: Express the philosophy in code
   — p5.js generative art with seeded randomness
   — Interactive parameters for exploration
   — Self-contained HTML artifact

3. REFINEMENT: Tune every parameter with care
   — Balance complexity without visual noise
   — Thoughtful color palettes, not random RGB
   — Same seed ALWAYS produces identical output
```

### Technical Requirements

**Seeded randomness (Art Blocks pattern):**

```javascript
let seed = 12345;
randomSeed(seed);
noiseSeed(seed);
```

**Parameter structure — driven by the philosophy:**

```javascript
let params = {
  seed: 12345,
  // Parameters emerge from the algorithm's needs:
  // quantities, scales, probabilities, ratios,
  // angles, thresholds, forces, decay rates
};
```

**Canvas setup:**

```javascript
function setup() {
  createCanvas(1200, 1200);
  // Initialize your system
}

function draw() {
  // Your generative algorithm
  // Can be static (noLoop) or animated
}
```

### Algorithmic Approaches

Let the philosophy dictate the approach. Don't pick from a menu — ask "how does this philosophy manifest through code?"

```
ORGANIC EMERGENCE:
  → Elements that accumulate or grow over time
  → Random processes constrained by natural rules
  → Feedback loops and interactions
  → Flow fields, particle systems, density maps

MATHEMATICAL BEAUTY:
  → Geometric relationships and ratios
  → Trigonometric functions and harmonics
  → Precise calculations creating unexpected patterns
  → Interference, resonance, golden ratios

CONTROLLED CHAOS:
  → Random variation within strict boundaries
  → Bifurcation and phase transitions
  → Order emerging from disorder
  → Noise fields, stochastic crystallization
```

### Craftsmanship Requirements

```
- BALANCE: Complexity without visual noise, order without rigidity
- COLOR HARMONY: Thoughtful palettes, not random RGB values
- COMPOSITION: Even in randomness, maintain visual hierarchy
- PERFORMANCE: Smooth execution, optimized for real-time if animated
- REPRODUCIBILITY: Same seed ALWAYS produces identical output
```

### Output Format

Single self-contained HTML file with:
- p5.js loaded from CDN
- All algorithm code inline
- Sidebar with seed navigation (prev/next/random/jump)
- Parameter sliders for tuning
- Regenerate, reset, and download buttons

## Canvas Design (Static Art)

### Design Philosophy Creation

```
1. NAME the movement (1-2 words)
2. ARTICULATE the philosophy (4-6 paragraphs):
   → Space and form
   → Color and material
   → Scale and rhythm
   → Composition and balance
   → Visual hierarchy
3. EMPHASIZE craftsmanship — the final work must look
   meticulously crafted, labored over with care
```

### Visual Principles

```
TEXT AS VISUAL ELEMENT:
  → Minimal, design-forward, never lengthy
  → Information lives in design, not paragraphs
  → Vary font sizes dramatically for hierarchy
  → Use different fonts for different roles

COMPOSITION:
  → Repeating patterns and perfect shapes
  → Dense accumulation of marks that reward sustained viewing
  → Sparse clinical typography as systematic reference markers
  → Limited color palette that feels intentional

CRAFT:
  → Nothing overlaps accidentally
  → Nothing falls off the page
  → Every element has breathing room
  → Formatting is flawless — every detail perfect
```

### Output Format

Single PDF or PNG file alongside the design philosophy as a `.md` file.

## Anti-Patterns

| Anti-Pattern | Why It Hurts | Do This Instead |
|---|---|---|
| Random RGB colors | Garish, incoherent palette | Curated palettes with intentional harmony |
| Copying existing generative artists | Copyright risk, no originality | Create original algorithmic philosophies |
| Static images with sprinkled randomness | Not generative art — just noisy decoration | Algorithms where beauty emerges from the process |
| No seeded randomness | Can't reproduce or share specific outputs | Always seed `randomSeed()` and `noiseSeed()` |
| Generic AI aesthetics (purple gradients, Inter font) | Looks like every other AI output | Bold, distinctive choices that feel human-crafted |
| Over-decorating instead of refining | Busy and unfocused | Refine what exists, don't add more elements |

## Power Move

"Create a generative art piece inspired by [concept/theme]. Write the algorithmic philosophy first, then implement it as an interactive p5.js artifact with seeded randomness. Include parameter controls so I can explore variations. Make it gallery-quality — something that looks like it took a master craftsman countless hours to develop."

The agent becomes your creative partner — translating concepts into living algorithms that produce art through computation.
