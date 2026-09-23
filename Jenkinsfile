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
                // Sonar details දැන් pom.xml එකෙන් කෙළින්ම ලබාගනී
                withSonarQubeEnv('SonarCloud') { 
                    sh "mvn sonar:sonar"
                }
            }
        }       
    }
}
