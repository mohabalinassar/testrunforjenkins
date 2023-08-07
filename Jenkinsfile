pipeline {
    agent any

        environment {
        AWS_DEFAULT_REGION = 'us-east-1'
        ECR_REPOSITORY = 'ecr-repo'
        IMAGE_TAG = 'latest'
    }
    
    stages {
        stage('Build Docker Image') {
            steps {
                // Your Docker build steps here using the Dockerfile
                sh 'docker build -t mohabalinassar/final-sprints-project:last .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withDockerRegistry(credentialsId: 'DockerHub-Cred', url: 'https://index.docker.io/v1/') {
                    sh 'docker push mohabalinassar/final-sprints-project:last'
                }
            }
        }

        stage('Push to ECR') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'AWS-Cred' // Use the correct credential ID for AWS credentials
                ]]) {
                    withAWS(region: AWS_DEFAULT_REGION) {
                        sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
                        sh "docker tag your_image_name_here:latest ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${ECR_REPOSITORY}:${IMAGE_TAG}"
                        sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${ECR_REPOSITORY}:${IMAGE_TAG}"
                    }
                }
            }
        }
    }
}
