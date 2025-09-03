# EGI-330 Project Setup

Welcome to EGI-330! This guide will walk you through setting up your development environment using Docker. The process has been streamlined to get you up and running as quickly as possible.

## Setup Instructions

Follow these steps to prepare your local development environment.

### Step 1: Create a Repository on GitHub

First, create a new, empty repository on your GitHub account. You can name it whatever you like (e.g., `egi-330-assignments`). **Do not** initialize it with a README, .gitignore, or license file. You just need an empty repository.

After creating the repository, copy its HTTPS URL. You will need it later. It should look something like this: `https://github.com/your-username/your-repo-name.git`.

### Step 2: Install Docker

If you don't already have Docker installed, please follow the instructions for your operating system.

- **Windows/Mac:** Download and install [Docker Desktop](https://www.docker.com/products/docker-desktop).
- **Linux:** Follow the official instructions to install the [Docker Engine](https://docs.docker.com/engine/install/).

### Step 3: Download the Dockerfile

Download the `Dockerfile` from this repository and place it in a new, empty directory on your computer.

[**Click here to download the Dockerfile**](https://raw.githubusercontent.com/edwjonesga/egi-330/main/Dockerfile)

Make sure the downloaded file is named `Dockerfile` with no file extension.

### Step 4: Build the Docker Image

Open a terminal (or PowerShell on Windows) in the directory where you saved the `Dockerfile` and run the following command to build the Docker image:

```sh
docker build -t egi-330-env .
```

This command creates a Docker image named `egi-330-env` that contains all the necessary tools for this course.

### Step 5: Run the Container and Initialize

First, run the Docker container. This will start an interactive shell.

- **For Linux and Mac:**
  ```sh
  docker run -it --rm -v "$(pwd)":/workspace egi-330-env
  ```

- **For Windows (using PowerShell):**
  ```sh
  docker run -it --rm -v "${PWD}:/workspace" egi-330-env
  ```

- **For Windows (using Command Prompt):**
  ```sh
  docker run -it --rm -v "%cd%":/workspace egi-330-env
  ```

Once you are inside the container's shell, run the initialization script:
```sh
init.sh
```
The script will set up your project and then exit, stopping the container.

### Step 6: Start Your Development Session

Run the exact same `docker run` command a second time to begin your development session.

- **For Linux and Mac:**
  ```sh
  docker run -it --rm -v "$(pwd)":/workspace egi-330-env
  ```

- **For Windows (using PowerShell):**
  ```sh
  docker run -it --rm -v "${PWD}:/workspace" egi-330-env
  ```

- **For Windows (using Command Prompt):**
  ```sh
  docker run -it --rm -v "%cd%":/workspace egi-330-env
  ```

You are now inside your development environment, which has all the necessary tools and your project files.

### Step 7: Authenticate with GitHub

Before you can push your code to your GitHub repository, you need to authenticate. We've included the GitHub CLI to make this easy.

Inside the container, run the following command:
```sh
gh auth login
```

This command will ask you a few questions:
- **What account do you want to log into?** Select `GitHub.com`.
- **What is your preferred protocol for Git operations?** Select `HTTPS`.
- **Authenticate Git with your GitHub credentials?** Select `Y` (Yes).
- **How would you like to authenticate?** Select `Login with a web browser`.

It will then give you a one-time code and ask you to open a URL in your browser. Copy the code, then open the link in your web browser on your main computer (not in the container) and paste the code to authorize the CLI.

After you've authenticated, you can proceed to the final step.

### Step 8: Push Your Initial Commit

Now that you are authenticated, you can push your initial commit to your remote repository on GitHub.

Run the following command:
```sh
git push -u origin main
```

## Keeping Your Project Up-to-Date

Your instructor may provide updates to the project files. To get these updates, you can use the `pull-updates.sh` script.

From within your development container, simply run:
```sh
./bin/pull-updates.sh
```
This script will fetch the latest changes and merge them into your `main` branch. If there are any updates to the `Dockerfile` itself, you will need to exit the container, rebuild the image (Step 4), and then restart the container (Step 5).

## MySQL Database

This development environment includes a running MySQL server. The server starts automatically when you launch the container.

You can connect to the database from within the container using the MySQL client:
```sh
mysql -u root
```
By default, the `root` user has no password. You can use this database for your development work.
