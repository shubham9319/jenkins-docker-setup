# Setting Up Jenkins with Docker and Docker Compose: A Comprehensive Guide

## Introduction
Jenkins is a widely used open-source automation server that helps automate parts of the software development process, including building, testing, and deploying code. This guide will walk you through setting up Jenkins using Docker and Docker Compose.

## Prerequisites
Before you begin, make sure you have the following installed on your machine:

- Docker: Download and install Docker from the official Docker website. Ensure Docker is running on your machine.

- Docker Compose: Docker Compose is included with Docker Desktop for Windows and macOS. For Linux, follow the installation instructions on the Docker Compose website.

- Basic Understanding of Docker and Docker Compose: Familiarity with basic Docker and Docker Compose concepts will help you understand the setup process.

### Step-by-Step Guide
1. Create a Dockerfile

First, create a Dockerfile to define the Jenkins setup:

Dockerfile:
```
FROM bitnami/jenkins:latest
ENV JENKINS_USERNAME=admin
ENV JENKINS_PASSWORD=TestPass@1
EXPOSE 8080
```

- FROM bitnami/jenkins
: Uses the Bitnami Jenkins image as the base image.
- ENV JENKINS_USERNAME=admin: Sets the initial Jenkins username.
- ENV JENKINS_PASSWORD=TestPass@1: Sets the initial Jenkins password.
- EXPOSE 8080: Exposes port 8080 for Jenkins.

2. Build the Docker Image

Open a terminal and navigate to the directory containing your Dockerfile. Run the following command to build the Docker image:

```
docker build -t my-jenkins:latest .
```
- docker build: Command to build a Docker image.
- -t my-jenkins
: Tags the image with the name my-jenkins and the tag latest.
- .: Specifies the current directory as the build context.

3. Run the Jenkins Container

After building the image, run a container using the following command:

```
docker run -d --name jenkins-container -p 8080:8080 my-jenkins:latest
```

- docker run: Command to run a Docker container.
- -d: Runs the container in detached mode.
- --name jenkins-container: Names the container jenkins-container.
- -p 8080:8080: Maps port 8080 of the host to port 8080 of the container.
- my-jenkins
: Specifies the image to use for the container.

4. Create a Docker Compose File

Create a `jenkins.yml` file to define the Jenkins service and configuration:

```
version: '3.8'
services:
  jenkins:
    image: bitnami/jenkins
    container_name: jenkins-setup
    ports:
      - '8080:8080'
      - '443:8443'
    environment:
      - JENKINS_USERNAME=$jenkins_username
      - JENKINS_PASSWORD=$jenkins_password
    env_file:
      - ./.env
    volumes:
      - '$PWD/Jenkins_data:/bitnami/jenkins'
      
networks:
  jenkins-network:
    driver: bridge

volumes:
  jenkins_data:
    driver: local
```

* version: '3.8': Specifies the version of the Docker Compose file format.
* services: Defines the services that make up the application. Here, it's the Jenkins service.
* jenkins: Defines the Jenkins service configuration.
  - image: Uses the Bitnami Jenkins image.
  - container_name: Names the container jenkins-setup.
  - ports: Maps host ports to container ports.
  - environment: Sets environment variables for Jenkins.
  - env_file: Specifies the file containing environment variables.
  - volumes: Mounts a volume for persistent Jenkins data.
* networks: Defines a custom network for the Jenkins service.
* volumes: Defines a named volume for Jenkins data.

5. Create an Environment Variables File

Create a .env file to store environment variables securely:

```
jenkins_username=admin
jenkins_password=TestPass@1
```

6. Run Docker Compose

Open a terminal, navigate to the directory containing your Dockerfile, jenkins.yml, and .env files, and run the following command:

```
docker-compose -f jenkins.yml up -d
```
This command starts the Jenkins container in detached mode.

7. Access Jenkins

Open a web browser and navigate to http://localhost:8080. You should see the Jenkins setup screen. Use the credentials defined in the .env file (admin / TestPass@1) to log in.

8. Persist Jenkins Data

The volume mapping ($PWD/Jenkins_data:/bitnami/jenkins) in the jenkins.yml file ensures that Jenkins data is stored persistently on your host machine. This means that even if you stop and remove the Jenkins container, your Jenkins data will remain intact.

### Note
This is a raw Jenkins setup without any additional plugins or security features. To make your Jenkins instance production-ready, you must:

Install Required Plugins: Jenkins' functionality can be extended using plugins. Install the plugins necessary for your CI/CD pipeline.
Configure Security: Implement security best practices, including setting up proper user authentication and authorization.

### Conclusion
By following this guide, you have successfully set up Jenkins using Docker and Docker Compose. This setup provides a reproducible and isolated environment for running Jenkins, making it easier to manage and scale your CI/CD infrastructure. Remember to enhance this basic setup by adding necessary plugins and security configurations as per your requirements.
