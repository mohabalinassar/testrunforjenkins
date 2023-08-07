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

        stage('Push to ECR') {
            environment {
                AWS_DEFAULT_REGION = 'us-east-1'
            }
            steps {
                steps {
                withAWS(credentials: 'AWS-Cred', region: AWS_DEFAULT_REGION) {
                    sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
                    sh "docker tag mysql-ython:latest ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${ECR_REPOSITORY}:${IMAGE_TAG}"
                    sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${ECR_REPOSITORY}:${IMAGE_TAG}"
                }
            }
            }
        }
    }
}
