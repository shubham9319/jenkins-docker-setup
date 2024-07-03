## Jenkins setup Dockerfile updated
FROM bitnami/jenkins:latest
ENV JENKINS_USERNAME=admin
ENV JENKINS_PASSWORD=TestPass@1
EXPOSE 8080
