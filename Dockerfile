# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Install required dependencies for Jenkins
RUN apt-get update && apt-get install -y openjdk-11-jdk

# Install Docker CLI
RUN apt-get install -y docker.io

# Install Jenkins
RUN wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | apt-key add -
RUN sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
RUN apt-get update && apt-get install -y jenkins

# Expose Jenkins port
EXPOSE 8080

# Start Jenkins
CMD ["java", "-jar", "/usr/share/jenkins/jenkins.war"]
