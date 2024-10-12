resource "aws_instance" "bastion" {
  ami             = "ami-0e472ba40eb589f49"  # Updated with the correct AMI ID for your region
  instance_type   = "t3.micro"
  key_name        = var.key_name
  subnet_id       = aws_subnet.public[0].id
  associate_public_ip_address = true

  tags = {
    Name = "Bastion Host"
  }

  security_groups = [aws_security_group.bastion_sg.id]
}
