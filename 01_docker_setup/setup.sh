# Update packages
sudo apt-get update

# Install dependencies
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common

# Add Docker’s GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add Docker repository
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Update the package list
sudo apt-get update

# Install Docker
sudo apt-get install docker-ce

# Verify Docker service status
sudo systemctl status docker

# Manage Docker as a non-root user
sudo groupadd docker
sudo usermod -aG docker $USER

# Log out and back in, then run Docker without sudo
docker run hello-world

