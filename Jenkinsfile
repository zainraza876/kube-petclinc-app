pipeline {
    agent {
        kubernetes {
            label 'agent'
            defaultContainer 'maven'
            yaml """
apiVersion: v1
kind: Pod
metadata:
  namespace: jenkins
spec:
  containers:
  - name: maven
    image: maven:3.8.5-jdk-8
    command:
    - cat
    tty: true
  - name: kaniko
    image: gcr.io/kaniko-project/executor:debug
    command:
    - cat
    tty: true
"""
        }
    }

    environment {
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
                container('maven') {
                    sh 'mvn clean package'
                }
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                container('kaniko') {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_HUB_USR', passwordVariable: 'DOCKER_HUB_PSW')]) {
                    script {
                            sh """
                                echo '{"auths":{"https://index.docker.io/v1/":{"auth":"'"\$(echo -n ${DOCKER_HUB_USR}:${DOCKER_HUB_PSW} | base64)"'"}}}' > /kaniko/.docker/config.json
                                /kaniko/executor --dockerfile="/Dockerfile" --context `pwd` --destination ${DOCKER_HUB_REPO}:${IMAGE_TAG}
                            """
                        }
                    }
                }
            }
        }
    }
}