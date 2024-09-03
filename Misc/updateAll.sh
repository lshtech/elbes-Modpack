#!/bin/bash

# Define an array of modpack directories
modpacks=("Dimserenes-Modpack" "Fine-tuned-Pack" "Vanilla-Plus-Pack" "Insane-Pack" "Cruel-Pack")

# Base path
base_path=/sdcard/Modpacks

while true; do
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
        break
    else
        # Convert user input into an array
        choice_array=($choice)
        selected_modpacks=()
        
        valid_input=true
        for index in "${choice_array[@]}"; do
            if [[ "$index" -ge 1 && "$index" -le "${#modpacks[@]}" ]]; then
                selected_modpacks+=("${modpacks[$((index-1))]}")
            else
                echo "Invalid choice: $index"
                valid_input=false
                break
            fi
        done
        
        # If input was valid, break out of loop
        if $valid_input; then
            break
        fi
    fi
done

# Iterate over selected modpacks and run the appropriate script
for modpack in "${selected_modpacks[@]}"
do
    cd "$base_path/$modpack" || exit
    sh "$base_path/$modpack/autoversion.sh"
done

# Prompt user to press any key to exit
echo ""
echo "Press any key to exit..."
read _