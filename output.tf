output "hostnames" {
  description = "list of hostnames that appears on Cloud Manager"
  value       = {
    for instance in aws_instance.cm-demo-server:
    instance.public_dns => instance.instance_state
  }
}