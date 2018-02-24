#!groovy

pipeline {
    agent any

    tools {
        maven 'apache-maven-3.5.2'
    }

    stages {
        stage('Build & Test') {
            steps {
                echo 'Building...'
                sh 'mvn verify'
                archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true
            }
        }
        stage('Deploy') {
            when {
                branch 'master'
            }
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

    post {
        always {
            junit '**/target/surefire-reports/*.xml'
        }
        failure {
            mail to: 'boards+jenkinsdemo@gmail.com', subject: "${env.JOB_NAME} failed", body: "For more details: ${env.JENKINS_URL}"
        }
    }
}
