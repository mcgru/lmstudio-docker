# LMStudio Docker Deployment

This repository contains the necessary files to run [LMStudio](https://lmstudio.ai), an application for language model interaction, within a Docker container. The setup includes configuration files for both the entry point script, health check, Docker Compose file, Dockerfile, and HTTP server configuration.


## Introduction
LMStudio is a tool designed for interacting with language models, providing a seamless experience through a web interface. This setup uses Docker to containerize the application and deployment tools like Docker Compose for easy management of multiple containers.

## Prerequisites
Before you begin, ensure that your system meets the following requirements:
- [Docker](https://docs.docker.com/get-docker/) installed on your machine.
- Docker Compose (usually included with Docker Engine).
- A suitable environment to run the LMStudio container (e.g., a Linux server or local machine capable of running Docker containers).

### Docker Engine
Installation steps for Docker Engine:

```bash
# Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update

sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl status docker
```

## Getting Started
1. Clone this repository to your local machine:
    ```bash
    git clone https://github.com/mcgru/lmstudio-docker.git LMStudio
    cd LMStudio
    ```
2. Review the `docker-compose.yml` file to ensure it meets your requirements. Adjust any environment variables or paths as necessary.
3. Download the LMStudio installer:
    ```bash
    wget https://lmstudio.ai/download/latest/linux/x64 -O LM-Studio-latest.AppImage
    ```
    (originally was: wget https://installers.lmstudio.ai/linux/x64/0.3.36-1/LM-Studio-0.3.36-1-x64.AppImage )
4. Build and run the Docker containers using:
    ```bash
    docker compose up -d --build
    ```

## Configuration

Configuration settings are managed via environment variables and configuration files as follows:
- **Environment Variables**: Set these in the Docker Compose file or directly in the `.env` file if used.
  - `DOMAIN_NAME`: Domain name of your host (need for traefik labels) (originally was 'lmstudio.${DOMAIN}).

  - `GPU_USAGE`: Defines usage of GPU. [0.0-1.0|max|off] or empty.
  - `CONTEXT_LENGTH`: Defines the context length for model interactions.
  - `MODEL_PATH`: Path to the specific language model to be loaded.
  - `MODEL_IDENTIFIER`: Identifier for the loaded model.


## Running the Services
To start the services defined in `docker-compose.yml`, use the following command from the project directory:
```bash
docker compose up -d
```
This command will run the containers in detached mode, allowing you to continue using your terminal without interruption.

To stop the services, use:
```bash
docker compose down
```

## Setup models

Go inside continer and set up models via `lms` utility:
```bash
docker exec -it lmstudio  lms
```

### Get models
Get remote list of models , choose and download:
```bash
docker exec -it lmstudio  lms get
```

### Load models
Load (choice) locally downloaded models to the memory(?) LM Studio:
```bash
docker exec -it lmstudio  lms load
```

### Check models are exported
Load (choice) locally downloaded models to the memory(?) LM Studio:
```bash
docker exec -it lmstudio  curl http://127.0.0.1:1234/v1/models
```


## Troubleshooting
If you encounter issues during setup or usage:
1. Check the logs for errors:
   ```bash
   docker compose logs -f lmstudio
   ```
2. Ensure all required environment variables are set correctly in the Docker Compose file or `.env` file.
3. Verify that the container is running:
   ```bash
   docker ps
   ```
4. To check services via lms-cli, use:
```bash
docker exec -it lmstudio  lms    ## ls, load, status, etc...
```
5. With poor computing power (RAM), the problem may occur with auto-loading models.
So after container restart, reload models manually:
```bash
docker exec -it lmstudio  lms load
```

## Contributing
Contributions to this project are welcome. Please open an issue for bugs or feature requests and submit a pull request with proposed changes. For major changes, please discuss them in advance.
