#!/bin/bash

# Define an array of modpack directories
modpacks=("Dimserenes-Modpack" "Fine-tuned-Pack" "Vanilla-Plus-Pack" "Insane-Pack" "Cruel-Pack")

# Base path
base_path=~/storage/documents

# Display modpack options to the user
echo "================================="
echo "Choose modpacks to update:"
echo "(separate choices by space e.g., 1 2)"
echo ""
for i in "${!modpacks[@]}"; do
    echo "$((i+1)). ${modpacks[i]}"
done
echo ""
echo "a. Update all"
echo "q. Quit"
echo "================================="

# Read user input
read -p "Enter your choice: " choice

# Handle user input
if [[ "$choice" == "q" ]]; then
    echo "Exiting script."
    exit 0
elif [[ "$choice" == "a" ]]; then
    # Update all modpacks
    selected_modpacks=("${modpacks[@]}")
else
    # Convert user input into an array
    choice_array=($choice)
    selected_modpacks=()
    
    for index in "${choice_array[@]}"; do
        if [[ "$index" -ge 1 && "$index" -le "${#modpacks[@]}" ]]; then
            selected_modpacks+=("${modpacks[$((index-1))]}")
        else
            echo "Invalid choice: $index"
            exit 1
        fi
    done
fi

# Ask the user if they want to run autoversion.sh instead
read -p "Do you want to run autoversion.sh instead? (y/n): " run_auto

# Iterate over selected modpacks and run the appropriate script
for modpack in "${selected_modpacks[@]}"
do
    cd "$base_path/$modpack" || exit
    if [[ "$run_auto" == "y" ]]; then
        sh "$base_path/$modpack/autoversion.sh"
    else
        sh "$base_path/$modpack/sh-version.sh"
    fi
done

# Prompt user to press any key to exit
echo "Press any key to exit..."
read _