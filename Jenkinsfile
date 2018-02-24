#!groovy

pipeline {
    agent any

    stages {
        stage('Build & Test') {
            steps {
                echo 'Building...'
                sh './mvnw verify'
                junit '**/target/surefire-reports/*.xml'
                archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                // TODO: cf login with credentials, then cf deploy
            }
        }
    }
}
