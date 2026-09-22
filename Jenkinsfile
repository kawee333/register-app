pipeline {
    agent { label 'Jenkins-Agent' }
    
    tools {
        jdk 'Java21'
        maven 'Maven3'
    }

    stages {
        stage("Cleanup Workspace") {
            steps {
                cleanWs()
            }
        }

        stage("Checkout from SCM") {
            steps {
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
                // 'SonarQube' must match the Server Name in Manage Jenkins -> System -> SonarQube servers
                withSonarQubeEnv('SonarQube') { 
                    sh "mvn org.sonarsource.scanner.maven:sonar-maven-plugin:sonar"
                }
            }
        }

        stage("Quality Gate") {
            steps {
                // Pauses execution until SonarQube returns the Quality Gate result
                waitForQualityGate abortPipeline: true
            }
        }
    }
}
