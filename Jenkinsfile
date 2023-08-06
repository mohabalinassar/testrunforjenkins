pipeline {
    agent any

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

        stage('Deploy with docker-compose') {
            steps {
                // Install docker-compose in the Jenkins agent (if not already installed)
                sh "apt update && apt install -y docker-compose"

                // Run docker-compose to deploy the stack
                sh "docker-compose up -d"
            }
        }
    }
}
