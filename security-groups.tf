# Security group for Bastion Host
resource "aws_security_group" "bastion_sg" {
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere. Restrict to your IP for security.
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Bastion Security Group"
  }
}

resource "aws_security_group" "k8s_sg" {
  vpc_id = aws_vpc.main_vpc.id  # Reference your VPC

  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow access to the Kubernetes API
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.public[0].cidr_block]  # Allow SSH access from public subnet 1
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }

  tags = {
    Name = "k8s-security-group"
  }
}
