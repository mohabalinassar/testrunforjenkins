pipeline {
    agent {
        docker {
            // Use the Jenkins Docker image that has Docker CLI installed
            image 'jenkins/jenkins:lts'
            // Mount the Docker socket from the host into the Jenkins container
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image from the Dockerfile
                    def customImage = docker.build('mohabalinassar/mysql-ython:last', '.')
                    
                    // Push the Docker image to Docker Hub
                    docker.withRegistry('https://index.docker.io/v1/', 'DockerHub-Cred') {
                        customImage.push()
                    }
                }
            }
        }

        // Add more stages for testing, deployment, etc.
        // ...

    }
}
