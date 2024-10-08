variable "access_key" {
  description = "AWS access key ID"
  type = string
}

variable "secret_key" {
  description = "AWS secret access key"
  type = string
}

variable "session_token" {
    description = "AWS session token. Only needed when you are using this script yourself and not from the Specialist"
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

variable "num_instances" {
  description = "How many EC2 instances to spin up"
  type = number
  default = 3
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
    Name = "DEFAULT-cm-demo-server"
    owner = "Automated terraform default"
    purpose = "Default"
    expire-on = "2000-01-01"
    project = "Default Value"
  }
}

# Below doesn't necessarily help anything because even without this variable, the automatic configuration is open to all connections
# variable "security_group" {
#   description = "network security that allows SSH and TCP connecition on the correct port. May need to restrict this even further"
#   type = list(string)
#   default = ["sg-09eed3757e813e8fb"]
# }

variable "key_name" {
  description = "Name of the person asking to provision"
  type = string
  default = "DEFAULT"
}