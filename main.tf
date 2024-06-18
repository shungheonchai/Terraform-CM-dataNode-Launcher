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
  # token = var.session_token
}

locals {
  mongodb_automation_agent_script = <<EOF
#!/bin/bash
sudo echo "preserve_hostname: true" >> /etc/cloud/cloud.cfg
PUBLIC_DNS=$(curl http://169.254.169.254/latest/meta-data/public-hostname)
sudo hostnamectl set-hostname $PUBLIC_DNS
sudo reboot
curl -OL https://cloud.mongodb.com/download/agent/automation/mongodb-mms-automation-agent-manager-13.17.0.8870-1.x86_64.rpm
sudo rpm -U mongodb-mms-automation-agent-manager-13.17.0.8870-1.x86_64.rpm
sudo rm /etc/mongodb-mms/automation-agent.config
sudo echo "mmsGroupId=${var.MongoDB_ProjectId}" >> /etc/mongodb-mms/automation-agent.config
sudo echo "mmsApiKey=${var.MongoDB_API_key}" >> /etc/mongodb-mms/automation-agent.config
sudo echo "mmsBaseUrl=https://api-agents.mongodb.com" >> /etc/mongodb-mms/automation-agent.config
sudo echo "logFile=/var/log/mongodb-mms-automation/automation-agent.log" >> /etc/mongodb-mms/automation-agent.config
sudo echo "mmsConfigBackup=/var/lib/mongodb-mms-automation/mms-cluster-config-backup.json" >> /etc/mongodb-mms/automation-agent.config
sudo echo "logLevel=INFO" >> /etc/mongodb-mms/automation-agent.config
sudo echo "maxLogFiles=10" >> /etc/mongodb-mms/automation-agent.config
sudo echo "maxLogFileSize=268435456" >> /etc/mongodb-mms/automation-agent.config
sudo mkdir -p /data
sudo chown mongod:mongod /data
sudo yum install cyrus-sasl cyrus-sasl-gssapi \
     cyrus-sasl-plain krb5-libs libcurl \
     lm_sensors-libs net-snmp net-snmp-agent-libs \
     openldap openssl tcp_wrappers-libs xz-libs
sudo service mongodb-mms-automation-agent start
EOF
}

resource "aws_instance" "cm-demo-server" {
  ami           = var.ami
  instance_type = var.instance_type
  count         = var.num_instances
  key_name      = var.key_name
  associate_public_ip_address = true
  user_data = local.mongodb_automation_agent_script
  # vpc_security_group_ids =  var.security_group
  tags = var.tag

}