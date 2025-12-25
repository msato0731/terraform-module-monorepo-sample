terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
    }
  }
}

# 最新のAmazon Linux 2023 AMIを取得
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# セキュリティグループ
resource "aws_security_group" "main" {
  name_prefix = "${var.instance_name}-sg-"
  description = "Security group for ${var.instance_name}"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = "${var.instance_name}-sg" })

  lifecycle {
    create_before_destroy = true
  }
}

# EC2インスタンス
resource "aws_instance" "main" {
  ami                    = coalesce(var.ami_id, data.aws_ami.amazon_linux.id)
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.main.id]

  metadata_options {
    http_tokens = "required"
  }

  tags = merge(var.tags, { Name = var.instance_name })
}
