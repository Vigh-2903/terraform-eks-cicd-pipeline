pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
    }

    stages {

        stage('AWS Identity Check') {
            steps {
                sh 'aws sts get-caller-identity'
            }
        }

        stage('Checkout SCM') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Vigh-2903/terraform-eks-cicd-pipeline.git'
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform-eks-cicd-pipeline') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir('terraform-eks-cicd-pipeline') {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('terraform-eks-cicd-pipeline') {
                    sh 'terraform plan -var-file=dev.tfvars -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform-eks-cicd-pipeline') {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Deploy Nginx Application') {
            steps {
                dir('manifest') {
                    sh 'aws eks update-kubeconfig --name my-eks-cluster --region us-east-1'
                    sh 'kubectl create namespace eks-nginx-app || true'
                    sh 'kubectl apply -f deployment.yaml'
                    sh 'kubectl apply -f service.yaml'
                }
            }
        }
    }
}
