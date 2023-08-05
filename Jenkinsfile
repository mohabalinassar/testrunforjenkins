pipeline {
    agent any
    
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image from the Dockerfile
                    docker.withRegistry('docker.io', 'DockerHub-Cred') {
                        def customImage = docker.build('test:last', '.')
                        customImage.push()
                    }
                }
            }
        }
        
        stage('Deploy with docker-compose') {
            steps {
                // Install docker-compose in the Jenkins agent
                sh "apt update && apt install -y docker-compose"
                
                // Run docker-compose to deploy the stack
                sh "docker-compose up -d"
            }
        }
    }
}
