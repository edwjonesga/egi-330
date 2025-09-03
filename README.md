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

### Step 5: Run the Docker Container

Next, run the container. This command will start an interactive shell inside the container and mount your current directory to the `/workspace` directory inside the container. This means any files you create in `/workspace` will appear in your local directory, and vice-versa.

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

You are now inside the Docker container's shell.

### Step 6: Initialize Your Project

Inside the container's shell, run the `init.sh` script to set up your project:

```sh
init.sh
```

The script will ask for the GitHub repository URL you copied in Step 1. Paste it in and press Enter. The script will then:
1.  Copy the project files into your directory.
2.  Initialize a local Git repository.
3.  Set your GitHub repository as the `origin` remote.

After the script finishes, you can push your new repository to GitHub by running:
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
