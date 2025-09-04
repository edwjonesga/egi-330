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
docker build -t egi-330-dev-env .
```
This command creates a Docker image named `egi-330-dev-env` that contains all the necessary tools and scripts for this course.
> **Note for Linux Users:** If you get a `permission denied` error, you may need to run this command with `sudo`: `sudo docker build -t egi-330-dev-env .`.

### Step 5: Run the Container to Initialize Your Project

Next, you need to run the container to initialize your local project. This will copy the project scripts into your directory and set up your git repository.

- **For Linux and Mac:**
  ```sh
  docker run -it --rm -v "$(pwd)":/workspace egi-330-dev-env
  ```
- **For Windows (using PowerShell):**
  ```sh
  docker run -it --rm -v "${PWD}:/workspace" egi-330-dev-env
  ```
- **For Windows (using Command Prompt):**
  ```sh
  docker run -it --rm -v "%cd%":/workspace egi-330-dev-env
  ```
> **Note for Linux Users:** You may also need to run this command with `sudo`.

Once you are inside the container's shell, run the initialization script:
```sh
init.sh
```
The script will prompt you for your GitHub repository URL. After it completes, the container will exit. Your local directory will now contain all the project scripts.

### Step 6: Start Your First Development Session

Now you can start your development session. From this point onwards, you can use the convenient start script. In your terminal on your host machine, run:
```sh
./startContainer.sh
```
> **Note for Linux Users:** If you get a `permission denied` error, you may need to run this with `sudo`: `sudo ./startContainer.sh`.

### Step 7: Authenticate with GitHub

Before you can push your code, you need to perform a one-time authentication with GitHub from inside the container.
Inside the container's shell, run:
```sh
gh auth login
```
Follow the prompts, selecting `HTTPS` as your protocol and `Login with a web browser`. Copy the one-time code and open the URL in your browser on your host machine to complete the authentication.

### Step 8: Push Your Initial Commit

Now that you are authenticated, you can push the initial commit to your repository.
```sh
git push -u origin main
```

---

## Day-to-Day Workflow

Once you have completed the one-time setup above, your daily workflow is much simpler.

To start a new development session, just run the start script from your project directory:
```sh
./startContainer.sh
```
> **Note for Linux Users:** Remember to use `sudo` if required.

This will launch the container and place you in the `/workspace` directory, ready to code.

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
