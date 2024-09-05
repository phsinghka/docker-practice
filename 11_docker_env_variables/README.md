
# Project 11: Docker Environment Variables

## Project Overview

This project focuses on learning how to pass and manage environment variables within Docker containers and Docker Compose. Environment variables are a key component in configuring containers for various environments without changing the underlying code. This project teaches how to:
- Pass environment variables directly into Docker containers.
- Utilize environment variables within Dockerfiles.
- Configure services using environment variables in Docker Compose.
- Securely manage sensitive data using a `.env` file.

## What I Learned

### 1. **Passing Environment Variables in Docker CLI**
   - Learned how to pass environment variables using the `-e` flag when running a Docker container.
   - Example:
     ```bash
     docker run -e NAME=John alpine sh -c 'echo "Hello, $NAME!"'
     ```
   - This allowed me to dynamically change configuration values inside the container without modifying the code.

### 2. **Using Environment Variables in a Dockerfile**
   - Explored how to set environment variables inside a Dockerfile using the `ENV` instruction.
   - Defined default values for environment variables that can be overridden at runtime.
   - Example Dockerfile:
     ```Dockerfile
     FROM node:14-alpine
     ENV GREETING="Hello, World!"
     CMD ["sh", "-c", "echo $GREETING"]
     ```

   - Built and ran the image with default values and learned to override them at runtime:
     ```bash
     docker run -e GREETING="Hello, Docker!" env-test
     ```

### 3. **Working with Docker Compose and Environment Variables**
   - Used Docker Compose to pass environment variables to multiple services in a `docker-compose.yml` file.
   - Created a simple multi-container application with an `nginx` web server and a PostgreSQL database, each configured through environment variables.
   - Example `docker-compose.yml`:
     ```yaml
     version: '3'
     services:
       web:
         image: nginx
         ports:
           - "${NGINX_PORT}:80"
         environment:
           - NGINX_PORT=${NGINX_PORT}
       db:
         image: postgres
         environment:
           POSTGRES_USER: ${DB_USER}
           POSTGRES_PASSWORD: ${DB_PASSWORD}
         volumes:
           - db_data:/var/lib/postgresql/data
     volumes:
       db_data:
     ```

### 4. **Using a `.env` File for Sensitive Data**
   - Learned how to use a `.env` file to store sensitive information like database credentials and environment-specific configurations.
   - Created a `.env` file to hold variables:
     ```bash
     NGINX_PORT=8080
     DB_USER=myuser
     DB_PASSWORD=mypassword
     ```

   - Docker Compose automatically loads values from the `.env` file and substitutes them in the `docker-compose.yml`.

### 5. **Overriding Environment Variables**
   - Experimented with overriding environment variables at runtime using Docker Compose:
     ```bash
     docker-compose run -e NGINX_PORT=9090 web
     ```
   - This allows flexibility in how services are configured depending on the environment or use case.