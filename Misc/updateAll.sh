#!/bin/bash

# Define an array of modpack directories
modpacks=("Dimserenes-Modpack" "Fine-tuned-Pack" "Vanilla-Plus-Pack" "Insane-Pack" "Cruel-Pack")

# Base path
base_path=/sdcard/Modpacks

# Log file path
log_file="$base_path/update_log.txt"

# Function to log messages
log_message() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $1" >> "$log_file"
}

# Function to update a single modpack
update_modpack() {
    local modpack=$1
    local modpack_path="$base_path/$modpack"

    if [[ ! -d "$modpack_path" ]]; then
        message="Directory $modpack_path does not exist. Skipping $modpack."
        echo "$message"
        log_message "$message"
        execution_summaries+=("$modpack: FAILED (Directory does not exist)")
        return 1
    fi
    
    if [[ ! -f "$modpack_path/autoversion.sh" ]]; then
        message="autoversion.sh script not found in $modpack_path. Skipping $modpack."
        echo "$message"
        log_message "$message"
        execution_summaries+=("$modpack: FAILED (autoversion.sh not found)")
        return 1
    fi
    
    # Run the update script and capture the result
    cd "$modpack_path" || exit
    sh "$modpack_path/autoversion.sh"
    if [[ $? -eq 0 ]]; then
        execution_summaries+=("$modpack: SUCCESS")
        log_message "$modpack update: SUCCESS"
    else
        execution_summaries+=("$modpack: FAILED (Check autoversion.sh output for details)")
        log_message "$modpack update: FAILED (Check autoversion.sh output for details)"
        return 1
    fi
}

# Function to select modpacks
select_modpacks() {
    while true; do
        # Display modpack options to the user
        echo "================================="
        echo "Choose modpacks to update:"
        echo "(e.g., 1 2 4-5 or 1-3 5)"
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
            log_message "User exited the script."
            exit 0
        elif [[ "$choice" == "a" ]]; then
            # Update all modpacks
            selected_modpacks=("${modpacks[@]}")
            break
        else
            # Convert user input into an array
            selected_modpacks=()
            valid_input=true

            IFS=' ' read -r -a choice_array <<< "$choice"

            for item in "${choice_array[@]}"; do
                if [[ "$item" =~ ^[0-9]+-[0-9]+$ ]]; then
                    # Handle range input (e.g., 1-3)
                    start=$(echo "$item" | cut -d '-' -f 1)
                    end=$(echo "$item" | cut -d '-' -f 2)
                    if [[ "$start" -ge 1 && "$end" -le "${#modpacks[@]}" && "$start" -le "$end" ]]; then
                        for ((i=start; i<=end; i++)); do
                            selected_modpacks+=("${modpacks[$((i-1))]}")
                        done
                    else
                        echo "Invalid range: $item"
                        valid_input=false
                        break
                    fi
                elif [[ "$item" =~ ^[0-9]+$ ]]; then
                    # Handle single number input (e.g., 5)
                    if [[ "$item" -ge 1 && "$item" -le "${#modpacks[@]}" ]]; then
                        selected_modpacks+=("${modpacks[$((item-1))]}")
                    else
                        echo "Invalid choice: $item"
                        valid_input=false
                        break
                    fi
                else
                    echo "Invalid input: $item"
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
}

# Main Execution
execution_summaries=()
select_modpacks

for modpack in "${selected_modpacks[@]}"; do
    update_modpack "$modpack"
done

# Display summary of results
echo ""
echo "================================="
echo "Update Summary:"
for summary in "${execution_summaries[@]}"; do
    echo "$summary"
done
echo "================================="

# Log the summary
log_message "Update Summary:"
for summary in "${execution_summaries[@]}"; do
    log_message "$summary"
done

# Prompt user to press any key to exit
echo ""
echo "Press any key to exit..."
read -n 1 -s

log_message "Script execution completed."