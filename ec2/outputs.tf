output "instance_id" {
  description = "EC2インスタンスのID"
  value       = aws_instance.main.id
}

output "instance_arn" {
  description = "EC2インスタンスのARN"
  value       = aws_instance.main.arn
}

output "private_ip" {
  description = "インスタンスのプライベートIPアドレス"
  value       = aws_instance.main.private_ip
}

output "public_ip" {
  description = "インスタンスのパブリックIPアドレス"
  value       = aws_instance.main.public_ip
}

output "security_group_id" {
  description = "セキュリティグループのID"
  value       = aws_security_group.main.id
}
