variable "vpc_cidr" {
  description = "VPC CIDR block"
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "azs" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "nat_instance_type" {
  description = "Type of EC2 instance for NAT (if NAT instance is used)"
  default     = "t3.micro"
}

variable "key_name" {
  description = "SSH key name to access instances"
  type        = string
  default     = "my-key"
}

variable "cluster_name" {
  description = "The name of the Kubernetes cluster"
  type        = string
  default     = "my-k8s-cluster" # You can set a default or pass this value at runtime
}

variable "kops_state_store" {
  description = "The S3 bucket where kOps stores its state"
  type        = string
  default     = "s3://my-kops-state-store" # Ensure this is a valid S3 bucket in your account
}

variable "dns_zone" {
  description = "The DNS zone where the Kubernetes cluster will be created"
  type        = string
  default     = "mydomain.com" # Replace with your actual domain
}