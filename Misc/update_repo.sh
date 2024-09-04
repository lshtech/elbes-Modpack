#!/bin/bash

# Function to update a single repository
REPO="$1"
GITHUB_USER="$2"
GITHUB_TOKEN="$3"
SUMMARY_FILE="$4"
ERRORS_FILE="$5"

REPO_NAME=$(basename "$REPO")

# Skip specific repository
if [ "$REPO_NAME" = "bot-automation" ]; then
    echo "Skipping $REPO_NAME..."
    echo "Skipped $REPO_NAME" >> "$SUMMARY_FILE"
    exit 0
fi

echo "Checking $REPO..."

# Clone the repository if not already cloned
if [ ! -d "$REPO_NAME" ]; then
    git clone "https://$GITHUB_USER:$GITHUB_TOKEN@github.com/$REPO.git" || {
        echo "Error: Failed to clone $REPO_NAME" >> "$ERRORS_FILE"
        echo "Failed to clone: $REPO_NAME" >> "$SUMMARY_FILE"
        exit 1
    }
    cd "$REPO_NAME" || exit 1
else
    cd "$REPO_NAME" || exit 1
    git fetch origin || {
        echo "Error: Failed to fetch origin for $REPO_NAME" >> "$ERRORS_FILE"
        echo "Failed to fetch origin: $REPO_NAME" >> "$SUMMARY_FILE"
        exit 1
    }
fi

# Check if upstream is already set, if not, add it
UPSTREAM_URL=$(git remote get-url upstream 2>/dev/null)
if [ -z "$UPSTREAM_URL" ]; then
    UPSTREAM_URL=$(curl -s -u "$GITHUB_USER:$GITHUB_TOKEN" \
      "https://api.github.com/repos/$REPO" | jq -r '.parent.clone_url') || {
        echo "Error: Failed to get upstream URL for $REPO_NAME" >> "$ERRORS_FILE"
        echo "Failed to get upstream URL: $REPO_NAME" >> "$SUMMARY_FILE"
        exit 1
    }
    git remote add upstream "$UPSTREAM_URL" || {
        echo "Error: Failed to add upstream remote for $REPO_NAME" >> "$ERRORS_FILE"
        echo "Failed to add upstream: $REPO_NAME" >> "$SUMMARY_FILE"
        exit 1
    }
fi

# Fetch the latest from upstream
git fetch upstream || {
    echo "Error: Failed to fetch upstream for $REPO_NAME" >> "$ERRORS_FILE"
    echo "Failed to fetch upstream: $REPO_NAME" >> "$SUMMARY_FILE"
    exit 1
}

# Get the default branch
DEFAULT_BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@') || {
    echo "Error: Failed to determine default branch for $REPO_NAME" >> "$ERRORS_FILE"
    echo "Failed to determine default branch: $REPO_NAME" >> "$SUMMARY_FILE"
    exit 1
}

# Check if the fork is behind the upstream repository
BEHIND_COMMITS=$(git rev-list --right-only --count "origin/$DEFAULT_BRANCH...upstream/$DEFAULT_BRANCH") || {
    echo "Error: Failed to determine commit differences for $REPO_NAME" >> "$ERRORS_FILE"
    echo "Failed to determine commit differences: $REPO_NAME" >> "$SUMMARY_FILE"
    exit 1
}

if [ "$BEHIND_COMMITS" -gt 0 ]; then
    echo "$REPO is behind by $BEHIND_COMMITS commits. Updating..."
    # Merge upstream into the fork
    git checkout "$DEFAULT_BRANCH" || {
        echo "Error: Failed to checkout branch $DEFAULT_BRANCH in $REPO_NAME" >> "$ERRORS_FILE"
        echo "Failed to checkout branch: $REPO_NAME" >> "$SUMMARY_FILE"
        exit 1
    }
    git merge "upstream/$DEFAULT_BRANCH" -m "Merge upstream changes into $DEFAULT_BRANCH" || {
        echo "Error: Merge conflict or failure in $REPO_NAME" >> "$ERRORS_FILE"
        echo "Failed to merge upstream: $REPO_NAME" >> "$SUMMARY_FILE"
        exit 1
    }
    git push "https://$GITHUB_USER:$GITHUB_TOKEN@github.com/$REPO.git" "$DEFAULT_BRANCH" || {
        echo "Error: Failed to push updates to origin for $REPO_NAME" >> "$ERRORS_FILE"
        echo "Failed to push updates: $REPO_NAME" >> "$SUMMARY_FILE"
        exit 1
    }
    echo ""
    echo "Updated $REPO_NAME by $BEHIND_COMMITS commits" >> "$SUMMARY_FILE"

    # Additional functionality for JensBalatroCollection
    if [ "$REPO_NAME" = "JensBalatroCollection" ]; then
        echo "Checking for updates in subfolders..."
        SUBFOLDERS=("JenLib" "Aurinko" "Incantation" "Nopeus")
        MODPACK_PATH="/sdcard/Modpacks/Insane-Pack/Mods/"
        for SUBFOLDER in "${SUBFOLDERS[@]}"; do
            if git diff --name-only "upstream/$DEFAULT_BRANCH" "origin/$DEFAULT_BRANCH" | grep -q "$SUBFOLDER/"; then
                echo "$SUBFOLDER has been updated. Replacing in $MODPACK_PATH"
                # Remove the old folder before copying the new one
                rm -rf "${MODPACK_PATH}${SUBFOLDER}" || {
                    echo "Error: Failed to remove old $SUBFOLDER in $MODPACK_PATH" >> "$ERRORS_FILE"
                    echo "Failed to remove old $SUBFOLDER in $MODPACK_PATH" >> "$SUMMARY_FILE"
                    exit 1
                }
                cp -r "$SUBFOLDER" "$MODPACK_PATH" || {
                    echo "Error: Failed to copy $SUBFOLDER to $MODPACK_PATH" >> "$ERRORS_FILE"
                    echo "Failed to update $SUBFOLDER in $MODPACK_PATH" >> "$SUMMARY_FILE"
                    exit 1
                }
                echo "Updated $SUBFOLDER in $MODPACK_PATH" >> "$SUMMARY_FILE"
            fi
        done
    fi

else
    echo "$REPO is up-to-date."
    echo ""
    echo "Up-to-date: $REPO_NAME" >> "$SUMMARY_FILE"
fi

# Go back to the parent directory
cd ..