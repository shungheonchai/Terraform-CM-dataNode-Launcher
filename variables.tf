variable "access_key" {
  description = "AWS access key ID"
}

variable "secret_key" {
  description = "AWS secret access key"
}

variable "session_token" {
    description = "AWS session token that may not be needed in the future when a dedicated user role is in place from AWS IAM"
}

variable "MongoDB_ProjectId" {
    description = "Project ID from Cloud Manager or Ops Manager"
}

variable "MongoDB_API_key" {
    description = "mms API Key that was created from CM or OM"
}

variable "cluster_region" {
    description = "AWS region"
}
