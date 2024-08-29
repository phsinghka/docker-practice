# Pull the Nginx image
docker pull nginx

# Run Nginx container in detached mode
docker run -d --name nginx_server nginx

# View logs of the Nginx container
docker logs nginx_server

# Stream logs in real-time
docker logs -f nginx_server

# Tail the last 10 lines of logs
docker logs --tail 10 nginx_server

# View logs generated in the last 10 minutes
docker logs --since "10m" nginx_server

# Stop and remove the container when done
docker stop nginx_server
docker rm nginx_server

