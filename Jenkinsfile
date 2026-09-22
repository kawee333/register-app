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
                // 'SonarCloud' යනු Jenkins -> System හි configure කළ Server name එකයි
                withSonarQubeEnv('SonarCloud') { 
                    sh """
                        mvn sonar:sonar \
                          -Dsonar.organization=YOUR_SONAR_CLOUD_ORG_KEY \
                          -Dsonar.projectKey=YOUR_SONAR_CLOUD_PROJECT_KEY \
                          -Dsonar.host.url=https://sonarcloud.io
                    """
                }
            }
        }

        stage("Quality Gate") {
            steps {
                // SonarCloud Analysis එක ඉවර වී Result එක එනතෙක් බලයි
                timeout(time: 5, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
    }
}
