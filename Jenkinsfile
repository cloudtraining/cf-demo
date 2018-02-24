#!groovy

pipeline {
    agent any

    stages {
        stage('Build & Test') {
            steps {
                echo 'Building...'
                sh './mvnw verify'
                archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true
            }
        }
        stage('Deploy') {
            steps {
                when {
                    expression {
                        env.BRANCH_NAME == 'master'
                    }
                }
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
