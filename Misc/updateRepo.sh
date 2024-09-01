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
SUMMARY_FILE=$(mktemp)
ERRORS_FILE=$(mktemp)

# Export variables needed for update_repo.sh
export GITHUB_USER GITHUB_TOKEN SUMMARY_FILE ERRORS_FILE

# Run the update_repo.sh script in parallel for each repository using bash explicitly
echo "$REPOS" | parallel --jobs 4 bash update_repo.sh {} "$GITHUB_USER" "$GITHUB_TOKEN" "$SUMMARY_FILE" "$ERRORS_FILE"

# Display summary and errors
SUMMARY=$(cat "$SUMMARY_FILE")
ERRORS=$(cat "$ERRORS_FILE")

printf "\n%s\n" "$SUMMARY"
printf "\nTotal Repositories: %d\n" "$TOTAL_REPOS"
printf "Checked Repositories: %d\n" "$CHECKED_REPOS"
printf "Updated Repositories: %d\n" "$UPDATED_REPOS"
printf "Errors Encountered: %d\n" "$ERROR_COUNT"

if [ -n "$ERRORS" ]; then
    printf "\nErrors encountered:\n%s\n" "$ERRORS"
fi

# Cleanup temporary files
rm "$SUMMARY_FILE" "$ERRORS_FILE"

# Prompt user to press any key to exit
echo "Press any key to exit..."
read _