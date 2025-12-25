# EC2 モジュール

AWS EC2インスタンスを作成するシンプルなTerraformモジュールです。

## 機能

- EC2インスタンス作成
- セキュリティグループ作成（アウトバウンドのみ許可）
- Amazon Linux 2023 AMI自動取得

## 使用方法

```hcl
module "ec2" {
  source = "git::https://github.com/your-org/your-repo.git//ec2?ref=v1.0.0"

  instance_name = "my-instance"
  instance_type = "t3.micro"
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.public_subnets[0]

  tags = {
    Environment = "dev"
  }
}
```

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| instance_name | EC2インスタンスの名前 | `string` | n/a | yes |
| vpc_id | VPC ID | `string` | n/a | yes |
| subnet_id | サブネット ID | `string` | n/a | yes |
| ami_id | 使用するAMI ID。nullの場合、最新のAmazon Linux 2023を使用 | `string` | `null` | no |
| instance_type | EC2インスタンスタイプ | `string` | `"t3.micro"` | no |
| tags | リソースに適用するタグ | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance_id | EC2インスタンスのID |
| instance_arn | EC2インスタンスのARN |
| private_ip | インスタンスのプライベートIPアドレス |
| public_ip | インスタンスのパブリックIPアドレス |
| security_group_id | セキュリティグループのID |

## 要件

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 6.0 |
