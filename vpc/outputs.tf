output "vpc_id" {
  description = "VPCのID"
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "VPCのCIDRブロック"
  value       = aws_vpc.main.cidr_block
}

output "vpc_arn" {
  description = "VPCのARN"
  value       = aws_vpc.main.arn
}

output "internet_gateway_id" {
  description = "インターネットゲートウェイのID"
  value       = aws_internet_gateway.main.id
}

output "public_subnets" {
  description = "パブリックサブネットのIDリスト"
  value       = aws_subnet.public[*].id
}

output "public_subnet_cidrs" {
  description = "パブリックサブネットのCIDRブロックリスト"
  value       = aws_subnet.public[*].cidr_block
}

output "public_route_table_id" {
  description = "パブリックルートテーブルのID"
  value       = aws_route_table.public.id
}

output "availability_zones" {
  description = "使用されているアベイラビリティゾーンのリスト"
  value       = local.azs
}
