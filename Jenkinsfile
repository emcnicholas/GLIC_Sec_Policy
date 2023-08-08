// Pipeline as Code
pipeline{
    agent any
    // Environment Variables //
    environment{
        FMC_USER = credentials('fmc-user')
        FMC_PASS = credentials('fmc-pass')
        FMC_HOST = 'ec2-18-218-64-139.us-east-2.compute.amazonaws.com'
    }
    stages{
        // This stage will run Terraform Apply when "Deploy Env" is added to the commit message //
        stage('Build Environment'){
           when{
                allOf{
                    branch "main"
                }
            }
           steps{
                echo "Building Environment"
                sh 'terraform get -update'
                sh 'terraform init -upgrade'
                sh 'terraform apply -auto-approve \
                -var="fmc_user=$FMC_USER" \
                -var="fmc_pass=$FMC_PASS" \
                -var="fmc_host=$FMC_HOST"'
            }
        }
    }
}