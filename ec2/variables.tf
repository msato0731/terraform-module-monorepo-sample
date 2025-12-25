variable "instance_name" {
  description = "EC2インスタンスの名前"
  type        = string
}

variable "ami_id" {
  description = "使用するAMI ID。nullの場合、最新のAmazon Linux 2023を使用"
  type        = string
  default     = null
}

variable "instance_type" {
  description = "EC2インスタンスタイプ"
  type        = string
  default     = "t3.micro"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_id" {
  description = "サブネット ID"
  type        = string
}

variable "tags" {
  description = "リソースに適用するタグ"
  type        = map(string)
  default     = {}
}
