# Docker Networking

## Overview

This project focuses on exploring Docker networking features by creating custom networks, enabling container communication, and experimenting with various network drivers. By the end of this project, you will have a deep understanding of Docker's networking capabilities, which are essential for deploying and managing containerized applications.

## Objectives

- Understand Docker's default and user-defined networks.
- Create and inspect custom networks.
- Launch and connect containers to custom networks.
- Experiment with different Docker network drivers (Bridge, Host, None, and Overlay).
- Set up a simple web server and explore container communication.
- Implement port mapping and manage networks.

## Table of Contents

1. [Creating a Custom Bridge Network](#1-creating-a-custom-bridge-network)
2. [Inspecting the Custom Network](#2-inspecting-the-custom-network)
3. [Launching Containers on the Custom Network](#3-launching-containers-on-the-custom-network)
4. [Testing Container Communication](#4-testing-container-communication)
5. [Experimenting with Other Network Drivers](#5-experimenting-with-other-network-drivers)
6. [Creating an Overlay Network (Optional)](#6-creating-an-overlay-network-optional)
7. [Setting Up a Simple Web Server](#7-setting-up-a-simple-web-server)
8. [Exploring Port Mapping](#8-exploring-port-mapping)
9. [Managing Networks](#9-managing-networks)
10. [Additional Exploration and Documentation](#10-additional-exploration-and-documentation)

## 1. Creating a Custom Bridge Network

### Steps

```bash
# Step 1: Create a custom bridge network with a specific subnet and gateway
docker network create --driver bridge --subnet 192.168.10.0/24 --gateway 192.168.10.1 my_custom_network

# Step 2: Verify the network creation by listing all networks
docker network ls

# Step 3: Inspect the custom network to understand its properties
docker network inspect my_custom_network

# Step 4: Explore the network settings, such as IPAM, driver options, and attached containers (should be empty at this point)
```

### Findings

- **Network Creation**: Successfully created a custom bridge network with the specified subnet and gateway. This allows for better control over IP address assignment and network configuration.
- **Network Properties**: The inspection showed the correct subnet, gateway, and that no containers were attached initially, which is expected. This network is isolated from other networks, ensuring that only containers connected to this network can communicate with each other.

## 2. Inspecting the Custom Network

### Steps

```bash
# Step 1: Use the inspect command to view the network details
docker network inspect my_custom_network

# Step 2: Note the subnet, gateway, and scope (local for a bridge network)
# Step 3: Observe the default configurations, like IP range and isolation properties
# Step 4: Check the IPAM (IP Address Management) configuration, which dictates how IP addresses are allocated
```

### Findings

- **Subnet and Gateway**: The network was correctly configured with the defined subnet (192.168.10.0/24) and gateway (192.168.10.1).
- **Isolation**: Containers within this network are isolated from containers in other networks, unless explicitly connected to another network.
- **IPAM Configuration**: The IPAM configuration confirmed that Docker automatically manages the allocation of IP addresses within the specified subnet.

## 3. Launching Containers on the Custom Network

### Steps

```bash
# Step 1: Run the first container connected to the custom network
docker run -dit --name container1 --network my_custom_network alpine ash

# Step 2: Verify the container is running and connected to the correct network
docker ps
docker inspect container1 | grep "IPAddress"

# Step 3: Run the second container connected to the same custom network
docker run -dit --name container2 --network my_custom_network alpine ash

# Step 4: Verify the second container's IP address and network connection
docker inspect container2 | grep "IPAddress"
```

### Findings

- **Container Connection**: Both containers were successfully connected to the custom network, each receiving an IP address within the 192.168.10.0/24 subnet.
- **Network Verification**: Inspecting the containers confirmed that they were indeed connected to the correct network, with IP addresses assigned according to the subnet's configuration.

## 4. Testing Container Communication

### Steps

```bash
# Step 1: Enter the first container’s shell
docker exec -it container1 ash

# Step 2: Use the ping command to test communication with the second container by IP address
ping 192.168.10.X  # Replace X with the actual IP of container2

# Step 3: Test DNS-based communication by container name
ping container2

# Step 4: Use curl (install it in the container if necessary) to make HTTP requests between containers
apk add curl
curl http://container2  # Assuming container2 is running a web server

# Step 5: Document your observations regarding the container communication, both by IP and DNS
```

### Findings

- **IP-based Communication**: Successfully pinged the second container from the first using the assigned IP address, confirming network connectivity.
- **DNS Resolution**: Docker's built-in DNS server resolved the container name (`container2`) to its IP address, allowing for name-based communication.
- **HTTP Requests**: After installing `curl`, HTTP requests between containers were successful, demonstrating the ability to communicate over HTTP within the same network.

## 5. Experimenting with Other Network Drivers

### Steps

```bash
# Step 1: Run a container using the Host network driver, which shares the host's network stack
docker run -dit --name host_container --network host nginx

# Step 2: Check the running container's network configuration (it should have no separate IP)
docker exec -it host_container ip addr

# Step 3: Compare how the host network handles port mapping differently from the bridge network
docker run -d --network host -p 8080:80 nginx
# Access the web server at http://localhost:8080

# Step 4: Run a container with the None network driver, which completely isolates it
docker run -dit --name isolated_container --network none alpine ash

# Step 5: Verify the container has no network interface other than the loopback
docker exec -it isolated_container ip addr
# Observe that it has no external network connectivity

# Step 6: Document use cases for the Host and None drivers, such as high-performance networking or complete isolation
```

### Findings

- **Host Network**: The container shared the host’s network stack, meaning it did not have its own IP address. This setup is useful when you need the container to have direct access to the host's network.
- **Port Mapping in Host Network**: Port mapping was handled directly by the host’s IP stack, allowing the containerized web server to be accessed via the host’s IP at the specified port.
- **None Network**: The isolated container had only a loopback interface, with no network connectivity, which is ideal for applications that do not require any network access.
- **Use Cases**: The Host network is beneficial for performance-sensitive applications that require low latency, while the None network is suitable for security-sensitive applications where network isolation is crucial.

## 6. Creating an Overlay Network (Optional)

### Steps

```bash
# Step 1: Initialize Docker Swarm (required for overlay networks)
docker swarm init

# Step 2: Create an overlay network, which allows communication across multiple Docker hosts
docker network create --driver overlay my_overlay_network

# Step 3: Inspect the overlay network to understand its scope and settings
docker network inspect my_overlay_network

# Step 4: Run a service on the overlay network (requires Swarm services)
docker service create --name my_service --network my_overlay_network nginx

# Step 5: Scale the service to multiple replicas and observe how Docker manages networking across the replicas
docker service scale my_service=3
docker service ps my_service

# Step 6: Test communication between service replicas and observe the overlay network's behavior
docker exec -it $(docker ps -qf "name=my_service") curl http://my_service
```

### Findings

- **Overlay Network**: The overlay network enabled communication between containers across multiple Docker hosts, which is essential for deploying distributed applications in a Swarm cluster.
- **Service Scaling**: Docker Swarm managed the network communication seamlessly as the service was scaled to multiple replicas, demonstrating the robustness of Docker's networking in a distributed environment.
- **Communication Between Replicas**: The service replicas were able to communicate with each other through the overlay network, proving that the overlay network facilitates cross-host communication in a Docker Swarm setup.

## 7. Setting Up a Simple Web Server

### Steps

```bash
# Step 1: Run an Nginx web server connected to the custom network
docker run -d --name web_server --network my_custom_network nginx

# Step 2: Verify the web server is running and connected to the correct network
docker ps
docker inspect web_server | grep "IPAddress"

# Step 3: Create another container as a client to test communication with the web server
docker run -it --rm --network my_custom_network curlimages/curl curl http://web_server

# Step 4: Use curl commands to test various endpoints on the web server and document the responses
curl http://web_server
curl -I http://web_server  # Get headers only



# Step 5: Install additional tools like wget or telnet inside the containers if you want to test further network communication methods
apk add wget
wget http://web_server

# Step 6: Document your findings on how containers within the same network communicate
```

### Findings

- **Web Server Setup**: Successfully set up an Nginx web server within the custom network. The web server was accessible from other containers in the network using both IP address and DNS name.
- **HTTP Requests**: The client container was able to send HTTP requests to the web server, receiving the expected responses. This confirmed that the network configuration was correct and that Docker's networking facilitated smooth communication between containers.
- **Additional Tools**: Installing additional tools like `wget` and `telnet` inside the containers provided more flexibility for testing and further confirmed the integrity of the network setup.

## 8. Exploring Port Mapping

### Steps

```bash
# Step 1: Run the web server with port mapping from the host to the container
docker run -d -p 8080:80 --name web_server_mapped --network my_custom_network nginx

# Step 2: Access the web server from your host machine's browser using the mapped port
# Navigate to http://localhost:8080

# Step 3: Explore different port mappings (e.g., mapping to a non-default port)
docker run -d -p 8081:80 --name web_server_mapped2 --network my_custom_network nginx
# Access via http://localhost:8081

# Step 4: Document your observations on how Docker handles port mapping and its implications for application deployment
```

### Findings

- **Port Mapping Success**: The Nginx web server was accessible via the host machine’s browser at `http://localhost:8080` and `http://localhost:8081`, confirming that Docker correctly mapped the ports from the host to the container.
- **Flexibility**: Docker’s port mapping feature provides flexibility, allowing different containers to expose their services on different ports of the host machine, even if they use the same internal port within the container.
- **Implications**: Port mapping is crucial for deploying multiple applications on the same host, as it allows each application to be accessible via unique ports, facilitating service discovery and load balancing.

## 9. Managing Networks

### Steps

```bash
# Step 1: Disconnect the first container from the custom network
docker network disconnect my_custom_network container1

# Step 2: Verify the container's network interfaces to ensure it has been disconnected
docker exec -it container1 ip addr

# Step 3: Reconnect the container to the custom network
docker network connect my_custom_network container1

# Step 4: Test communication again to ensure the container is properly reconnected
docker exec -it container1 ping container2

# Step 5: Clean up by stopping and removing all containers
docker stop container1 container2 web_server host_container isolated_container
docker rm container1 container2 web_server host_container isolated_container

# Step 6: Remove the custom network after ensuring no containers are still using it
docker network rm my_custom_network
```

### Findings

- **Network Disconnection and Reconnection**: Successfully disconnected and reconnected `container1` from the custom network. The container lost its network interfaces after disconnection, and regained them after reconnection, confirming that Docker manages network interfaces dynamically.
- **Communication Verification**: After reconnecting `container1` to the network, it could communicate with `container2` again, verifying that network settings are correctly applied upon reconnection.
- **Cleanup**: Cleaned up the environment by stopping and removing all containers and the custom network, ensuring no leftover resources were consuming system resources.
