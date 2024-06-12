terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = var.cluster_region
  access_key = var.access_key
  secret_key = var.secret_key
  token = var.session_token
}

resource "aws_instance" "cm-demo-server" {
  ami           = var.ami
  instance_type = var.instance_type
  count         = var.num_instances
  key_name      = var.key_name
  associate_public_ip_address = true
  user_data = var.mongodb_automation_agent_script #This is the custom script that needs to be migrated to a remote-exec
  # vpc_security_group_ids =  var.security_group
  tags = var.tag

}