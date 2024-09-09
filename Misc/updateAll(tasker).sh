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
        log_message "Directory $modpack_path does not exist. Skipping $modpack."
        execution_summaries+=("$modpack: FAILED (Directory does not exist)")
        return 1
    fi
    
    if [[ ! -f "$modpack_path/autoversion.sh" ]]; then
        log_message "autoversion.sh script not found in $modpack_path. Skipping $modpack."
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

# Main Execution
execution_summaries=()

# Update all modpacks
for modpack in "${modpacks[@]}"; do
    update_modpack "$modpack"
done

# Display summary of results
echo ""
echo "Update Summary:"
for summary in "${execution_summaries[@]}"; do
    echo "$summary"
done

# Log the summary
log_message "Update Summary:"
for summary in "${execution_summaries[@]}"; do
    log_message "$summary"
done

# Prompt user to press enter to exit
read -p "Press enter to exit..."
log_message "Script execution completed."