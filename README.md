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

### Step 3: Clone the Project Repository

Instead of downloading individual files, clone the entire project setup repository to your local machine. Open a terminal and run:
```sh
git clone https://github.com/edwjonesga/egi-330.git
cd egi-330
```
This will download all the necessary scripts and the `Dockerfile`.

### Step 4: Build the Docker Image

Now, run the build script to create your Docker environment.
```sh
./buildContainer.sh
```
> **Note for Linux Users:** If you get a `permission denied` error, you may need to run this command with `sudo`: `sudo ./buildContainer.sh`. This is because your user may not have permission to interact with the Docker service.

### Step 5: Start the Container and Initialize

Next, start the container. The first time you run it, it will launch an initialization script.
```sh
./startContainer.sh
```
> **Note for Linux Users:** You may also need to run this command with `sudo`: `sudo ./startContainer.sh`.

The `init.sh` script will run automatically. It will prompt you to enter the HTTPS URL for the empty GitHub repository you created in Step 1. After you provide the URL, the script will finish, and the container will stop.

### Step 6: Start Your Development Session

Run the start script again to begin your development session.
```sh
./startContainer.sh
```
You will now be inside the container's shell, in the `/workspace` directory, ready to work.

### Step 7: Authenticate with GitHub

Before you can push your code, you need to perform a one-time authentication with GitHub.
Inside the container, run:
```sh
gh auth login
```
Follow the prompts:
- **What account do you want to log into?** Select `GitHub.com`.
- **What is your preferred protocol for Git operations?** Select `HTTPS`.
- **Authenticate Git with your GitHub credentials?** Select `Y` (Yes).
- **How would you like to authenticate?** Select `Login with a web browser`.

Copy the one-time code, open the provided URL in your browser on your host machine, and paste the code to authorize the CLI.

### Step 8: Push Your Initial Commit

Now that you are authenticated, you can push the initial commit to your repository.
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
