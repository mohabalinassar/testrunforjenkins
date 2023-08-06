pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                // Your Docker build steps here using the Dockerfile
                sh 'docker build -t mohabalinassar/mysql-ython:last .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withDockerRegistry(credentialsId: 'DockerHub-Cred', url: 'https://index.docker.io/v1/') {
                    sh 'docker push mohabalinassar/mysql-ython:last'
                }
            }
        }
    }
}
