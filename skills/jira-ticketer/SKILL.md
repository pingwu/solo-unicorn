---
name: jira-ticketer
description: Create, update, close, and report on Jira tickets. Reads JIRA_URL and JIRA_TOKEN from environment variables or .env file. Provides comprehensive guidance for Jira ticket lifecycle management, API integration, and automation workflows.
---

# Jira Ticketer Skill

Comprehensive skill for managing Jira tickets programmatically through the Jira REST API. Covers ticket creation, updates, closure, reporting, and automation workflows.

## Core Principle

"Streamline Jira ticket management through programmatic access, enabling seamless integration with development workflows, automated reporting, and batch operations."

## When to Use This Skill

Use this skill when you need to:
- Create new Jira tickets programmatically
- Update existing tickets (status, fields, descriptions, assignees)
- Close or resolve tickets
- Generate reports on ticket status, metrics, and progress
- Automate Jira workflows
- Query and filter tickets
- Manage ticket transitions and workflows
- Integrate Jira with other systems

## Configuration

### Environment Variables

The skill reads the following environment variables:

**Required:**
- **JIRA_URL**: Your Jira instance URL (e.g., `https://your-domain.atlassian.net`)
- **JIRA_TOKEN**: Your Jira API token (see [Authentication](#authentication) below)
- **JIRA_USERNAME**: Your Jira email address (needed for basic auth)

**Optional (Defaults):**
- **JIRA_DEFAULT_PROJECT_KEY**: Default project key for ticket creation (e.g., `CM`, `DEV`)
- **JIRA_DEFAULT_ISSUE_TYPE**: Default issue type for new tickets (e.g., `Task`, `Bug`, `Story`)

### Finding Your .env File

The skill will search for `.env` in this order:
1. `skills/.env` (in the skills directory)
2. `.env` (in the current working directory)
3. Environment variables already set in your shell

### Creating a .env File

Create a `.env` file in your project root or skills directory:

```bash
# Required
JIRA_URL=https://your-domain.atlassian.net
JIRA_TOKEN=your_api_token_here
JIRA_USERNAME=your_email@domain.com

# Optional - Defaults for ticket creation
JIRA_DEFAULT_PROJECT_KEY=CM
JIRA_DEFAULT_ISSUE_TYPE=Task
```

**⚠️ IMPORTANT:** Never commit `.env` files with real credentials to version control. Add `.env` to your `.gitignore`.

## Authentication

### API Token (Recommended)

1. Go to [Atlassian Account Settings](https://id.atlassian.com/manage-profile/security/api-tokens)
2. Click "Create API token"
3. Copy the token and add it to your `.env` file
4. Use the token with your email address for basic authentication

### Basic Auth

The Jira REST API accepts HTTP Basic Authentication:

```
Authorization: Basic base64(email:token)
```

The skill automatically handles encoding when you provide `JIRA_USERNAME` and `JIRA_TOKEN`.

## Key Concepts

- **Jira Project Key**: Unique identifier for a project (e.g., `PROJ`, `DEV`)
- **Issue Type**: Category of work (Bug, Task, Story, Epic, etc.)
- **Status**: Current state (To Do, In Progress, Done, etc.)
- **Fields**: Customizable data on tickets (assignee, priority, labels, etc.)
- **Transitions**: Valid state changes (e.g., In Progress → Review)

## API Endpoint Structure

All API calls use the Jira REST API v3 endpoint: `/rest/api/3/`

### Base URL Format

```
https://your-domain.atlassian.net/rest/api/3/[endpoint]
```

### Common Endpoints

| Operation | Method | Endpoint |
|-----------|--------|----------|
| Create ticket | POST | `/rest/api/3/issue` |
| Get ticket | GET | `/rest/api/3/issue/{key}` |
| Update ticket | PUT | `/rest/api/3/issue/{key}` |
| List transitions | GET | `/rest/api/3/issue/{key}/transitions` |
| Transition ticket | POST | `/rest/api/3/issue/{key}/transitions` |
| Add comment | POST | `/rest/api/3/issue/{key}/comment` |
| Search (JQL) | GET | `/rest/api/3/search/jql` |
| List projects | GET | `/rest/api/3/project` |

### Example Request

```bash
# Load environment variables from .env file
export $(cat .env | xargs)

curl -X POST \
  -H "Authorization: Basic $(echo -n "$JIRA_USERNAME:$JIRA_TOKEN" | base64)" \
  -H "Content-Type: application/json" \
  -d '{"fields": {...}}' \
  "$JIRA_URL/rest/api/3/issue"
```

**Environment Variables Used** (from `.env` file):
- `$JIRA_URL`: Your Jira instance URL (e.g., `https://mycompany.atlassian.net`)
- `$JIRA_USERNAME`: Your Jira email address
- `$JIRA_TOKEN`: Your Jira API token

See [Configuration](#configuration) section for `.env` setup details.

## Using Default Values

When `JIRA_DEFAULT_PROJECT_KEY` and `JIRA_DEFAULT_ISSUE_TYPE` are set in your `.env` file, they will be used automatically when creating tickets:

```bash
# With defaults in .env
jira-ticketer create "test" "description after test delete me"
# Uses: Project=CM, Type=Task (from .env)

# Override defaults by providing explicit values
jira-ticketer create --project PROJ --type Bug "test" "description"
```

This is especially useful for recurring tasks in a single project, eliminating the need to specify project and type every time.

## Workflows

### 1. Ticket Creation

Create new tickets with required and optional fields.

**Reference:** See [TICKET-CREATION.md](references/ticket-creation.md) for detailed examples and field mappings.

### 2. Ticket Updates

Modify existing tickets: status changes, field updates, comments, attachments.

**Reference:** See [TICKET-UPDATES.md](references/ticket-updates.md) for update operations and bulk updates.

### 3. Ticket Closure & Transitions

Move tickets through workflow states and resolve them.

**Reference:** See [TICKET-TRANSITIONS.md](references/ticket-transitions.md) for transition workflows and resolution options.

### 4. Reporting & Querying

Query tickets using JQL (Jira Query Language), generate reports, and analyze metrics.

**Reference:** See [REPORTING-QUERIES.md](references/reporting-queries.md) for JQL syntax and common reports.

## Common Workflows

### Workflow: Create and Track a Bug

1. Create a bug ticket with description and priority
2. Assign to team member
3. Add labels and components
4. Monitor progress through status updates
5. Generate report when resolved

See examples in [TICKET-CREATION.md](references/ticket-creation.md#create-a-bug-ticket).

### Workflow: Bulk Update Sprint Tickets

1. Query all tickets in current sprint
2. Update status or fields for multiple tickets
3. Generate sprint report
4. Archive completed work

See examples in [TICKET-UPDATES.md](references/ticket-updates.md#bulk-operations).

### Workflow: Automated Daily Report

1. Query tickets by status, assignee, or project
2. Aggregate metrics (open count, in progress, completed)
3. Generate summary report
4. Post to Slack or email

See examples in [REPORTING-QUERIES.md](references/reporting-queries.md#automated-reports).

## Power Move

"Combine JQL queries with automation to create a self-service dashboard that pulls real-time ticket metrics, generates daily standups, tracks sprint velocity, and triggers notifications when tickets need attention."

## Troubleshooting

- **Authentication Failed**: Verify `JIRA_URL` and `JIRA_TOKEN` are correct. Check that your API token is generated and not expired.
- **Project Not Found**: Ensure the project key (e.g., `PROJ`) is correct. Check your Jira instance for the exact key.
- **Field Not Found**: Custom fields use different names in the API. Use the field ID (e.g., `customfield_10001`) instead of the display name.
- **Transition Not Allowed**: Verify the ticket is in a state that allows the requested transition. Check workflow configuration in Jira.
- **401 Unauthorized**: Your credentials are invalid or expired. Regenerate your API token.
- **403 Forbidden**: Your account lacks permissions for this operation. Check project and issue permissions in Jira.

## MCP Server Integration

The jira-ticketer skill includes a **Model Context Protocol (MCP) server** that makes Jira tools available to Claude and other agents programmatically.

### Setup

The MCP server is located at `skills/jira-ticketer/scripts/jira_mcp_server.py` and runs via `uv`:

```bash
uv run skills/jira-ticketer/scripts/jira_mcp_server.py
```

### Claude Code Configuration

Add to your `~/.claude.json` to enable the Jira MCP server:

```json
{
  "mcpServers": {
    "jira": {
      "command": "uv",
      "args": ["run", "skills/jira-ticketer/scripts/jira_mcp_server.py"],
      "cwd": "/Users/pwu/MASProjects/pingai"
    }
  }
}
```

### Available Tools

The MCP server exposes 7 tools for Jira automation:

| Tool | Purpose |
|------|---------|
| `create_issue` | Create new Jira issues with summary, description, project, and type |
| `get_issue` | Retrieve full details of an issue by key |
| `update_issue` | Update issue fields (summary, description, priority, assignee) |
| `search_issues` | Query issues using JQL (Jira Query Language) |
| `transition_issue` | Move an issue to a new status |
| `add_comment` | Add a comment to an issue |
| `list_projects` | List all accessible projects |

### Usage Example

```python
# Create an issue
create_issue(
    summary="MCP test ticket",
    description="Testing the Jira MCP server",
    project_key="CM",
    issue_type="Task"
)

# Search for recent issues
search_issues(
    jql="project = CM ORDER BY created DESC",
    max_results=10
)

# Transition to In Progress
transition_issue(
    issue_key="CM-123",
    status_name="In Progress"
)

# Add a comment
add_comment(
    issue_key="CM-123",
    comment="Fixed in latest commit"
)
```

### Configuration

The server reads from environment variables (`.env`):

**Required:**
- `JIRA_URL` — Base URL of your Jira instance
- `JIRA_USERNAME` — Email for authentication
- `JIRA_TOKEN` — API token

**Optional:**
- `JIRA_DEFAULT_PROJECT_KEY` — Default project (e.g., `CM`)
- `JIRA_DEFAULT_ISSUE_TYPE` — Default issue type (default: `Task`)

## References

- [Jira REST API Documentation](https://developer.atlassian.com/cloud/jira/rest/v3/intro/)
- [JQL (Jira Query Language) Syntax](https://www.atlassian.com/software/jira/guides/expand-jira/jira-query-language)
- [API Token Generation](https://support.atlassian.com/atlassian-account/docs/manage-api-tokens-for-your-atlassian-account/)
