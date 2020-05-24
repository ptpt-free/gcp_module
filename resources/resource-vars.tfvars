#
# vpc tfvars
# 実際の変数値を宣言する内容
# 基本文法
# 利用するサービス = {
#     作成するサービスの識別子(作成する名前とかでいいかと) = {
#         各種変数宣言
#     }
# }
# ex:
# vpc = {
#   test-network = {
#     vpc_name                = "test-network"
#     description             = "test-vpc-create"
#     project_id              = "create-project-id"
#     auto_create_subnetworks = false
#     routing_mode            = "REGIONAL"
#   }
# }
# 
# tfvarsの変更のみで完結するように記載しています(module内に宣言している変数がある前提)
#

vpc = {
  sample-vpc = {
    vpc_name                = "sample-vpc"
    auto_create_subnetworks = false
    routing_mode            = "GLOBAL"
    description             = "sample vpc create"
    project_id              = "sample-vpc-project"
  }
}

subnet = {
  sample-subnet-1 = {
    subnet_name                   = "sample-subnet-1"
    description                   = "sample subnet create for asia-northeast1"
    subnet_region                 = "asia-northeast1"
    subnet_project                = "sample-vpc-project"
    ip_cidr_range                 = "10.0.56.0/26"
    subnet_self_link_network_name = "sample-vpc"
    secondary_ip_ranges = [
      {
        range_name    = "sample-secondary-ip-1-1"
        ip_cidr_range = "172.2.0.0/19"
      },
      {
        range_name    = "sample-secondary-ip-1-2"
        ip_cidr_range = "172.2.32.0/19"
      }
    ]
    private_ip_google_access = true
  }
}

internal_ip = {
  sample-internal-ip = {
    internal_ip_name                      = "sample-internal-ip"
    description                           = "sample internal ip create for asia-northeast1"
    internal_ip_address                   = "10.0.56.10"
    internal_ip_region                    = "asia-northeast1"
    internal_ip_address_type              = "INTERNAL"
    internal_ip_self_link_subnetwork_name = "sample-subnet-1"
    subnetwork                            = "test-subnet-101"
    project_id                            = "sample-vpc-project"
  }
}