pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                // Your Docker build steps here using the Dockerfile
                sh 'docker build -t mohabalinasasr/mysql-ython:last .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withDockerRegistry(credentialsId: 'DockerHub-Cred', url: '') {
                    sh 'docker push your-docker-hub-username/mysql-ython:last'
                }
            }
        }
    }
}
