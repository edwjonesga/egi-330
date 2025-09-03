FROM ubuntu:22.04

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/workspace/bin:${PATH}"

# Install dependencies and GitHub CLI (gh)
RUN apt-get update && apt-get install -y git curl ca-certificates wget \
    && mkdir -p -m 755 /etc/apt/keyrings \
    && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update \
    && apt-get install -y gh

# Create the init.sh script
RUN echo '#!/bin/bash' > /usr/local/bin/init.sh && \
    echo '' >> /usr/local/bin/init.sh && \
    echo '# Welcome message' >> /usr/local/bin/init.sh && \
    echo 'echo "----------------------------------------------------"' >> /usr/local/bin/init.sh && \
    echo 'echo "Welcome to the EGI-330 Assignment Setup Script!"' >> /usr/local/bin/init.sh && \
    echo 'echo "----------------------------------------------------"' >> /usr/local/bin/init.sh && \
    echo 'echo "This script will guide you through setting up your"' >> /usr/local/bin/init.sh && \
    echo 'echo "GitHub repository for this class."' >> /usr/local/bin/init.sh && \
    echo 'echo ""' >> /usr/local/bin/init.sh && \
    echo '# --- GitHub Authentication ---' >> /usr/local/bin/init.sh && \
    echo 'echo "--- Step 1: GitHub Authentication ---"' >> /usr/local/bin/init.sh && \
    echo 'echo "You will now be prompted to log in to your GitHub account."' >> /usr/local/bin/init.sh && \
    echo 'echo "If you don'\''t have an account, the web page will have a"' >> /usr/local/bin/init.sh && \
    echo 'echo "link to create one."' >> /usr/local/bin/init.sh && \
    echo 'echo ""' >> /usr/local/bin/init.sh && \
    echo 'gh auth login' >> /usr/local/bin/init.sh && \
    echo 'if [ $? -ne 0 ]; then' >> /usr/local/bin/init.sh && \
    echo '    echo "GitHub authentication failed. Please try again."' >> /usr/local/bin/init.sh && \
    echo '    exit 1' >> /usr/local/bin/init.sh && \
    echo 'fi' >> /usr/local/bin/init.sh && \
    echo 'echo "Authentication successful!"' >> /usr/local/bin/init.sh && \
    echo 'echo ""' >> /usr/local/bin/init.sh && \
    echo '# --- Git User Configuration ---' >> /usr/local/bin/init.sh && \
    echo 'echo "--- Step 2: Git Configuration ---"' >> /usr/local/bin/init.sh && \
    echo 'echo "Please provide your name and email to configure git."' >> /usr/local/bin/init.sh && \
    echo 'read -p "Enter your name: " git_user_name' >> /usr/local/bin/init.sh && \
    echo 'read -p "Enter your email: " git_user_email' >> /usr/local/bin/init.sh && \
    echo 'git config --global user.name "$git_user_name"' >> /usr/local/bin/init.sh && \
    echo 'git config --global user.email "$git_user_email"' >> /usr/local/bin/init.sh && \
    echo 'echo "Git configured successfully!"' >> /usr/local/bin/init.sh && \
    echo 'echo ""' >> /usr/local/bin/init.sh && \
    echo '# --- Clone the main repository ---' >> /usr/local/bin/init.sh && \
    echo 'echo "--- Step 3: Cloning the Class Repository ---"' >> /usr/local/bin/init.sh && \
    echo 'echo "Preparing to clone the class repository..."' >> /usr/local/bin/init.sh && \
    echo 'if [ -d "/tmp/edwjones-ccu" ]; then' >> /usr/local/bin/init.sh && \
    echo '    echo "Removing previous clone directory..."' >> /usr/local/bin/init.sh && \
    echo '    rm -rf /tmp/edwjones-ccu' >> /usr/local/bin/init.sh && \
    echo 'fi' >> /usr/local/bin/init.sh && \
    echo 'echo "Cloning the main class repository..."' >> /usr/local/bin/init.sh && \
    echo 'git clone https://github.com/edwjonesga/edwjones-ccu.git /tmp/edwjones-ccu' >> /usr/local/bin/init.sh && \
    echo 'if [ $? -ne 0 ]; then' >> /usr/local/bin/init.sh && \
    echo '    echo "Failed to clone the repository. Please check your internet connection."' >> /usr/local/bin/init.sh && \
    echo '    exit 1' >> /usr/local/bin/init.sh && \
    echo 'fi' >> /usr/local/bin/init.sh && \
    echo 'echo "Repository cloned successfully."' >> /usr/local/bin/init.sh && \
    echo 'echo "DEBUG: Listing contents of /tmp/edwjones-ccu/classes/"' >> /usr/local/bin/init.sh && \
    echo 'ls -l /tmp/edwjones-ccu/classes/' >> /usr/local/bin/init.sh && \
    echo 'echo ""' >> /usr/local/bin/init.sh && \
    echo '# --- Create a new repository on user'\''s GitHub ---' >> /usr/local/bin/init.sh && \
    echo 'echo "--- Step 4: Create Your Own Repository ---"' >> /usr/local/bin/init.sh && \
    echo 'while true; do' >> /usr/local/bin/init.sh && \
    echo '    read -p "Enter a name for your new GitHub repository (e.g., egi-330-assignments): " repo_name' >> /usr/local/bin/init.sh && \
    echo '    if [ -z "$repo_name" ]; then' >> /usr/local/bin/init.sh && \
    echo '        repo_name="egi-330-assignments"' >> /usr/local/bin/init.sh && \
    echo '        echo "No name entered, using default: $repo_name"' >> /usr/local/bin/init.sh && \
    echo '    fi' >> /usr/local/bin/init.sh && \
    echo '    gh repo view "$repo_name" >/dev/null 2>&1' >> /usr/local/bin/init.sh && \
    echo '    if [ $? -eq 0 ]; then' >> /usr/local/bin/init.sh && \
    echo '        echo "A repository named '\''$repo_name'\'' already exists on your GitHub account."' >> /usr/local/bin/init.sh && \
    echo '        read -p "Do you want to use this existing repository? (y/n): " use_existing' >> /usr/local/bin/init.sh && \
    echo '        if [[ "$use_existing" == "y" || "$use_existing" == "Y" ]]; then' >> /usr/local/bin/init.sh && \
    echo '            echo "Using existing repository '\''$repo_name'\''."' >> /usr/local/bin/init.sh && \
    echo '            break' >> /usr/local/bin/init.sh && \
    echo '        else' >> /usr/local/bin/init.sh && \
    echo '            echo "Please choose a different name."' >> /usr/local/bin/init.sh && \
    echo '            continue' >> /usr/local/bin/init.sh && \
    echo '        fi' >> /usr/local/bin/init.sh && \
    echo '    else' >> /usr/local/bin/init.sh && \
    echo '        echo "Creating a new public repository named '\''$repo_name'\'' on your GitHub account..."' >> /usr/local/bin/init.sh && \
    echo '        gh repo create "$repo_name" --public --description "My assignments for EGI-330"' >> /usr/local/bin/init.sh && \
    echo '        if [ $? -ne 0 ]; then' >> /usr/local/bin/init.sh && \
    echo '            echo "Failed to create the repository on GitHub. Please try again."' >> /usr/local/bin/init.sh && \
    echo '        else' >> /usr/local/bin/init.sh && \
    echo '            echo "Repository '\''$repo_name'\'' created successfully on your GitHub account."' >> /usr/local/bin/init.sh && \
    echo '            break' >> /usr/local/bin/init.sh && \
    echo '        fi' >> /usr/local/bin/init.sh && \
    echo '    fi' >> /usr/local/bin/init.sh && \
    echo 'done' >> /usr/local/bin/init.sh && \
    echo 'echo ""' >> /usr/local/bin/init.sh && \
    echo '# --- Push the code to the new repository ---' >> /usr/local/bin/init.sh && \
    echo 'echo "--- Step 5: Pushing the Code ---"' >> /usr/local/bin/init.sh && \
    echo 'echo "Preparing to push the class files to your new repository..."' >> /usr/local/bin/init.sh && \
    echo 'cd /tmp/edwjones-ccu/classes/egi-330' >> /usr/local/bin/init.sh && \
    echo 'if [ $? -ne 0 ]; then' >> /usr/local/bin/init.sh && \
    echo '    echo "Failed to change directory. The directory structure of the repository might have changed."' >> /usr/local/bin/init.sh && \
    echo '    echo "Please contact your instructor."' >> /usr/local/bin/init.sh && \
    echo '    exit 1' >> /usr/local/bin/init.sh && \
    echo 'fi' >> /usr/local/bin/init.sh && \
    echo 'git init' >> /usr/local/bin/init.sh && \
    echo 'git add .' >> /usr/local/bin/init.sh && \
    echo 'git commit -m "Initial commit with class files"' >> /usr/local/bin/init.sh && \
    echo 'git branch -M main' >> /usr/local/bin/init.sh && \
    echo '# Get the user'\''s GitHub username' >> /usr/local/bin/init.sh && \
    echo 'github_user=$(gh api user --jq .login)' >> /usr/local/bin/init.sh && \
    echo '# Set the origin remote and push' >> /usr/local/bin/init.sh && \
    echo 'git remote add origin https://github.com/$github_user/$repo_name.git' >> /usr/local/bin/init.sh && \
    echo 'git push -u origin main' >> /usr/local/bin/init.sh && \
    echo 'if [ $? -ne 0 ]; then' >> /usr/local/bin/init.sh && \
    echo '    echo "Failed to push the code to your repository. Please check the error messages."' >> /usr/local/bin/init.sh && \
    echo '    exit 1' >> /usr/local/bin/init.sh && \
    echo 'fi' >> /usr/local/bin/init.sh && \
    echo 'echo "Code pushed successfully to your repository."' >> /usr/local/bin/init.sh && \
    echo 'echo ""' >> /usr/local/bin/init.sh && \
    echo '# --- Set up the upstream remote ---' >> /usr/local/bin/init.sh && \
    echo 'echo "--- Step 6: Setting Up for Future Updates ---"' >> /usr/local/bin/init.sh && \
    echo 'echo "Configuring the '\''upstream'\'' remote to receive updates from the class repository..."' >> /usr/local/bin/init.sh && \
    echo 'git remote add upstream https://github.com/edwjonesga/edwjones-ccu.git' >> /usr/local/bin/init.sh && \
    echo 'echo "'\''upstream'\'' remote configured."' >> /usr/local/bin/init.sh && \
    echo 'echo ""' >> /usr/local/bin/init.sh && \
    echo '# --- Clone student'\''s new repository to workspace ---' >> /usr/local/bin/init.sh && \
    echo 'echo "--- Step 7: Cloning Your New Repository ---"' >> /usr/local/bin/init.sh && \
    echo 'echo "Cloning your new repository into the current directory..."' >> /usr/local/bin/init.sh && \
    echo 'cd /workspace' >> /usr/local/bin/init.sh && \
    echo 'if [ $? -ne 0 ]; then' >> /usr/local/bin/init.sh && \
    echo '    echo "Failed to change to /workspace directory. This should not happen."' >> /usr/local/bin/init.sh && \
    echo '    exit 1' >> /usr/local/bin/init.sh && \
    echo 'fi' >> /usr/local/bin/init.sh && \
    echo 'git clone "https://github.com/$github_user/$repo_name.git"' >> /usr/local/bin/init.sh && \
    echo 'if [ $? -ne 0 ]; then' >> /usr/local/bin/init.sh && \
    echo '    echo "Failed to clone your new repository. Please check the error messages."' >> /usr/local/bin/init.sh && \
    echo '    exit 1' >> /usr/local/bin/init.sh && \
    echo 'fi' >> /usr/local/bin/init.sh && \
    echo 'echo "Your repository has been cloned successfully."' >> /usr/local/bin/init.sh && \
    echo 'echo ""' >> /usr/local/bin/init.sh && \
    echo '# --- Final Instructions ---' >> /usr/local/bin/init.sh && \
    echo 'echo "----------------------------------------------------"' >> /usr/local/bin/init.sh && \
    echo 'echo "Initialization Complete!"' >> /usr/local/bin/init.sh && \
    echo 'echo "----------------------------------------------------"' >> /usr/local/bin/init.sh && \
    echo 'echo "Your assignment repository has been created on GitHub and cloned to your local machine."' >> /usr/local/bin/init.sh && \
    echo 'echo ""' >> /usr/local/bin/init.sh && \
    echo 'echo "Next steps:"' >> /usr/local/bin/init.sh && \
    echo 'echo "1. In your local terminal, change into your new repository directory:"' >> /usr/local/bin/init.sh && \
    echo 'echo "   cd $repo_name"' >> /usr/local/bin/init.sh && \
    echo 'echo "2. Build your development container:"' >> /usr/local/bin/init.sh && \
    echo 'echo "   ./buildContainer.sh"' >> /usr/local/bin/init.sh && \
    echo 'echo "3. Start your development container:"' >> /usr/local/bin/init.sh && \
    echo 'echo "   ./startContainer.sh"' >> /usr/local/bin/init.sh && \
    echo 'echo ""' >> /usr/local/bin/init.sh && \
    echo 'echo "This container will now exit."' >> /usr/local/bin/init.sh

# Make the script executable
RUN chmod +x /usr/local/bin/init.sh

# Set the default command to run the script
CMD ["/bin/bash"]
