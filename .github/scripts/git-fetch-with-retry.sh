#!/bin/bash
# Git Fetch with Exponential Backoff Retry
# Usage: ./git-fetch-with-retry.sh [branch-name]

set -e

BRANCH_NAME=$1
MAX_RETRIES=4
RETRY_COUNT=0
DELAY=2

echo "Fetching from origin${BRANCH_NAME:+ for branch $BRANCH_NAME}..."

while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
    if [ -z "$BRANCH_NAME" ]; then
        # Fetch all branches
        if git fetch origin; then
            echo "✅ Successfully fetched from origin"
            exit 0
        fi
    else
        # Fetch specific branch
        if git fetch origin "$BRANCH_NAME"; then
            echo "✅ Successfully fetched branch $BRANCH_NAME"
            exit 0
        fi
    fi

    EXIT_CODE=$?
    RETRY_COUNT=$((RETRY_COUNT + 1))

    if [ $RETRY_COUNT -lt $MAX_RETRIES ]; then
        echo "⚠️  Fetch failed (attempt $RETRY_COUNT/$MAX_RETRIES). Retrying in ${DELAY}s..."
        sleep $DELAY
        DELAY=$((DELAY * 2))  # Exponential backoff: 2s, 4s, 8s, 16s
    else
        echo "❌ Failed to fetch after $MAX_RETRIES attempts"
        exit $EXIT_CODE
    fi
done
