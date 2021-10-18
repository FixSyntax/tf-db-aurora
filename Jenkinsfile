import groovy.json.JsonOutput
import groovy.json.*

println "JOB_NAME:      " + JOB_NAME
println "JOB_BASE_NAME  " + JOB_BASE_NAME
println "BUILD_NUMBER:  " + BUILD_NUMBER

agentPipeline = "master"

switch(ENVIRONMENT) {
    case 'production':
        CREDENTIAL  = "XXXXXXXX"    
    break
    case 'development':
        CREDENTIAL  = "XXXXXXXX"
    break
}


pipeline {
    options{
        disableConcurrentBuilds()
    }
    agent {
        label "${agentPipeline}"
    }

    tools {
        terraform 'Terraform 1.0.8'
    }

    stages {
        stage('Terraform Init') {
            steps {
                script {
                    withAWS(credentials: "${CREDENTIAL}") {
                        sh 'terraform init'
                    }
                }
            }
        }

        stage ("Terraform Plan"){
            steps {
                script {
                    withAWS(credentials: "${CREDENTIAL}") {
                        sh """terraform plan -var region=${REGION} \
                                             -var username=${DB_USER_NAME} \
                                             -var password=${DB_PASS} \
                                             -var envname=${ENVNAME}-${ENVIRONMENT} \
                                             -var-file = "${ENVIRONMENT}.tfvars"
                                             --auto-approve"""                    
                    }
                }
            }
        }

        stage ("Terraform Apply"){
            steps {
                script {
                    withAWS(credentials: "${CREDENTIAL}") {
                        sh """terraform apply -var region=${REGION} \
                                              -var username=${DB_USER_NAME} \
                                              -var password=${DB_PASS} \
                                              -var envname=${ENVNAME}-${ENVIRONMENT} \
                                              -var-file = "${ENVIRONMENT}.tfvars"
                                              --auto-approve"""
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}