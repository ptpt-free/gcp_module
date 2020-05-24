# 
# vpc resource
# 以下モジュール宣言にてmodules/vpc配下の内容を読み込み
# - VPC作成用宣言(vpc)
# - サブネット作成用宣言(subnetwork)
# - 内部IPアドレス作成用宣言(internal_ip)
# 
# 作成を行わない場合は宣言を実施しない
#

module "create_vpc_subnet_internal_ip" {
  source      = "../modules/vpc"
  vpc         = var.vpc
  subnet      = var.subnet
  internal_ip = var.internal_ip
}