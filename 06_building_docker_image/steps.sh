mkdir 06_building_docker_image
cd 06_building_docker_image
# Create Dockerfile, app.py, and requirements.txt as described
docker build -t my-python-app .
docker run --name my-running-app my-python-app
docker logs my-running-app

