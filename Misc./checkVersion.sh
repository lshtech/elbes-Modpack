#!/bin/bash

# Repositories to check
repos=("Dimserene/Dimserenes-Modpack" "Dimserene/Fine-tuned-Pack" "Dimserene/Vanilla-Plus-Pack")

# Function to fetch the latest commit message from a GitHub repository
get_latest_commit_message() {
  repo=$1
  latest_commit=$(curl -s "https://api.github.com/repos/$repo/commits" | jq -r '.[0].commit.message')
  echo "$repo: $latest_commit"
}

# Loop through the repositories and display the latest commit message
for repo in "${repos[@]}"; do
  get_latest_commit_message "$repo"
done

# Pause and wait for the user to press Enter before exiting
read -p "Press Enter to continue..."
