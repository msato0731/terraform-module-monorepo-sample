# VPC モジュール

AWS VPCとパブリックサブネットを作成するシンプルなTerraformモジュールです。

## 機能

- VPC作成
- パブリックサブネット作成（複数AZ対応）
- インターネットゲートウェイ作成
- ルートテーブルとルートの設定

## 使用方法

```hcl
module "vpc" {
  source = "git::https://github.com/your-org/your-repo.git//vpc?ref=v1.0.0"

  vpc_name       = "my-vpc"
  vpc_cidr       = "10.0.0.0/16"
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]

  tags = {
    Environment = "dev"
  }
}
```

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| vpc_name | VPCの名前 | `string` | `"main"` | no |
| vpc_cidr | VPCのCIDRブロック | `string` | `"10.0.0.0/16"` | no |
| public_subnets | パブリックサブネットのCIDRブロックのリスト | `list(string)` | `["10.0.1.0/24", "10.0.2.0/24"]` | no |
| enable_dns_hostnames | VPCでDNSホスト名を有効にするかどうか | `bool` | `true` | no |
| enable_dns_support | VPCでDNSサポートを有効にするかどうか | `bool` | `true` | no |
| enable_network_address_usage_metrics | ネットワークアドレス使用量メトリクスを有効にするかどうか | `bool` | `false` | no |
| tags | リソースに適用するタグ | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | VPCのID |
| vpc_cidr_block | VPCのCIDRブロック |
| vpc_arn | VPCのARN |
| internet_gateway_id | インターネットゲートウェイのID |
| public_subnets | パブリックサブネットのIDリスト |
| public_subnet_cidrs | パブリックサブネットのCIDRブロックリスト |
| public_route_table_id | パブリックルートテーブルのID |
| availability_zones | 使用されているアベイラビリティゾーンのリスト |

## 要件

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 6.0 |
