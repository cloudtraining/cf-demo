#!groovy

pipeline {
    agent any

/*
    // if we want to use a global tool instead of a wrapper script (less portable):
    tools {
        maven 'apache-maven-3.5.2'
    }
*/

    stages {
        stage('Build') {
            steps {
                sh './mvnw install'
                archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true
                junit '**/target/surefire-reports/*.xml'
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
                    credentialsId: 'pcf',
                    manifestChoice: [manifestFile: '.cloudfoundry.yml']
                )
            }
        }
    }
}
