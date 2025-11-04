#!/bin/bash
# Git Push with Exponential Backoff Retry
# Usage: ./git-push-with-retry.sh <branch-name>

set -e

BRANCH_NAME=$1
MAX_RETRIES=4
RETRY_COUNT=0
DELAY=2

if [ -z "$BRANCH_NAME" ]; then
    echo "Error: Branch name is required"
    echo "Usage: $0 <branch-name>"
    exit 1
fi

# Validate branch name starts with 'claude/' and ends with session id
if [[ ! "$BRANCH_NAME" =~ ^claude/.+-[a-zA-Z0-9]+$ ]]; then
    echo "Error: Branch name must start with 'claude/' and end with matching session id"
    echo "Example: claude/github-userstory-factory-workflow-abc123"
    exit 1
fi

echo "Pushing branch: $BRANCH_NAME"

while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
    if git push -u origin "$BRANCH_NAME"; then
        echo "✅ Successfully pushed branch $BRANCH_NAME"
        exit 0
    else
        EXIT_CODE=$?
        RETRY_COUNT=$((RETRY_COUNT + 1))

        if [ $RETRY_COUNT -lt $MAX_RETRIES ]; then
            echo "⚠️  Push failed (attempt $RETRY_COUNT/$MAX_RETRIES). Retrying in ${DELAY}s..."
            sleep $DELAY
            DELAY=$((DELAY * 2))  # Exponential backoff: 2s, 4s, 8s, 16s
        else
            echo "❌ Failed to push after $MAX_RETRIES attempts"
            exit $EXIT_CODE
        fi
    fi
done
