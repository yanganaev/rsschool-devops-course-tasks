# Kubernetes Cluster Deployment on AWS

## Objective

This repository contains Terraform code to deploy a Kubernetes cluster on AWS, using either kOps or k3s, and includes monitoring with Prometheus and Grafana.

## Deployment Methods

1. **kOps**: Suitable for automated cluster provisioning and management on AWS.
2. **k3s**: Lightweight Kubernetes distribution, more hands-on infrastructure management.

## Prerequisites

- AWS account
- Terraform installed
- AWS CLI configured

## Steps

1. **Set Up Terraform Code**: Provision VPC, subnets, EC2 instances, security groups.
2. **Deploy Cluster**: Choose between kOps or k3s for deployment.
3. **Verify Cluster**: Ensure the nodes are up and running.
4. **Deploy Workload**: Deploy a simple workload to verify functionality.
5. **Monitoring**: Set up Prometheus and Grafana for cluster monitoring.

## Verification

Run the following command to verify the cluster:
```bash
kubectl get nodes
