# Step 2: Create a Docker Volume
docker volume create my_data_volume

# Step 3: Run a Container with a Mounted Volume
docker run -d --name volume_test -v my_data_volume:/app/data nginx

# Step 4: Verify the Mounted Volume
docker inspect volume_test

# (Optional) Check the contents of the mounted directory inside the container
docker exec -it volume_test ls /app/data

# Step 5: Persist Data in the Volume
docker exec -it volume_test sh -c "echo 'Hello, Docker Volumes!' > /app/data/hello.txt"

# Step 6: Stop and Remove the Container
docker stop volume_test
docker rm volume_test

# Step 7: Reattach the Volume to a New Container
docker run -it --rm -v my_data_volume:/app/data alpine cat /app/data/hello.txt

# Step 8: Clean Up
docker volume rm my_data_volume

