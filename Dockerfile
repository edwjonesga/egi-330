FROM ubuntu:22.04

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/workspace/bin:${PATH}"

# Install dependencies
RUN apt-get update && apt-get install -y git curl ca-certificates wget rsync

# Create the init.sh script
RUN echo '#!/bin/bash' > /usr/local/bin/init.sh && \
    echo '' >> /usr/local/bin/init.sh && \
    echo 'echo "----------------------------------------------------"' >> /usr/local/bin/init.sh && \
    echo 'echo "Welcome to the EGI-330 Project Initializer!"' >> /usr/local/bin/init.sh && \
    echo 'echo "----------------------------------------------------"' >> /usr/local/bin/init.sh && \
    echo '' >> /usr/local/bin/init.sh && \
    echo '# Clone the source repository' >> /usr/local/bin/init.sh && \
    echo 'echo "Cloning the source repository into a temporary directory..."' >> /usr/local/bin/init.sh && \
    echo 'git clone https://github.com/edwjonesga/egi-330.git /tmp/egi-330-source' >> /usr/local/bin/init.sh && \
    echo 'if [ $? -ne 0 ]; then' >> /usr/local/bin/init.sh && \
    echo '    echo "Failed to clone the source repository. Aborting."' >> /usr/local/bin/init.sh && \
    echo '    exit 1' >> /usr/local/bin/init.sh && \
    echo 'fi' >> /usr/local/bin/init.sh && \
    echo '' >> /usr/local/bin/init.sh && \
    echo '# Copy files to the workspace' >> /usr/local/bin/init.sh && \
    echo 'echo "Copying project files into your workspace..."' >> /usr/local/bin/init.sh && \
    echo 'cp -r /tmp/egi-330-source/* /workspace/' >> /usr/local/bin/init.sh && \
    echo 'cp -r /tmp/egi-330-source/.github /workspace/' >> /usr/local/bin/init.sh &&\
    echo '' >> /usr/local/bin/init.sh && \
    echo '# Initialize a new git repository' >> /usr/local/bin/init.sh && \
    echo 'echo "Initializing a new git repository..."' >> /usr/local/bin/init.sh && \
    echo 'git init' >> /usr/local/bin/init.sh && \
    echo '' >> /usr/local/bin/init.sh && \
    echo '# Commit initial files and create branches' >> /usr/local/bin/init.sh && \
    echo 'echo "Committing initial project files to main branch..."' >> /usr/local/bin/init.sh && \
    echo 'git checkout -b main' >> /usr/local/bin/init.sh && \
    echo 'git add .' >> /usr/local/bin/init.sh && \
    echo 'git commit -m "Initial commit of project files"' >> /usr/local/bin/init.sh && \
    echo '' >> /usr/local/bin/init.sh && \
    echo '# Create source-update-branch from main' >> /usr/local/bin/init.sh && \
    echo 'echo "Creating source-update-branch..."' >> /usr/local/bin/init.sh && \
    echo 'git checkout -b source-update-branch' >> /usr/local/bin/init.sh && \
    echo 'git checkout main' >> /usr/local/bin/init.sh && \
    echo '' >> /usr/local/bin/init.sh && \
    echo '# Prompt for remote repository' >> /usr/local/bin/init.sh && \
    echo 'echo "Please provide the URL for your new GitHub repository."' >> /usr/local/bin/init.sh && \
    echo 'read -p "Enter your GitHub repo URL (e.g., https://github.com/username/repo.git): " remote_url' >> /usr/local/bin/init.sh && \
    echo 'git remote add origin $remote_url' >> /usr/local/bin/init.sh && \
    echo 'echo "Remote '\''origin'\'' set to $remote_url"' >> /usr/local/bin/init.sh && \
    echo '' >> /usr/local/bin/init.sh && \
    echo '# Clean up' >> /usr/local/bin/init.sh && \
    echo 'echo "Cleaning up temporary files..."' >> /usr/local/bin/init.sh && \
    echo 'rm -rf /tmp/egi-330-source' >> /usr/local/bin/init.sh && \
    echo '' >> /usr/local/bin/init.sh && \
    echo 'echo "----------------------------------------------------"' >> /usr/local/bin/init.sh && \
    echo 'echo "Initialization complete!"' >> /usr/local/bin/init.sh && \
    echo 'echo "You can now start working on your project."' >> /usr/local/bin/init.sh && \
    echo 'echo "Push your initial commit to your GitHub repository with: git push -u origin main"' >> /usr/local/bin/init.sh && \
    echo 'echo "----------------------------------------------------"' >> /usr/local/bin/init.sh

# Make the script executable
RUN chmod +x /usr/local/bin/init.sh

# Set the default command to an interactive shell
CMD ["/bin/bash"]
