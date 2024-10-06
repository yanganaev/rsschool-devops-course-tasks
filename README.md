# Terraform AWS S3 Bucket and DynamoDB State Management

This repository contains Terraform configurations and a GitHub Actions workflow to create an AWS S3 bucket for storing Terraform states and a DynamoDB table for locking states. Additionally, it sets up GitHub Actions with OpenID Connect (OIDC) to deploy AWS resources securely using short-lived credentials.

## Table of Contents

- [Project Overview](#project-overview)
- [Prerequisites](#prerequisites)
- [Architecture](#architecture)
- [Setup Instructions](#setup-instructions)
  - [Step 1: AWS Setup](#step-1-aws-setup)
  - [Step 2: GitHub Actions Setup](#step-2-github-actions-setup)
  - [Step 3: Terraform Configuration](#step-3-terraform-configuration)
- [GitHub Actions Workflow](#github-actions-workflow)
- [Best Practices](#best-practices)

## Project Overview

This project demonstrates how to:
- Create an AWS S3 bucket to store Terraform state files.
- Create a DynamoDB table to manage Terraform state locks.
- Configure an IAM role to allow GitHub Actions to deploy resources via Terraform using OpenID Connect (OIDC) for secure, short-lived AWS credentials.

## Prerequisites

Before you begin, make sure you have the following:
- An AWS account with the necessary permissions.
- Terraform installed locally if you plan to run it manually.
- GitHub repository where the workflow will run.
  
## Architecture

1. **S3 Bucket**: Stores the Terraform state files securely.
2. **DynamoDB Table**: Used for state locking to avoid race conditions.
3. **GitHub Actions**: Automates Terraform deployment from GitHub with OIDC authentication to assume an AWS IAM role.
  
## Setup Instructions

### Step 1: AWS Setup

1. **Create S3 Bucket**: This bucket will store your Terraform state files.
2. **Create DynamoDB Table**: Create a DynamoDB table for state locks.
   - Table Name: `terraform-state-lock`
   - Partition Key: `LockID` (String type)
3. **Create IAM Role**:
   - Go to AWS IAM Console.
   - Create a role with the following permissions:
     - `AmazonEC2FullAccess`
     - `AmazonRoute53FullAccess`
     - `AmazonS3FullAccess`
     - `IAMFullAccess`
     - `AmazonVPCFullAccess`
     - `AmazonSQSFullAccess`
     - `AmazonEventBridgeFullAccess`
   - Add a trust policy to allow GitHub OIDC to assume this role.

### Step 2: GitHub Actions Setup

1. **Configure OpenID Connect (OIDC)**:
   - Configure an OIDC identity provider in your AWS account.
   - Add a trust policy for the IAM role to allow GitHub Actions from your repository to assume the role.

2. **Update the Trust Policy**:
   Use the following trust policy in your IAM role:

   ```json
   {
     "Version": "2012-10-17",
     "Statement": [
       {
         "Effect": "Allow",
         "Principal": {
           "Federated": "arn:aws:iam::AWS_ACCOUNT_ID:oidc-provider/token.actions.githubusercontent.com"
         },
         "Action": "sts:AssumeRoleWithWebIdentity",
         "Condition": {
           "StringEquals": {
             "token.actions.githubusercontent.com:sub": "repo:yanganaev/rsschool-devops-course-tasks:ref:refs/heads/main",
             "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
           }
         }
       }
     ]
   }

### Step 3: Terraform Configuration
Clone this repository and modify the main.tf to adjust the bucket names, table names, and region.

### GitHub Actions Workflow
This repository uses a GitHub Actions workflow to automate Terraform deployment. The workflow is triggered on pull requests and pushes to the `task_1` branch.

The workflow includes the following jobs:

- **Terraform Check**: Runs `terraform fmt` to ensure that the configuration is formatted correctly.
- **Terraform Plan**: Runs `terraform plan` to create an execution plan.
- **Terraform Apply**: Runs `terraform apply` to apply the changes when pushing to `task_1`.

### Best Practices
- Secure S3 bucket: Enable versioning and server-side encryption for the bucket.
- Use IAM roles with least privilege: Ensure that the IAM role for GitHub Actions has only the necessary permissions.
- State locking: Use DynamoDB to prevent concurrent Terraform executions.

### Conclusion
This repository sets up an automated pipeline for deploying AWS resources via Terraform using GitHub Actions, leveraging OIDC for secure role assumption.
