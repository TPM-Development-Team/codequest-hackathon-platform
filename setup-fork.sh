#!/bin/bash

# 🚀 Setup Script - Configure Git Remotes for Fork Strategy
# This script helps you configure your local repository to work with both:
# - origin (your fork) for deployment
# - upstream (team repo) for syncing

set -e  # Exit on error

echo "🔧 Git Remote Setup for Fork Strategy"
echo "======================================"
echo ""

# Get GitHub username
read -p "Enter your GitHub username: " GITHUB_USERNAME

if [ -z "$GITHUB_USERNAME" ]; then
    echo "❌ Error: GitHub username cannot be empty"
    exit 1
fi

echo ""
echo "📋 Current remote configuration:"
git remote -v
echo ""

# Check if upstream already exists
if git remote | grep -q "^upstream$"; then
    echo "⚠️  'upstream' remote already exists. Skipping rename."
else
    echo "🔄 Renaming 'origin' to 'upstream'..."
    git remote rename origin upstream
    echo "✅ Renamed successfully"
fi

# Check if origin already exists
if git remote | grep -q "^origin$"; then
    echo "⚠️  'origin' remote already exists."
    read -p "Do you want to update it? (y/n): " UPDATE_ORIGIN
    if [ "$UPDATE_ORIGIN" = "y" ]; then
        git remote remove origin
        git remote add origin "https://github.com/$GITHUB_USERNAME/codequest-hackathon-platform.git"
        echo "✅ Updated 'origin' remote"
    fi
else
    echo "➕ Adding your fork as 'origin'..."
    git remote add origin "https://github.com/$GITHUB_USERNAME/codequest-hackathon-platform.git"
    echo "✅ Added successfully"
fi

echo ""
echo "📋 New remote configuration:"
git remote -v
echo ""

echo "✅ Setup complete!"
echo ""
echo "📝 Next steps:"
echo "1. Make sure you've forked the repository on GitHub:"
echo "   https://github.com/TPM-Development-Team/codequest-hackathon-platform"
echo ""
echo "2. Push to your fork:"
echo "   git push -u origin main"
echo ""
echo "3. To sync from upstream in the future, run:"
echo "   git fetch upstream && git merge upstream/main && git push origin main"
echo ""
echo "4. Deploy to Vercel:"
echo "   - Go to https://vercel.com"
echo "   - Import your fork: $GITHUB_USERNAME/codequest-hackathon-platform"
echo "   - Set Root Directory to: frontend"
echo ""
echo "📖 For more details, see DEPLOYMENT.md"
