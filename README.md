# AWS-IAC Using Terraform (Execise 1 )

## Preface
This project demonstrates how to deploy an AWS Infrastructure to host web application using Terraform. 

## Install
Perform the following steps:
1. Download and install AWS CLI, Ensure AWS Credentials are Correct.
1. Download and install Terraform.

 You need an AWS account to deploy the infrastructure.

## Steps

1. Customize Variables
    ```bash
    #Modify the variables.tf files in the respective modules to configure:
    VPC
    Subnets
    EC2
    S3
    API Gateway
    Lambda Function
    RDS Database
    Route53 
    ```

1. Run the following command to initialize Terraform 
    ```bash
    #which downloads the necessary provider plugins

    terraform init
    ```


1. plan the Terraform Configuration
    ```bash
    #to make the infrastructure plan
    #Terraform will show a plan of the changes that will be made. 
    #Type yes to confirm and start the deployment.

    terraform plan
    ```

1. Apply the Terraform Configuration
    ```bash
    # used to deploy the infrastructure:
    terraform apply
    ```

Once the infrastructure is deployed,  
Terraform will output the API Gateway URL and other relevant details.

1. Test the API
    ```bash
    #use the domain to make requests to the API. For example:

    curl https://www.vois.com/rds
    ```

1. Clean Up the Infrastructure (Tear Down)
    ```bash
    #remove all the infrastructure created by this project

    terraform destroy
    ```

## Infrastructure Provisioned

1. VPC
1. 2 Subnets
1. RDS Postgresql Database
1. Route53 domain
1. Lambda Function
1. API Gateway (Rest API)







