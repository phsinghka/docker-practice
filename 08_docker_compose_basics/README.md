# Docker Compose Basics

## Project 8: Docker Compose Multi-Container Setup

This project demonstrates the use of Docker Compose to manage a multi-container application. It includes a simple web application running in a Docker container and a MySQL database in another container, both orchestrated through Docker Compose.

### Project Structure
```bash
08_docker_compose_basics/
├── web/
│   ├── Dockerfile
│   ├── app.py
│   ├── requirements.txt
│   └── templates/
│       └── index.html
├── docker-compose.yml
└── README.md
```

### Web Application

The web application is a simple Python Flask app that serves a static HTML page and connects to a MySQL database.

### Database

The MySQL database is set up with Docker Compose, with environment variables to configure the root password, database name, and user credentials.

## Prerequisites

- Docker
- Docker Compose

Ensure that both Docker and Docker Compose are installed on your machine. You can verify the installations by running:

```bash
docker --version
docker compose version
