#!/bin/bash

# Random Greeting Function
greet_user() {
    local greetings=(
        "Welcome back."
        "Initializing modpack update process."
        "Starting the update process."
        "Modpack update procedure starting."
        "Preparing to update modpacks."
    )
    
    local greeting_index=$((RANDOM % ${#greetings[@]}))
    echo "${greetings[$greeting_index]}"
    echo "Please wait while we prepare everything."
    echo ""
    sleep 3  # Added sleep and extra line
}

# Random Progress Messages
update_message() {
    local updates=(
        "Checking for the latest updates."
        "Processing modpack updates."
        "Verifying modpack versions."
        "Applying available updates."
        "Updating the modpacks now."
    )
    
    local update_index=$((RANDOM % ${#updates[@]}))
    echo "${updates[$update_index]}"
}

# Random Exit Message
exit_message() {
    local farewells=(
        "Update process completed successfully."
        "All modpacks are up to date."
        "The update procedure has finished."
        "Modpacks updated successfully."
        "Modpack updates applied without issues."
    )
    
    local farewell_index=$((RANDOM % ${#farewells[@]}))
    echo "${farewells[$farewell_index]}"
}

# Random Exit Quotes when 'q' is pressed
exit_quote() {
    local quotes=(
        "Exiting... See you next time!"
        "Goodbye! Your work here is done."
        "Farewell! Until we meet again."
        "Thank you for using the update script!"
        "Leaving so soon? Take care!"
    )
    
    local quote_index=$((RANDOM % ${#quotes[@]}))
    echo "${quotes[$quote_index]}"
}

# Random Selection Prompts
selection_prompt() {
    local prompts=(
        "Select the modpacks you wish to update:"
        "Choose which modpacks to update:"
        "Pick the modpacks to update:"
        "Indicate the modpacks to update:"
        "Please specify which modpacks to update:"
    )
    
    local prompt_index=$((RANDOM % ${#prompts[@]}))
    echo "${prompts[$prompt_index]}"
}

# Random Input Error Message
input_error_message() {
    local errors=(
        "Invalid input, please try again."
        "That selection is not valid."
        "Input not recognized, please retry."
        "Unrecognized input, please correct it."
        "Input error, please enter a valid option."
    )
    
    local error_index=$((RANDOM % ${#errors[@]}))
    echo "${errors[$error_index]}"
}

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
        log_message "$message"
        execution_summaries+=("$modpack: FAILED (Directory does not exist)")
        return 1
    fi
    
    if [[ ! -f "$modpack_path/autoversion.sh" ]]; then
        message="autoversion.sh script not found in $modpack_path. Skipping $modpack."
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
        return 1  # Fixed loose parentheses here
    fi
}

# Function to select modpacks
select_modpacks() {
    while true; do
        # Display modpack options to the user
        echo "================================="
        selection_prompt  # Random selection prompt
        echo "(e.g., 1 2 4-5 or 1-3 5)"
        echo ""
        for i in "${!modpacks[@]}"; do
            echo "$((i+1)). ${modpacks[i]}"
        done
        echo ""
        echo "a. Update all modpacks"
        echo "q. Cancel and exit"
        echo "================================="
        
        # Read user input
        read -p "Enter your selection: " choice
        
        # Handle user input
        if [[ "$choice" == "q" ]]; then
            exit_quote  # Random exit quote
            sleep 3  # Wait 3 seconds before exiting
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
                        input_error_message  # Random error message
                        valid_input=false
                        break
                    fi
                elif [[ "$item" =~ ^[0-9]+$ ]]; then
                    # Handle single number input (e.g., 5)
                    if [[ "$item" -ge 1 && "$item" -le "${#modpacks[@]}" ]]; then
                        selected_modpacks+=("${modpacks[$((item-1))]}")
                    else
                        input_error_message  # Random error message
                        valid_input=false
                        break
                    fi
                else
                    input_error_message  # Random error message
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

# Greet the user with a random message
greet_user

# Select modpacks for updating
select_modpacks

# Update selected modpacks
for modpack in "${selected_modpacks[@]}"; do
    update_message  # Random update message
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

# Display a random exit message
exit_message

# Prompt user to press enter to exit
echo ""
echo "Press enter to exit..."
read -r  # Changed to wait for enter key
log_message "Script execution completed."