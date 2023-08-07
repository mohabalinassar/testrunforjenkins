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
                 script {
                    def awsCli = tool 'AWS CLI' // Use the correct tool name configured in Jenkins
                    sh "docker tag mohabalinassar/mysql-ython:last ${aws_account_id}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/test-repo:latest"
                    withAWS(region: 'your_aws_region_here', tool: awsCli) {
                        sh "aws ecr get-login-password | docker login --username AWS --password-stdin ${aws_account_id}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
                        sh "docker push ${aws_account_id}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/test-repo:latest"
                    }
                }
            }
        }
    }
}
