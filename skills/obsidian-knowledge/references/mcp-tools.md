# Obsidian MCP Tools Reference

Detailed reference for all available MCP tools for Obsidian vault management.

## obsidian_read_note

Retrieves note content and metadata.

**Parameters:**
- `path` - Path to the note (relative to vault root)
- `format` - Output format: `markdown` or `json`

**Example:**
```
Read the note at ideas/product-concept.md
```

**Returns:** Note content, frontmatter, and metadata.

---

## obsidian_update_note

Modifies note content via append, prepend, or overwrite.

**Parameters:**
- `path` - Path to the note
- `content` - New content to add
- `operation` - One of: `append`, `prepend`, `overwrite`

**Examples:**
```
Append "## New Section\nContent here" to daily/2025-02-09.md
```

```
Overwrite the note at drafts/temp.md with new content
```

---

## obsidian_search_replace

Find and replace text within a specific note.

**Parameters:**
- `path` - Path to the note
- `search` - Text or regex pattern to find
- `replace` - Replacement text
- `regex` - Boolean, use regex matching

**Example:**
```
Replace all instances of "TODO" with "DONE" in projects/active.md
```

---

## obsidian_global_search

Search the entire vault with text or regex patterns.

**Parameters:**
- `query` - Search text or regex pattern
- `path_filter` - Limit search to specific folders
- `regex` - Boolean, use regex matching
- `limit` - Maximum results to return
- `offset` - Pagination offset

**Examples:**
```
Search for "machine learning" in my vault
```

```
Search for notes containing "meeting" in the daily/ folder
```

---

## obsidian_list_notes

List notes and subdirectories in a folder.

**Parameters:**
- `path` - Directory path to list (defaults to vault root)
- `extensions` - Filter by file extensions (e.g., `["md"]`)
- `regex` - Filter filenames by pattern

**Examples:**
```
List all notes in the ideas/ folder
```

```
List all markdown files in projects/
```

---

## obsidian_manage_frontmatter

Get, set, or delete YAML frontmatter keys.

**Parameters:**
- `path` - Path to the note
- `operation` - One of: `get`, `set`, `delete`
- `key` - Frontmatter key name
- `value` - Value to set (for set operation)

**Examples:**
```
Set the frontmatter key "status" to "active" in projects/unicorn.md
```

```
Get all frontmatter from people/john.md
```

```
Delete the "draft" key from ideas/concept.md
```

---

## obsidian_manage_tags

Add, remove, or list tags in notes.

**Parameters:**
- `path` - Path to the note
- `operation` - One of: `add`, `remove`, `list`
- `tag` - Tag name (without #)

**Examples:**
```
Add the tag "insight" to ideas/new-idea.md
```

```
List all tags in learning/ai-course.md
```

```
Remove the tag "draft" from projects/launched.md
```

---

## obsidian_delete_note

Permanently removes a file from the vault.

**Parameters:**
- `path` - Path to the note to delete

**Example:**
```
Delete the note at drafts/old-draft.md
```

**Warning:** This operation is permanent. Use with caution.

---

## Best Practices

1. **Use descriptive paths:** Organize notes in meaningful folders
2. **Leverage frontmatter:** Store structured metadata for easy querying
3. **Tag consistently:** Use a consistent tagging system across notes
4. **Search before creating:** Check if a related note already exists
5. **Link related notes:** Use the `related` frontmatter field to track connections
