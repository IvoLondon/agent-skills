#!/bin/bash

# Record Copilot conversations to markdown files in project-specific folders
# Triggered on session end, runs in background to avoid interference

set -e

# Debugging: Uncomment to log errors and commands for troubleshooting
# LOG_FILE="$HOME/.copilot/hooks/debug.log"
# exec 2>> "$LOG_FILE"  # Redirect errors
# set -x  # Enable command tracing

# Read hook input from stdin
INPUT=$(cat)


# Extract project name from workspace path
# Looks for the last path component or package.json location
PROJECT_NAME=$(echo "$INPUT" | jq -r '.workspacePath // .cwd // ""' 2>/dev/null | xargs basename 2>/dev/null || echo "default")

# Clean up project name for folder creation (keep full name, just remove invalid chars)
PROJECT_FOLDER="${PROJECT_NAME//[^a-zA-Z0-9-]/}"  # Remove invalid chars only
[[ -z "$PROJECT_FOLDER" ]] && PROJECT_FOLDER="default"

# Create conversations directory structure
CONV_DIR="$HOME/.copilot/hooks/logs/$PROJECT_FOLDER"
mkdir -p "$CONV_DIR"

# Extract session ID and generate timestamp
SESSION_ID=$(echo "$INPUT" | jq -r '.sessionId // "unknown"' 2>/dev/null)
TIMESTAMP=$(date "+%Y%m%d_%H%M%S")

# Use session ID for filename (one file per conversation)
FILENAME="$CONV_DIR/${SESSION_ID}.md"

# Find the session events file
SESSION_EVENTS="$HOME/.copilot/session-state/$SESSION_ID/events.jsonl"

# Extract conversation messages and format as markdown
{
  echo "# Session: $TIMESTAMP"
  echo "**Project:** $PROJECT_FOLDER"
  echo "**Session ID:** $SESSION_ID"
  echo ""
  echo "## Conversation"
  echo ""
  
  # Extract user and assistant messages from events.jsonl
  if [[ -f "$SESSION_EVENTS" ]]; then
    grep -E '"type":"(user\.message|assistant\.message)"' "$SESSION_EVENTS" | jq -r '
      if .type == "user.message" then
        "### User (" + (.timestamp // "") + ")\n\n" + (.data.content // "") + "\n"
      elif .type == "assistant.message" then
        "### Assistant (" + (.timestamp // "") + ")\n\n" + (.data.content // "") + "\n"
      else
        ""
      end' 2>/dev/null
  else
    echo "**Error:** Session events file not found at $SESSION_EVENTS"
    echo ""
    echo "Available data from hook input:"
    echo "\`\`\`json"
    echo "$INPUT" | jq '.' 2>/dev/null || echo "$INPUT"
    echo "\`\`\`"
  fi
      
} > "$FILENAME"

# Return success
exit 0
