# EC2 モジュール

AWS EC2インスタンスとその関連リソースを作成するTerraformモジュールです。

## 機能

- EC2インスタンス作成
- セキュリティグループ作成（オプション）
- キーペア作成（オプション）
- IAMロール・インスタンスプロファイル作成（オプション）
- Elastic IP作成（オプション）
- EBSボリューム設定

## 使用方法

### 基本的な使用例

```hcl
module "ec2" {
  source = "git::https://github.com/msato0731/terraform-module-monorepo-sample.git//modules/ec2"

  instance_name = "web-server"
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.public_subnets[0]

  instance_type               = "t3.micro"
  associate_public_ip_address = true
  
  # セキュリティグループ設定
  allow_ssh   = true
  allow_http  = true
  allow_https = true

  tags = {
    Environment = "production"
    Project     = "my-project"
  }
}
```

### カスタムAMIとキーペア作成の例

```hcl
module "ec2" {
  source = "git::https://github.com/msato0731/terraform-module-monorepo-sample.git//modules/ec2"

  instance_name = "custom-server"
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.private_subnets[0]

  ami_id        = "ami-0123456789abcdef0"
  instance_type = "t3.small"
  
  # キーペア作成
  create_key_pair = true
  key_name        = "my-key-pair"
  public_key      = file("~/.ssh/id_rsa.pub")
  
  # IAMロール作成
  create_iam_instance_profile = true
  iam_role_policies = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  ]

  # 追加EBSボリューム
  ebs_block_devices = [
    {
      device_name = "/dev/xvdf"
      volume_size = 100
      volume_type = "gp3"
      encrypted   = true
    }
  ]

  tags = {
    Environment = "production"
    Project     = "my-project"
  }
}
```

### 既存リソースを使用する例

```hcl
module "ec2" {
  source = "git::https://github.com/msato0731/terraform-module-monorepo-sample.git//modules/ec2"

  instance_name = "existing-resources-server"
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.private_subnets[0]

  instance_type = "t3.medium"
  key_name      = "existing-key-pair"
  
  # 既存のセキュリティグループを使用
  create_security_group = false
  security_group_ids    = ["sg-0123456789abcdef0"]
  
  # 既存のIAMインスタンスプロファイルを使用
  iam_instance_profile = "existing-instance-profile"

  tags = {
    Environment = "production"
    Project     = "my-project"
  }
}
```

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| instance_name | EC2インスタンスの名前 | `string` | n/a | yes |
| vpc_id | VPC ID | `string` | n/a | yes |
| subnet_id | サブネット ID | `string` | n/a | yes |
| ami_id | 使用するAMI ID。nullの場合、最新のAmazon Linux 2を使用 | `string` | `null` | no |
| instance_type | EC2インスタンスタイプ | `string` | `"t3.micro"` | no |
| key_name | EC2インスタンスにアクセスするためのキーペア名 | `string` | `null` | no |
| security_group_ids | 既存のセキュリティグループIDのリスト | `list(string)` | `[]` | no |
| associate_public_ip_address | パブリックIPアドレスを関連付けるかどうか | `bool` | `false` | no |
| user_data | インスタンス起動時に実行するユーザーデータスクリプト | `string` | `null` | no |
| user_data_base64 | Base64エンコードされたユーザーデータスクリプト | `string` | `null` | no |
| iam_instance_profile | 既存のIAMインスタンスプロファイル名 | `string` | `null` | no |
| create_security_group | 新しいセキュリティグループを作成するかどうか | `bool` | `true` | no |
| allow_ssh | SSH接続を許可するかどうか | `bool` | `true` | no |
| ssh_cidr_blocks | SSH接続を許可するCIDRブロック | `list(string)` | `["0.0.0.0/0"]` | no |
| allow_http | HTTP接続を許可するかどうか | `bool` | `false` | no |
| http_cidr_blocks | HTTP接続を許可するCIDRブロック | `list(string)` | `["0.0.0.0/0"]` | no |
| allow_https | HTTPS接続を許可するかどうか | `bool` | `false` | no |
| https_cidr_blocks | HTTPS接続を許可するCIDRブロック | `list(string)` | `["0.0.0.0/0"]` | no |
| custom_ingress_rules | カスタムインバウンドルール | `list(object({...}))` | `[]` | no |
| create_key_pair | 新しいキーペアを作成するかどうか | `bool` | `false` | no |
| public_key | キーペア作成時の公開鍵 | `string` | `null` | no |
| create_iam_instance_profile | 新しいIAMインスタンスプロファイルを作成するかどうか | `bool` | `false` | no |
| iam_role_policies | IAMロールにアタッチするポリシーのARNリスト | `list(string)` | `[]` | no |
| root_volume_type | ルートボリュームのタイプ | `string` | `"gp3"` | no |
| root_volume_size | ルートボリュームのサイズ（GB） | `number` | `20` | no |
| root_delete_on_termination | インスタンス終了時にルートボリュームを削除するかどうか | `bool` | `true` | no |
| root_volume_encrypted | ルートボリュームを暗号化するかどうか | `bool` | `false` | no |
| ebs_block_devices | 追加のEBSボリューム設定 | `list(object({...}))` | `[]` | no |
| create_eip | Elastic IPを作成するかどうか | `bool` | `false` | no |
| tags | リソースに適用するタグ | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance_id | EC2インスタンスのID |
| instance_arn | EC2インスタンスのARN |
| instance_state | EC2インスタンスの状態 |
| instance_type | EC2インスタンスのタイプ |
| ami_id | 使用されたAMI ID |
| availability_zone | インスタンスのアベイラビリティゾーン |
| private_ip | インスタンスのプライベートIPアドレス |
| public_ip | インスタンスのパブリックIPアドレス |
| public_dns | インスタンスのパブリックDNS名 |
| private_dns | インスタンスのプライベートDNS名 |
| security_group_ids | インスタンスに関連付けられたセキュリティグループIDのリスト |
| subnet_id | インスタンスが配置されたサブネットID |
| vpc_id | インスタンスが配置されたVPC ID |
| key_name | インスタンスに関連付けられたキーペア名 |
| iam_instance_profile | インスタンスに関連付けられたIAMインスタンスプロファイル |
| security_group_id | 作成されたセキュリティグループのID |
| security_group_arn | 作成されたセキュリティグループのARN |
| key_pair_name | 作成されたキーペアの名前 |
| key_pair_fingerprint | 作成されたキーペアのフィンガープリント |
| iam_role_arn | 作成されたIAMロールのARN |
| iam_role_name | 作成されたIAMロールの名前 |
| iam_instance_profile_arn | 作成されたIAMインスタンスプロファイルのARN |
| iam_instance_profile_name | 作成されたIAMインスタンスプロファイルの名前 |
| elastic_ip | 割り当てられたElastic IP |
| elastic_ip_allocation_id | Elastic IPのアロケーションID |
| root_block_device | ルートブロックデバイスの情報 |

## 要件

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 5.0 |