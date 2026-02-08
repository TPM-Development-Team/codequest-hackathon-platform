#!/bin/bash

# 🔄 Sync Script - Pull changes from upstream and push to your fork
# This script automates the workflow of syncing your fork with the team repository

set -e  # Exit on error

echo "🔄 Syncing with Upstream Repository"
echo "===================================="
echo ""

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ Error: Not in a git repository"
    exit 1
fi

# Check if upstream remote exists
if ! git remote | grep -q "^upstream$"; then
    echo "❌ Error: 'upstream' remote not configured"
    echo "Please run ./setup-fork.sh first"
    exit 1
fi

# Get current branch
CURRENT_BRANCH=$(git branch --show-current)
echo "📍 Current branch: $CURRENT_BRANCH"
echo ""

# Check for uncommitted changes
if ! git diff-index --quiet HEAD --; then
    echo "⚠️  Warning: You have uncommitted changes"
    git status --short
    echo ""
    read -p "Do you want to stash these changes? (y/n): " STASH_CHANGES
    if [ "$STASH_CHANGES" = "y" ]; then
        echo "📦 Stashing changes..."
        git stash
        STASHED=true
    else
        echo "❌ Please commit or stash your changes first"
        exit 1
    fi
fi

echo "⬇️  Fetching from upstream..."
git fetch upstream

echo "🔀 Merging upstream/main into $CURRENT_BRANCH..."
if git merge upstream/main; then
    echo "✅ Merge successful"
else
    echo "❌ Merge failed - please resolve conflicts manually"
    exit 1
fi

echo "⬆️  Pushing to origin..."
if git push origin "$CURRENT_BRANCH"; then
    echo "✅ Push successful"
else
    echo "❌ Push failed"
    exit 1
fi

# Restore stashed changes if any
if [ "$STASHED" = true ]; then
    echo "📦 Restoring stashed changes..."
    git stash pop
fi

echo ""
echo "✅ Sync complete!"
echo ""
echo "📊 Summary:"
git log --oneline -5
echo ""
echo "🚀 Your fork is now up to date with upstream"
echo "   Vercel will automatically deploy these changes"
