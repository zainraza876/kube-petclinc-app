pipeline {
    agent {
        kubernetes {
            label 'agent'
        }
    }

    environment {
        DOCKER_HUB_CREDS = credentials('docker-hub-credentials')
        DOCKER_HUB_REPO = "aswinvj/kube-petclinic"
        IMAGE_TAG = "1.0.0"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build with Maven') {
            steps {
                container('maven:3.8.5-jdk-8') {
                    sh 'mvn clean package'
                }
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                container('gcr.io/kaniko-project/executor:debug') {
                script {
                        sh """
                            echo '{"auths":{"https://index.docker.io/v1/":{"auth":"'"\$(echo -n ${DOCKER_HUB_CREDS_USR}:${DOCKER_HUB_CREDS_PSW} | base64)"'"}}}' > /kaniko/.docker/config.json
                            /kaniko/executor --dockerfile="/Dockerfile" --context `pwd` --destination ${DOCKER_HUB_REPO}:${IMAGE_TAG}
                        """
                    }
                }
            }
        }
    }
}