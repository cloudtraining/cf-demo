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
                pushToCloudFoundry(
                    target: 'api.run.pivotal.io',
                    organization: 'cloudtraining.io',
                    cloudSpace: 'development',
                    credentialsId: 'pcf'
                )
            }
        }
    }
}
