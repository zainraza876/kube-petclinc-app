pipeline {
    agent {
       Docker { image "maven:3.8.4-openjdk-17"}
    }

    environment {
        DOCKER_HUB_REPO = "techiescamp/jenkins-java-app"
        IMAGE_TAG = "2.0.0"
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
                    sh 'mvn -B -Dmaven.repo.local=/root/.m2/repository clean install -DskipTests'
                }
            }
        }

        /* stage('Build and Push Docker Image') {
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
        } */
    }
}
