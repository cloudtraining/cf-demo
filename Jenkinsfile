#!groovy

pipeline {
    agent any

    // provided we install this ahead of time for the server,
    // we can use this instead of the wrapper
    tools {
        maven 'apache-maven-3.5.2'
    }

    stages {
        stage('Build & Test') {
            steps {
                echo 'Building...'
                // if we don't use the tool install, we can just use ./mvnw to download it
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
                // note that this requires the Cloud Foundry plugin which isn't a default
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
