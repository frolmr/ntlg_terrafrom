output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "user_id" {
  value = data.aws_caller_identity.current.user_id
}

output "region" {
  value = data.aws_region.current.name
}

output "instance_ip_addr_0" {
  value = aws_instance.web[0].private_ip
}

output "subnet_id_0" {
  value = aws_instance.web[0].subnet_id
}
