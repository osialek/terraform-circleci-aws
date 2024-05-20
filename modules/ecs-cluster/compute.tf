# AMI used by Web & Database servers
data "aws_ami" "ubuntu_2204_latest" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  owners = ["099720109477"] # <-- Canonical
}
# Fetch current Region
data "aws_region" "current" {}
locals {
  region = data.aws_region.current.name
}
# module "network" {
#     # source = "../single-az-network/"
#     source = "../single-az-network"
#     environment = var.environment
# }
# Deploy EC2 for Zabbix Server with user-data script execution to configure Zabbix server on it
resource "aws_instance" "zabbix_server_1" {
  ami                         = data.aws_ami.ubuntu_2204_latest.id
  instance_type               = "t2.micro"
  subnet_id                   = var.vpc_private_subnet_ids
#   key_name                    = aws_key_pair.generated.key_name
  associate_public_ip_address = false
#   vpc_security_group_ids      = [aws_security_group.sg_zabbix_server.id]
#   user_data                   = file("./user-data/zabbix-user-data.sh")
  tags = {
    Name        = "${var.environment}-server-1"
    # Service     = var.app_identifier
    Environment = var.environment
  }
}