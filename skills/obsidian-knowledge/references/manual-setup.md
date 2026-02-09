# Manual Setup with npx

If you prefer not to use Docker Desktop, you can set up the Obsidian MCP server manually.

## Prerequisites

- Node.js v18 or higher
- Obsidian application installed
- Local REST API plugin enabled in Obsidian

## Step 1: Install Local REST API Plugin

1. Open Obsidian → Settings → Community plugins
2. Browse and search for "Local REST API"
3. Install and enable the plugin
4. Go to plugin settings and copy the API key

## Step 2: Configure MCP Client

Add the Obsidian server to your MCP client configuration.

### For Claude Code

Add to your Claude Code MCP settings:

```json
{
  "mcpServers": {
    "obsidian": {
      "command": "npx",
      "args": ["obsidian-mcp-server"],
      "env": {
        "OBSIDIAN_API_KEY": "your-api-key-here",
        "OBSIDIAN_BASE_URL": "http://127.0.0.1:27123",
        "OBSIDIAN_VERIFY_SSL": "false",
        "OBSIDIAN_ENABLE_CACHE": "true"
      }
    }
  }
}
```

### For Other MCP Clients

The configuration is similar - provide the command, args, and environment variables to your client's MCP settings.

## Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `OBSIDIAN_API_KEY` | API key from Local REST API plugin | Yes |
| `OBSIDIAN_BASE_URL` | REST API endpoint (default: `http://127.0.0.1:27123`) | Yes |
| `OBSIDIAN_VERIFY_SSL` | Set to `"false"` for local connections | No |
| `OBSIDIAN_ENABLE_CACHE` | Enable in-memory cache for performance | No |

## Quick Install via Smithery

For a one-liner installation:

```bash
npx @smithery/cli install mcp-obsidian --client claude
```

## Verify Connection

Once configured, test the connection by asking your AI assistant:

```
List all notes in my Obsidian vault
```

If successful, you'll see a list of your vault contents.
