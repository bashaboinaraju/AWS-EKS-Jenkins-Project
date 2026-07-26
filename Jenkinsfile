pipeline {

    agent any

    options {
        timestamps()
        ansiColor('xterm')
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '20'))
    }

    environment {

        AWS_REGION = "us-east-1"

        IMAGE_TAG = "${BUILD_NUMBER}"

        AWS_ACCOUNT_ID = credentials('aws-account-id')

        ECR_REGISTRY = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"

    }

    triggers {

        githubPush()

    }

    stages {

        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Make Scripts Executable') {
            steps {
                sh 'chmod +x scripts/*.sh'
            }
        }

        stage('Detect Changed Services') {
            steps {
                sh './scripts/detect-changes.sh'
            }
        }

        stage('Configure AWS') {
            steps {

                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                credentialsId: 'aws-creds']]) {

                    sh '''
                    aws sts get-caller-identity
                    '''

                }

            }
        }

        stage('Login ECR') {

            steps {

                sh './scripts/ecr-login.sh'

            }

        }

        stage('Build Docker Images') {

            steps {

                sh "./scripts/build.sh ${IMAGE_TAG} ${ECR_REGISTRY}"

            }

        }

        stage('Push Docker Images') {

            steps {

                sh "./scripts/push.sh ${IMAGE_TAG} ${ECR_REGISTRY}"

            }

        }

        stage('Update Kubernetes YAML') {

            steps {

                sh "./scripts/update-manifest.sh ${IMAGE_TAG} ${ECR_REGISTRY}"

            }

        }

        stage('Commit Changes') {

            steps {

                withCredentials([string(credentialsId: 'github-token',
                variable: 'TOKEN')]) {

                    sh """

                    ./scripts/git-push.sh ${TOKEN}

                    """

                }

            }

        }

    }

    post {

        success {

            echo "Deployment Completed"

        }

        failure {

            echo "Deployment Failed"

        }

        always {

            sh 'docker image prune -af'

            cleanWs()

        }

    }

}