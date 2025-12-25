# VPC モジュール

AWS VPCとその関連リソースを作成するTerraformモジュールです。

## 機能

- VPC作成
- パブリック/プライベートサブネット作成
- インターネットゲートウェイ作成
- NAT Gateway作成（オプション）
- ルートテーブルとルートの設定

## 使用方法

### 基本的な使用例

```hcl
module "vpc" {
  source = "git::https://github.com/msato0731/terraform-module-monorepo-sample.git//modules/vpc"

  vpc_name        = "my-vpc"
  vpc_cidr        = "10.0.0.0/16"
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.10.0/24", "10.0.20.0/24"]

  tags = {
    Environment = "production"
    Project     = "my-project"
  }
}
```

### NAT Gateway付きの使用例

```hcl
module "vpc" {
  source = "git::https://github.com/msato0731/terraform-module-monorepo-sample.git//modules/vpc"

  vpc_name           = "my-vpc"
  vpc_cidr           = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets    = ["10.0.10.0/24", "10.0.20.0/24"]
  enable_nat_gateway = true

  tags = {
    Environment = "production"
    Project     = "my-project"
  }
}
```

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| vpc_name | VPCの名前 | `string` | n/a | yes |
| vpc_cidr | VPCのCIDRブロック | `string` | `"10.0.0.0/16"` | no |
| public_subnets | パブリックサブネットのCIDRブロックのリスト | `list(string)` | `["10.0.1.0/24", "10.0.2.0/24"]` | no |
| private_subnets | プライベートサブネットのCIDRブロックのリスト | `list(string)` | `["10.0.10.0/24", "10.0.20.0/24"]` | no |
| enable_dns_hostnames | VPCでDNSホスト名を有効にするかどうか | `bool` | `true` | no |
| enable_dns_support | VPCでDNSサポートを有効にするかどうか | `bool` | `true` | no |
| create_igw | インターネットゲートウェイを作成するかどうか | `bool` | `true` | no |
| enable_nat_gateway | NAT Gatewayを有効にするかどうか | `bool` | `false` | no |
| tags | リソースに適用するタグ | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | VPCのID |
| vpc_cidr_block | VPCのCIDRブロック |
| vpc_arn | VPCのARN |
| internet_gateway_id | インターネットゲートウェイのID |
| public_subnets | パブリックサブネットのIDリスト |
| private_subnets | プライベートサブネットのIDリスト |
| public_subnet_cidrs | パブリックサブネットのCIDRブロックリスト |
| private_subnet_cidrs | プライベートサブネットのCIDRブロックリスト |
| public_route_table_id | パブリックルートテーブルのID |
| private_route_table_ids | プライベートルートテーブルのIDリスト |
| nat_gateway_ids | NAT GatewayのIDリスト |
| nat_public_ips | NAT GatewayのパブリックIPリスト |
| availability_zones | 使用されているアベイラビリティゾーンのリスト |

## 要件

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 5.0 |
