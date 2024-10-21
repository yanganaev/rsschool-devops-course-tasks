resource "null_resource" "k8s_cluster" {
  provisioner "local-exec" {
    command = <<EOT
      kops create cluster --name=${var.cluster_name} \
        --state=s3://${var.kops_state_store} \
        --zones=us-west-2a,us-west-2b \
        --node-count=2 \
        --node-size=t2.micro \
        --master-size=t2.micro \
        --dns-zone=${var.dns_zone} \
        --yes
    EOT
  }
}
