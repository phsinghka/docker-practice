# Step 1: Pull the Nginx image from Docker Hub
docker pull nginx

# Step 2: Run a container in detached mode
docker run -d --name my_nginx nginx

# Step 3: List all running containers
docker ps

# Step 4: Stop the running container
docker stop my_nginx

# Step 5: Start the stopped container
docker start my_nginx

# Step 6: Restart the container
docker restart my_nginx

# Step 7: Remove the container
docker rm my_nginx

# Step 8: Clean up unused resources
docker system prune

