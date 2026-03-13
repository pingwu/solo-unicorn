---
name: mcp-builder
description: Guide for creating MCP (Model Context Protocol) servers that enable LLMs to interact with external services through well-designed tools. Use when building MCP servers to integrate external APIs or services, whether in Python (FastMCP) or TypeScript (MCP SDK).
---

# MCP Server Builder

## Core Principle

The quality of an MCP server is measured by how well it enables LLMs to accomplish real-world tasks. Clear tool names, focused responses, and actionable error messages matter more than comprehensive API coverage.

## When to Build an MCP Server

```
BUILD when:
  → You need an AI agent to interact with an external API or service
  → You're wrapping a REST API, database, or file system for LLM access
  → You want to create reusable tool integrations for your workflow

DON'T BUILD when:
  → A simple function call or script would suffice
  → The API is already available through an existing MCP server
  → The integration is one-off and not worth the setup
```

## Four-Phase Process

### Phase 1: Research and Planning

**Study the MCP specification:**

```
Start here: https://modelcontextprotocol.io/sitemap.xml
Key pages (append .md for markdown):
  → Specification overview and architecture
  → Transport mechanisms (streamable HTTP, stdio)
  → Tool, resource, and prompt definitions
```

**Choose your stack:**

| Decision | Recommendation | Why |
|----------|---------------|-----|
| Language | TypeScript | Best SDK support, good AI code generation, static typing |
| Transport | Streamable HTTP (remote), stdio (local) | HTTP scales better; stdio is simpler for local tools |
| Schema validation | Zod (TS) or Pydantic (Python) | Type-safe input validation with clear error messages |

**Plan your tools:**

```
1. List the API endpoints you need to cover
2. Prioritize by frequency of use (most common operations first)
3. Choose between:
   - Comprehensive API coverage (flexibility for agents)
   - Workflow tools (convenience for specific tasks)
   - Usually: start with comprehensive, add workflows later
```

### Phase 2: Implementation

**Project structure (TypeScript):**

```
my-mcp-server/
├── src/
│   ├── index.ts          # Server entry point
│   ├── tools/            # Tool implementations
│   ├── utils/            # Shared utilities (auth, errors, formatting)
│   └── types.ts          # Shared type definitions
├── package.json
└── tsconfig.json
```

**Tool design principles:**

```
NAMING:
  → Use consistent prefixes: github_create_issue, github_list_repos
  → Action-oriented: create_, list_, get_, update_, delete_
  → Clear enough that an LLM can find the right tool from name alone

INPUT SCHEMA:
  → Use Zod (TS) or Pydantic (Python) for validation
  → Include constraints and descriptions on every field
  → Add examples in field descriptions

OUTPUT:
  → Return focused, relevant data — not raw API dumps
  → Support pagination for list operations
  → Use both text content and structured data when possible

ERRORS:
  → Messages must guide agents toward solutions
  → Include specific suggestions and next steps
  → "Repository not found. Check the owner/repo format (e.g., 'octocat/Hello-World')"
    not "404 Not Found"
```

**Tool annotations:**

```
For every tool, specify:
  readOnlyHint: true/false    — does it only read data?
  destructiveHint: true/false — can it delete or overwrite?
  idempotentHint: true/false  — safe to retry?
  openWorldHint: true/false   — interacts with external systems?
```

### Phase 3: Review and Test

```
Code quality checklist:
  - [ ] No duplicated code (DRY)
  - [ ] Consistent error handling across all tools
  - [ ] Full type coverage (no 'any' types)
  - [ ] Clear tool descriptions that LLMs can parse
  - [ ] Pagination support for list operations
  - [ ] Authentication handled centrally

Testing:
  TypeScript: npm run build → test with MCP Inspector
    npx @modelcontextprotocol/inspector

  Python: python -m py_compile your_server.py → MCP Inspector
```

### Phase 4: Evaluation

After implementing, create 10 evaluation questions to test whether LLMs can effectively use your server.

```
Each question must be:
  → Independent (not dependent on other questions)
  → Read-only (non-destructive operations only)
  → Complex (requires multiple tool calls)
  → Realistic (based on real use cases)
  → Verifiable (single, clear answer)
  → Stable (answer won't change over time)

Output format (XML):
  <evaluation>
    <qa_pair>
      <question>Your complex, realistic question here</question>
      <answer>The verifiable answer</answer>
    </qa_pair>
  </evaluation>
```

## SDK Quick Reference

### TypeScript

```typescript
import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { z } from "zod";

const server = new McpServer({ name: "my-server", version: "1.0.0" });

server.registerTool("my_tool", {
  description: "What this tool does",
  inputSchema: z.object({
    param: z.string().describe("Description of param"),
  }),
  annotations: { readOnlyHint: true },
}, async ({ param }) => {
  // Implementation
  return { content: [{ type: "text", text: "result" }] };
});
```

### Python (FastMCP)

```python
from mcp.server.fastmcp import FastMCP

mcp = FastMCP("my-server")

@mcp.tool()
async def my_tool(param: str) -> str:
    """What this tool does."""
    # Implementation
    return "result"
```

## Anti-Patterns

| Anti-Pattern | Why It Hurts | Do This Instead |
|---|---|---|
| Exposing raw API responses | LLMs drown in irrelevant data | Return focused, relevant fields only |
| Vague tool names (`do_thing`) | LLMs can't find the right tool | Action-oriented names with consistent prefixes |
| No error context | Agent retries blindly | Actionable error messages with suggestions |
| No pagination | Context window overflow on large datasets | Support limit/offset or cursor-based pagination |
| Hardcoded auth | Security risk, no portability | Environment variables or config files |
| One mega-tool that does everything | Agents struggle with complex input schemas | Small, focused tools that compose well |

## Power Move

"Build an MCP server that wraps [API/service]. Start with the 5 most common operations. Include Zod schemas for all inputs, actionable error messages, and pagination for list operations. Then create 10 evaluation questions to test whether an LLM can use the server to answer realistic questions."

The agent becomes your integration architect — designing tool interfaces that make LLMs genuinely useful with external services.
