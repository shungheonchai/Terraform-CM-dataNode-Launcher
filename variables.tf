variable "access_key" {
  description = "AWS access key ID"
  type = string
}

variable "secret_key" {
  description = "AWS secret access key"
  type = string
}

variable "session_token" {
    description = "AWS session token that may not be needed in the future when a dedicated user role is in place from AWS IAM"
    type = string
}

variable "MongoDB_ProjectId" {
    description = "Project ID from Cloud Manager or Ops Manager"
    type = string
}

variable "MongoDB_API_key" {
    description = "mms API Key that was created from CM or OM"
    type = string
}

variable "cluster_region" {
    description = "AWS region"
    type = string
    default = "us-east-1"
}

variable "mongodb_automation_agent_script" {
    description = "the long script..."
    type = string
    #may need to look at way to use template for this in the future
}

variable "num_instances" {
  description = "How many EC2 instances to spin up"
  type = number
  default = 1
}

variable "ami" {
  description = "Type of AMI. Default is Amazon Linux 2 x86"
  type = string
  default = "ami-0d191299f2822b1fa"
}

variable "instance_type" {
  description = "EC2 instance type"
  type = string
  default = "t2.micro"
}

variable "tag" {
  description = "Tags that would allow the reaper to take action on the expire-on"
  type = map(string)
  default = {
    Name = "cm-demo-server"
    owner = "shawn.chai"
    purpose = "demo"
    expire-on = "2024-06-05"
    project = "CM Demo"
  }
}

variable "security_group" {
  description = "network security that allows SSH and TCP connecition on the correct port. May need to restrict this even further"
  type = list(string)
  default = ["sg-09eed3757e813e8fb"]
  #doesn't necessarily help anything because even without this variable, the automatic configuration is open to all connections
}

variable "key_name" {
  description = "Name of the person asking to provision"
  type = string
  default = "shawn.chai"
}