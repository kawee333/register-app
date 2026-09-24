pipeline {
    agent { label 'Jenkins-Agent' }
    
    tools {
        jdk 'Java21'
        maven 'Maven3'
    }

    environment {
        IMAGE_NAME = 'kawee333/my-app'
        REGISTRY_CREDENTIALS_ID = 'docker-hub-credentials'
    }

    stages {
        stage("Checkout from SCM") {
            steps {
                cleanWs() // Clean workspace right before checking out code
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/kawee333/register-app.git'
            }
        }

        stage("Build & Test Application") {
            steps {
                sh "mvn clean package"
            }
        }

        stage("SonarQube Analysis") {
            steps {
                withSonarQubeEnv('SonarCloud') { 
                    sh "mvn sonar:sonar"
                }
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    def appImage = docker.build("${IMAGE_NAME}:${BUILD_NUMBER}")
                    
                    // Log in to Docker Hub and push tags
                    docker.withRegistry('https://index.docker.io/v1/', REGISTRY_CREDENTIALS_ID) {
                        appImage.push("${BUILD_NUMBER}")
                        appImage.push("latest")
                    }
                }
            }
        }
    }

    post {
        always {
            // Clean up local images from the Jenkins agent to save disk space
            sh "docker rmi ${IMAGE_NAME}:${BUILD_NUMBER} ${IMAGE_NAME}:latest || true"
            // Clean up workspace after build completes
            cleanWs()
        }
    }
}
