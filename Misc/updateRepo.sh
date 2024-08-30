#!/bin/bash

# GitHub username
GITHUB_USER="Dimserene"
# GitHub token is loaded directly for personal use
GITHUB_TOKEN=""

# Load GitHub token from environment variable or prompt user (without hiding input)
if [ -z "$GITHUB_TOKEN" ]; then
  echo -n 'Enter your GitHub token: '
  read GITHUB_TOKEN
fi

# Get all forked repositories you own
REPOS=$(curl -s -u "$GITHUB_USER:$GITHUB_TOKEN" \
  "https://api.github.com/user/repos?per_page=100" | jq -r '.[] | select(.fork == true) | .full_name')

# Initialize summary counters
TOTAL_REPOS=0
CHECKED_REPOS=0
UPDATED_REPOS=0
ERROR_COUNT=0

# Initialize a summary
SUMMARY="Summary of repository updates:\n\n"
ERRORS=""

# Loop through each repository
for REPO in $REPOS; do
    REPO_NAME=$(basename "$REPO")
    TOTAL_REPOS=$((TOTAL_REPOS + 1))

    # Skip specific repository
    if [ "$REPO_NAME" = "bot-automation" ]; then
        echo "Skipping $REPO_NAME..."
        SUMMARY="$SUMMARY Skipped $REPO_NAME\n"
        continue
    fi

    echo "Checking $REPO..."
    CHECKED_REPOS=$((CHECKED_REPOS + 1))

    # Clone the repository if not already cloned
    if [ ! -d "$REPO_NAME" ]; then
        git clone "https://$GITHUB_USER:$GITHUB_TOKEN@github.com/$REPO.git"
        if [ $? -ne 0 ]; then
            ERRORS="$ERRORS Error: Failed to clone $REPO_NAME\n"
            SUMMARY="$SUMMARY Failed to clone: $REPO_NAME\n"
            ERROR_COUNT=$((ERROR_COUNT + 1))
            continue
        fi
        cd "$REPO_NAME" || exit
    else
        cd "$REPO_NAME" || exit
        git fetch origin
        if [ $? -ne 0 ]; then
            ERRORS="$ERRORS Error: Failed to fetch origin for $REPO_NAME\n"
            SUMMARY="$SUMMARY Failed to fetch origin: $REPO_NAME\n"
            cd .. || exit
            ERROR_COUNT=$((ERROR_COUNT + 1))
            continue
        fi
    fi

    # Check if upstream is already set, if not, add it
    UPSTREAM_URL=$(git remote get-url upstream 2>/dev/null)
    if [ -z "$UPSTREAM_URL" ]; then
        UPSTREAM_URL=$(curl -s -u "$GITHUB_USER:$GITHUB_TOKEN" \
          "https://api.github.com/repos/$REPO" | jq -r '.parent.clone_url')
        if [ $? -ne 0 ]; then
            ERRORS="$ERRORS Error: Failed to get upstream URL for $REPO_NAME\n"
            SUMMARY="$SUMMARY Failed to get upstream URL: $REPO_NAME\n"
            cd .. || exit
            ERROR_COUNT=$((ERROR_COUNT + 1))
            continue
        fi
        git remote add upstream "$UPSTREAM_URL"
        if [ $? -ne 0 ]; then
            ERRORS="$ERRORS Error: Failed to add upstream remote for $REPO_NAME\n"
            SUMMARY="$SUMMARY Failed to add upstream: $REPO_NAME\n"
            cd .. || exit
            ERROR_COUNT=$((ERROR_COUNT + 1))
            continue
        fi
    fi

    # Fetch the latest from upstream
    git fetch upstream
    if [ $? -ne 0 ]; then
        ERRORS="$ERRORS Error: Failed to fetch upstream for $REPO_NAME\n"
        SUMMARY="$SUMMARY Failed to fetch upstream: $REPO_NAME\n"
        cd .. || exit
        ERROR_COUNT=$((ERROR_COUNT + 1))
        continue
    fi

    # Get the default branch
    DEFAULT_BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
    if [ -z "$DEFAULT_BRANCH" ]; then
        ERRORS="$ERRORS Error: Failed to determine default branch for $REPO_NAME\n"
        SUMMARY="$SUMMARY Failed to determine default branch: $REPO_NAME\n"
        cd .. || exit
        ERROR_COUNT=$((ERROR_COUNT + 1))
        continue
    fi

    # Check if the fork is behind the upstream repository
    BEHIND_COMMITS=$(git rev-list --right-only --count "origin/$DEFAULT_BRANCH...upstream/$DEFAULT_BRANCH")
    if [ $? -ne 0 ]; then
        ERRORS="$ERRORS Error: Failed to determine commit differences for $REPO_NAME\n"
        SUMMARY="$SUMMARY Failed to determine commit differences: $REPO_NAME\n"
        cd .. || exit
        ERROR_COUNT=$((ERROR_COUNT + 1))
        continue
    fi

    if [ "$BEHIND_COMMITS" -gt 0 ]; then
        echo "$REPO is behind by $BEHIND_COMMITS commits. Updating..."
        # Merge upstream into the fork
        git checkout "$DEFAULT_BRANCH"
        if [ $? -ne 0 ]; then
            ERRORS="$ERRORS Error: Failed to checkout branch $DEFAULT_BRANCH in $REPO_NAME\n"
            SUMMARY="$SUMMARY Failed to checkout branch: $REPO_NAME\n"
            cd .. || exit
            ERROR_COUNT=$((ERROR_COUNT + 1))
            continue
        fi
        git merge "upstream/$DEFAULT_BRANCH" -m "Merge upstream changes into $DEFAULT_BRANCH"
        if [ $? -ne 0 ]; then
            ERRORS="$ERRORS Error: Merge conflict or failure in $REPO_NAME\n"
            SUMMARY="$SUMMARY Failed to merge upstream: $REPO_NAME\n"
            cd .. || exit
            ERROR_COUNT=$((ERROR_COUNT + 1))
            continue
        fi
        git push "https://$GITHUB_USER:$GITHUB_TOKEN@github.com/$REPO.git" "$DEFAULT_BRANCH"
        if [ $? -ne 0 ]; then
            ERRORS="$ERRORS Error: Failed to push updates to origin for $REPO_NAME\n"
            SUMMARY="$SUMMARY Failed to push updates: $REPO_NAME\n"
            cd .. || exit
            ERROR_COUNT=$((ERROR_COUNT + 1))
            continue
        fi
        UPDATED_REPOS=$((UPDATED_REPOS + 1))
        SUMMARY="$SUMMARY Updated $REPO_NAME by $BEHIND_COMMITS commits\n"
    else
        echo "$REPO is up-to-date."
        SUMMARY="$SUMMARY Up-to-date: $REPO_NAME\n"
    fi

    # Go back to the parent directory
    cd .. || exit

    echo ""
done

# Display summary and errors
echo "\n$SUMMARY"
echo "\nTotal Repositories: $TOTAL_REPOS"
echo "Checked Repositories: $CHECKED_REPOS"
echo "Updated Repositories: $UPDATED_REPOS"
echo "Errors Encountered: $ERROR_COUNT"

if [ -n "$ERRORS" ]; then
    echo "\nErrors encountered:\n$ERRORS"
fi

# Prompt user to press any key to exit
echo "Press any key to exit..."
read _
