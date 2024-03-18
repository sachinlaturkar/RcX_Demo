pipeline {
    agent any
    
    parameters {
        choice(name: 'ENVIRONMENT', choices: ['Development', 'Staging', 'Production'], description: 'Select the environment for deployment')
    }
    
    environment {
        DOCKER_REPO = 'slaturka/samplespringboot:6015192b48d2f0b4997f30206da338553428d8ad'
    }
    
    stages {
        stage('Checkout') {
            steps {
                // Checkout your code from version control system (e.g., Git)
                git branch: 'master', url: 'https://github.com/sachinlaturkar/sample-springboot-jenkins.git'
            }
        }
        
        stage('Authenticate with GCP') {
            steps {
                // Authenticate with GCP using service account key
                withCredentials([file(credentialsId: 'service-account-key', variable: 'SERVICE_ACCOUNT_KEY')]) {
                    sh 'gcloud auth activate-service-account --key-file=$SERVICE_ACCOUNT_KEY'
                }
            }
        }
        
        stage('Build and push Docker image') {
            steps {
                // Build Docker image
                sh 'docker build -t $DOCKER_REPO .'
                
                // Authenticate with Docker repository
                withCredentials([usernamePassword(credentialsId: 'docker-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD $DOCKER_REPO'
                }
                
                // Push Docker image to Docker repository
                sh 'docker push $DOCKER_REPO'
            }
        }
        
        stage('Choose Environment') {
            when {
                expression {
                    // Deploy only if the environment is selected
                    return params.ENVIRONMENT != null
                }
            }
            steps {
                script {
                    // Depending on the selected environment, deploy to the corresponding target
                    switch(params.ENVIRONMENT) {
                        case 'Development':
                            deployToDevelopment()
                            break
                        case 'Staging':
                            deployToStaging()
                            break
                        case 'Production':
                            deployToProduction()
                            break
                    }
                }
            }
        }
    }
}

def deployToDevelopment() {
    // Deployment to Development environment logic
    // Example:
    // sh 'kubectl set image deployment/zb-gke bb-demo=$DOCKER_REPO:latest'
}

def deployToStaging() {
    // Deployment to Staging environment logic
    // Example:
    // sh 'kubectl set image deployment/zb-gke bb-demo=$DOCKER_REPO:latest'
}

def deployToProduction() {
    // Deployment to Production environment logic
    // Example:
    // sh 'kubectl set image deployment/zb-gke bb-demo=$DOCKER_REPO:latest'
}
