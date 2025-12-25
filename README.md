# Terraform Module Monorepo

AWS インフラストラクチャ用の Terraform モジュールを管理するサンプルリポジトリです。

## モジュール一覧

| モジュール | 説明 |
|-----------|------|
| [VPC](./vpc) | VPC、パブリックサブネット、インターネットゲートウェイを作成 |
| [EC2](./ec2) | EC2インスタンスとセキュリティグループを作成 |

## 要件

- Terraform >= 1.0
- AWS Provider >= 6.0


## モジュール構造

```text
.
├── vpc/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
└── ec2/
    ├── main.tf
    ├── variables.tf
    └── outputs.tf
```
