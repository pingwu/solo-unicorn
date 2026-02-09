---
name: obsidian-knowledge
description: Manage your Obsidian knowledge vault through MCP (Model Context Protocol). Read, write, search notes, manage tags and frontmatter, and track relationships between ideas.
---

# Obsidian Knowledge Manager

This skill enables AI agents to interact with your Obsidian vault for knowledge management, memory tracking, and relationship mapping between notes.

## Core Principle

"Your knowledge vault is your second brain. Let AI help you capture, connect, and retrieve insights across your personal knowledge base."

## When to Use This Skill

Use this skill when you need to:
* Search your knowledge vault for relevant notes and insights
* Create or update notes with new learnings
* Manage tags and frontmatter metadata
* Find connections between ideas across your vault
* Track relationships between people, projects, and concepts
* Build a personal knowledge graph with AI assistance

## Prerequisites

Choose one of these setup methods:

### Option 1: Docker Desktop MCP Toolkit (Recommended)

The fastest way to get started:

1. Open Docker Desktop → Settings → Beta features
2. Enable "Docker MCP Toolkit" and apply changes
3. Go to MCP Toolkit → Catalog tab
4. Search for "Obsidian" and click the plus icon to add it
5. In Obsidian, install the "Local REST API" community plugin
6. Copy the API key from the plugin settings
7. In Docker Desktop, configure the Obsidian server with your API key

### Option 2: Manual Setup with npx

See [MANUAL-SETUP.md](references/manual-setup.md) for detailed instructions.

## Available Tools

The Obsidian MCP server provides these capabilities:

| Tool | Purpose |
|------|---------|
| `obsidian_read_note` | Read note content and metadata |
| `obsidian_update_note` | Append, prepend, or overwrite notes |
| `obsidian_search_replace` | Find and replace within a note |
| `obsidian_global_search` | Search entire vault with text/regex |
| `obsidian_list_notes` | List notes and directories |
| `obsidian_manage_frontmatter` | Get, set, or delete YAML metadata |
| `obsidian_manage_tags` | Add, remove, or list tags |
| `obsidian_delete_note` | Remove files from vault |

**Reference:** See [MCP-TOOLS.md](references/mcp-tools.md) for detailed tool usage.

## Knowledge Management Workflows

### 1. Capturing Ideas

When you have a new insight or learning:

```
Create a note in my vault at ideas/new-idea.md with the content...
```

### 2. Finding Connections

Search for related concepts across your vault:

```
Search my vault for notes mentioning "machine learning" and "product development"
```

### 3. Tracking Relationships

Use frontmatter to link related notes:

```yaml
---
related:
  - people/john-smith.md
  - projects/ai-incubator.md
tags:
  - insight
  - collaboration
---
```

### 4. Daily Reflections

Append to daily notes:

```
Append today's learnings to my daily note...
```

**Reference:** See [WORKFLOWS.md](references/workflows.md) for more examples.

## Vault Structure for Knowledge Management

Recommended folder structure for the Unicorn personal_knowledge vault:

```
personal_knowledge/
├── daily/           # Daily notes and reflections
├── ideas/           # Captured insights and inventions
├── people/          # Relationship notes
├── projects/        # Project-specific knowledge
├── learning/        # Study notes and courses
├── news/            # Industry news and trends
└── templates/       # Note templates
```

## Power Move

"Use frontmatter `related` fields and consistent tagging to build a knowledge graph. Ask the AI to find notes with shared tags or related links to discover unexpected connections between ideas."

## Troubleshooting

* **Connection refused:** Ensure Obsidian is running with Local REST API plugin enabled
* **Authentication error:** Verify your API key matches the plugin settings
* **Note not found:** Check the file path is relative to vault root (no leading slash)
* **Docker MCP not showing:** Enable Beta features in Docker Desktop settings

## Sources

- [Docker MCP Catalog and Toolkit](https://docs.docker.com/ai/mcp-catalog-and-toolkit/)
- [cyanheads/obsidian-mcp-server](https://github.com/cyanheads/obsidian-mcp-server)
- [Docker MCP Toolkit Blog](https://www.docker.com/blog/mcp-toolkit-mcp-servers-that-just-work/)
