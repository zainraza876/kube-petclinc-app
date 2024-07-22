pipeline {
    agent any

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

        stage('Build Java Application') {
            agent {
                docker {
                    image 'maven:3.8.4-openjdk-11'
                }
            }
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                script {
                    docker.image('gcr.io/kaniko-project/executor:debug').inside('--entrypoint=""') {
                        sh """
                            echo '{"auths":{"https://index.docker.io/v1/":{"auth":"'"\$(echo -n ${DOCKER_HUB_CREDS_USR}:${DOCKER_HUB_CREDS_PSW} | base64)"'"}}}' > /kaniko/.docker/config.json
                            /kaniko/executor --context `pwd` --destination ${DOCKER_HUB_REPO}:${IMAGE_TAG}
                        """
                    }
                }
            }
        }
    }
}