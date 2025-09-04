#!/bin/bash

# Define the source repository URL
SOURCE_REPO="https://github.com/edwjonesga/egi-330.git"
TEMP_DIR="/tmp/egi-330-latest"

echo "Switching to the source-update-branch..."
git checkout source-update-branch
if [ $? -ne 0 ]; then
    echo "Failed to switch to source-update-branch. Aborting."
    exit 1
fi

echo "Cloning the latest version of the source repository..."
# Remove the temp directory if it exists
if [ -d "$TEMP_DIR" ]; then
    rm -rf "$TEMP_DIR"
fi
git clone "$SOURCE_REPO" "$TEMP_DIR"
if [ $? -ne 0 ]; then
    echo "Failed to clone the source repository. Aborting."
    git checkout main
    exit 1
fi

echo "Copying updated files into the branch..."
# Use rsync to copy files, which is efficient
rsync -av --exclude='.git/' "$TEMP_DIR/" .
if [ $? -ne 0 ]; then
    echo "Failed to copy updated files. Aborting."
    git checkout main
    rm -rf "$TEMP_DIR"
    exit 1
fi

echo "Committing the updates..."
# Set user for this commit to match the init script
git config --global user.email "init@egi-330init.ccu.edu"
git config --global user.name "EGI Init Script"
git add .
# The `|| true` part prevents the script from exiting if there are no changes to commit
git commit -m "Update from source repository" || true

echo "Switching back to the main branch..."
git checkout main

echo "Merging updates into the main branch..."
git merge source-update-branch
if [ $? -ne 0 ]; then
    echo "Failed to merge updates. Please resolve any conflicts and then run 'git merge source-update-branch' manually."
    rm -rf "$TEMP_DIR"
    exit 1
fi

echo "Cleaning up temporary files..."
rm -rf "$TEMP_DIR"

echo "----------------------------------------------------"
echo "Update complete!"
echo "The latest changes have been merged into your main branch."
echo "----------------------------------------------------"
