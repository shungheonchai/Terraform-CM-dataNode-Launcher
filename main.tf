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
  region  = "us-east-1"
  access_key = "ASIA6IESFAOZVQDZKZZ2"
  secret_key = "nKXDArFcFu9pCeJxDHQwJZFO8NAkyr0aTXp9r8l7"
  token = "IQoJb3JpZ2luX2VjECMaCXVzLWVhc3QtMSJHMEUCICgKGiLONmGL0FE2LvTHUiIMKH5gYAB7DGQmbQJG7fBfAiEA+4vA0DBYvp23+PqhXhZoRhjyMd7pXtoi42v3kJnuQJkqxQMIrP//////////ARAEGgw5Nzk1NTkwNTYzMDciDDYm34uAyIe2wqtQaiqZAwphAzu87t65aHMvjIclkkqVrLGhE7j5G2mgzBWh7q3q/1j0xnMWQLkB1i1bPEO0ea6lXiQENlJL65OosHT94y79Hnf9w+8O3C7egR5I921EfjcKVhVVu91zZdR9GopFwSqpQ0gLFiP8Ddk33WaPc5O72AConQDpcFd6cMxDRcFfeiVE89tyczXRJ4FF6lpnjDZUtoX86AsVMDfDWt3RcGuMQL92BqGUTLE3zbpYIv/2/qZ1/4zqI8rJXv7CdkI5Q4MTN72nvS5r9clYs4On4jZhHSgfBQgXdarbKbXNpdzpWK/l9BC/vC093DJdMlZOeYIDXN8Hckdp+HjLzrvCl0iRjcQPhSJgelI6E58xMjy0+aDpLAKMaC+1CaE1nb2JCvcND0Wt3V2NIaYLiQ23FoMTbQ0bbNWESzLxvnKI2G8zSNV0es4scxBE+WnouseAbLMdag/BpwJSmgu7ZmdzTAzqdyJU1n1Fwl3efwZD4NbbOS7/3EyTTJwgCNVaUqgIZP2HEZTmVR9ZfW3hV/S7zVEpnRvrACH5qFMw6sD9sgY6pgFoPl3A3FziW/SmRrh5HlntzjQcYcEcY/LXoO1cJDuQnNqnDJraINrWcZaeTXuy8VQjSUrrOOi+ZubimOnISIXATH7ruSIKl6/84hhPKFhEXLBFBRoN4bUGfynGokk+iaEz5v3fQ4TlJODmKV6jGKd80iVIU9vYzxiKTZrUNd07RpG1qqd/d7lX2oFMivD/4UfOFWnsuevBDdQSXBIKiJ+KdRyX3Xwn"
}

resource "aws_instance" "cm-demo-server" {
  ami           = "ami-0d191299f2822b1fa"
  instance_type = "t2.micro"
  count         = 3
  key_name      = "shawn.chai"
  associate_public_ip_address = true
  user_data = <<EOF
#!/bin/bash
curl -OL https://cloud.mongodb.com/download/agent/automation/mongodb-mms-automation-agent-manager-13.17.0.8870-1.x86_64.rpm
sudo rpm -U mongodb-mms-automation-agent-manager-13.17.0.8870-1.x86_64.rpm
sudo rm /etc/mongodb-mms/automation-agent.config
sudo echo "mmsGroupId=664f79d9388c7054f8ccb39d" >> /etc/mongodb-mms/automation-agent.config
sudo echo "mmsApiKey=664fbc5842cafc619257d9b371343f062f4a202f9af153bcd8ad74a4" >> /etc/mongodb-mms/automation-agent.config
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
#   vpc_security_group_ids = ["sg-09eed3757e813e8fb"] #this wasn't needed at all because the default inbound is open to all via ssh and tcp

  tags = {
    Name = "cm-demo-server"
    owner = "shawn.chai"
    purpose = "demo"
    expire-on = "2024-06-04"
    project = "CM Demo"
  }
}
