#!/bin/bash

# Function to prompt user and wait for response
prompt_to_continue() {
    while true; do
        read -p "$1 (press y to continue or n to abort): " yn
        case $yn in
            [Yy]* ) break;;
            [Nn]* ) echo "Aborting."; exit;;
            * ) echo "Please answer y or n.";;
        esac
    done
}

# Function to prompt user to press any key to continue
prompt_any_key() {
    echo -n "$1 (press any key to continue)"
    while true; do
        read -s -r -p "" key
        if [ -n "$key" ]; then
            break
        fi
    done
    echo
}

# Pull the latest changes from the remote repository
git pull

# Update all submodules to their latest commit from the remote, merge them into the current branch
git submodule update --remote --recursive --merge

# Prompt user to continue editing CurrentVersion.txt
prompt_to_continue "Ready to edit CurrentVersion.txt?"

# Open the CurrentVersion.txt file for editing in the nano text editor
nano ./CurrentVersion.txt

# Copy the CurrentVersion.txt file to the Mods/ModpackUtil/ directory
cp ./CurrentVersion.txt ./Mods/ModpackUtil/

# Write the current UTC date and time to VersionTime.txt in the Mods/ModpackUtil/ directory
date -u "+%Y/%m/%d %H:%M:%S" > Mods/ModpackUtil/VersionTime.txt

# Stage all changes in the current directory for commit
git add .

# Commit the staged changes with the message from CurrentVersion.txt
git commit -F Mods/ModpackUtil/CurrentVersion.txt

# Push the committed changes to the remote repository
git push

# Prompt user after pushing changes
prompt_any_key "Changes pushed to the remote repository."
