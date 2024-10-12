# Terraform Infrastructure Setup for Kubernetes

## Objective

This project contains Terraform code to configure basic networking infrastructure required for a Kubernetes (K8s) cluster, including a VPC, subnets, and instances.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Terraform Code Structure](#terraform-code-structure)
- [Steps to Setup](#steps-to-setup)
- [Verify Configuration](#verify-configuration)
- [Additional Information](#additional-information)

## Prerequisites

1. **Terraform**: Ensure you have Terraform installed on your machine. You can download it from the [Terraform website](https://www.terraform.io/downloads.html).
2. **AWS CLI**: Ensure you have the AWS CLI installed and configured with your AWS credentials. You can download it from the [AWS CLI website](https://aws.amazon.com/cli/).
3. **Access to AWS Account**: You need permissions to create VPCs, subnets, security groups, and EC2 instances.

## Terraform Code Structure

The Terraform code is organized into several files for better organization:

- `main.tf`: Contains the main configuration for the VPC, subnets, and routing.
- `variables.tf`: Defines all the variables used in the Terraform configuration.
- `bastion.tf`: Configuration for the Bastion Host instance.
- `dummy_host.tf`: Configuration for the Dummy Host instance.
- `security_groups.tf`: Configuration for security groups.
- `outputs.tf`: Contains output variables to display useful information after deployment.

## Steps to Setup

### 1. Write Terraform Code

Create Terraform code to configure the following resources:

#### VPC
- Create a VPC for the Kubernetes cluster.

#### Subnets
- Create **2 public subnets** in different Availability Zones (AZs).
- Create **2 private subnets** in different Availability Zones (AZs).

#### Internet Gateway
- Attach an Internet Gateway to the VPC for external access.

#### Routing Configuration
- Configure routing such that:
  - Instances in all subnets can reach each other.
  - Instances in public subnets can reach addresses outside the VPC and vice-versa.

#### Bastion Host
- Create a Bastion Host instance for secure access to the private subnets.
- Create a Dummy Host instance in the private network to test the connection from the Bastion Host.

### 2. Organize Code

#### Define Variables
- Define variables in a separate `variables.tf` file to make the code more modular and easy to manage.

#### Separate Resources
- Organize resources into different files to improve readability and maintainability.

### 3. Verify Configuration

1. **Initialize Terraform**:
   Run the following command to initialize Terraform and download necessary providers:

   ```bash
   terraform init
   
2. **Check the Terraform Plan**:
    Execute the following command to review the resources that will be created:

    ```bash
    terraform plan
    
3. **Apply the Configuration**:
   If the plan looks good, apply the configuration:

   ```bash
   terraform apply
   
4. **Confirm the Changes**:
   Type ```yes``` when prompted to confirm the changes.

5. **View Outputs**:
   After applying the configuration, you can view the output variables to find useful information like the public IP of your Bastion Host.

**Additional Information**
Make sure to clean up your resources after testing to avoid incurring charges. 
You can destroy all resources created by Terraform using:
    
    terraform destroy
