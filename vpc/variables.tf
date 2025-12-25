variable "vpc_name" {
  description = "VPCの名前"
  type        = string
}

variable "vpc_cidr" {
  description = "VPCのCIDRブロック"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "パブリックサブネットのCIDRブロックのリスト"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "enable_dns_hostnames" {
  description = "VPCでDNSホスト名を有効にするかどうか"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "VPCでDNSサポートを有効にするかどうか"
  type        = bool
  default     = true
}

variable "enable_network_address_usage_metrics" {
  description = "VPCでネットワークアドレス使用量メトリクスを有効にするかどうか"
  type        = bool
  default     = false
}

variable "tags" {
  description = "リソースに適用するタグ"
  type        = map(string)
  default     = {}
}
