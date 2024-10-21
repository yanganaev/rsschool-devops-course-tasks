resource "aws_instance" "k8s_nodes" {
  count         = 2  # Adjust based on how many nodes you want
  ami           = "ami-0c55b159cbfafe1f0"  # Replace with a valid AMI ID
  instance_type = "t2.micro"
  subnet_id     = element(aws_subnet.private.*.id, count.index)
  vpc_security_group_ids = [aws_security_group.k8s_sg.id]

  tags = {
    Name = "k8s-node-${count.index + 1}"
  }
}