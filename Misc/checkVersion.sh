#!/bin/bash

# Repositories to check
repos=("Dimserene/Dimserenes-Modpack" "Dimserene/Fine-tuned-Pack" "Dimserene/Vanilla-Plus-Pack" "Dimserene/Insane-Pack" "Dimserene/Cruel-Pack")

# Function to fetch the latest commit message from a GitHub repository
get_latest_commit_message() {
  repo=$1
  response=$(curl -s "https://api.github.com/repos/$repo/commits")

  # Check if curl request was successful
  if [[ $? -ne 0 ]]; then
    echo "Error: Failed to fetch data for $repo"
    return
  fi

  # Check if the response is an array
  if ! echo "$response" | jq -e 'type == "array"' > /dev/null; then
    echo "Error: Expected an array but got something else for $repo"
    echo "Response: $response"  # Debugging: Output the raw response
    return
  fi

  # Extract the latest commit message, committer, and date
  latest_commit=$(echo "$response" | jq -r '.[0].commit.message')
  committer=$(echo "$response" | jq -r '.[0].commit.committer.name')
  commit_date=$(echo "$response" | jq -r '.[0].commit.committer.date')

  # Convert UTC date to Taiwanese time format (YYYY/MM/DD HH:MM:SS)
  commit_date_taiwan=$(TZ=Asia/Taipei date -d "$commit_date" +"%Y/%m/%d %H:%M:%S")

  if [[ -z "$latest_commit" ]]; then
    echo "$repo: No commits found or failed to parse commit data."
  else
    echo "$repo:"
    echo "Message: $latest_commit"
    echo "Committed by: $committer"
    echo "Date: $commit_date_taiwan"
    echo -e "\n"  # Add a blank line between each repository's output
  fi
}

# Export the function to make it available for parallel execution
export -f get_latest_commit_message

# Use GNU parallel to run the requests in parallel (if available)
if command -v parallel > /dev/null; then
  parallel get_latest_commit_message ::: "${repos[@]}"
else
  echo "GNU parallel not found, running sequentially..."
  for repo in "${repos[@]}"; do
    get_latest_commit_message "$repo"
  done
fi

# Pause and wait for the user to press Enter before exiting
read -p "Press Enter to continue..."