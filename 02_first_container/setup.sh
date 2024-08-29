# 1. Verify Docker installation
docker --version

# 2. Pull the 'hello-world' image from Docker Hub
docker pull hello-world

# 3. Run the 'hello-world' container
docker run hello-world

# 4. List all containers (including stopped ones)
docker ps -a

# 5. Clean up (optional)
docker rm [container_id]      # Replace [container_id] with the actual ID of the container
docker rmi hello-world

