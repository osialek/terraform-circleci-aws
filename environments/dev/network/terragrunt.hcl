terraform {
    source = "../../../modules/single-az-network/"
    extra_arguments "common_var" {
        commands  = ["apply","plan","destroy"]
        arguments = [
            "-var-file=${get_terragrunt_dir()}/../common.tfvars"
        ]
    }
    # required_var_files = [
    #   "${get_parent_terragrunt_dir()}/common.tfvars"
    # ]

}
include "root" {
    path = find_in_parent_folders()
}

inputs = {
#     instance_replica_count = 1
  environment = "${basename(dirname(get_terragrunt_dir()))}"
  public_subnet_condition = true
#     instance_type_zabbix_server="t3.medium"
#     instance_type_bastion_host="t3.medium" #medium for better desktop performance in remote sessions.
#     instance_type_workload_with_agent="t3.micro" #micro for lower costs and just demonstration of the ec2 and zabbix agent configured with user-data
}
generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region = "eu-central-1"
  default_tags {
    tags = {
      Terraform = "True"
    }
  }
}
EOF
}