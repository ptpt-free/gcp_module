# 
# vpc module
# - VPC作成(google_compute_network)
# - サブネット作成(google_compute_subnetwork)
# - 内部IPアドレス作成(google_compute_address)
# 

#####################
# VPC作成モジュール
#####################

resource "google_compute_network" "vpc-create-resource" {
  #####################
  # VPC作成用ループ
  # 作成の必要がなければresource/main.tfで宣言をしなければ何も作成されない
  # 実際の値はすべてtfvarsに記載
  #####################
  for_each = var.vpc

  #####################
  # 必ず宣言が必要な値
  #####################

  # VPC名
  name = lookup(each.value, "vpc_name", null)

  #####################
  # オプション宣言の値
  #####################

  # サブネット自動作成設定
  auto_create_subnetworks = lookup(each.value, "auto_create_subnetworks", null)

  # 作成するVPCの用途説明
  description = lookup(each.value, "description", null)

  # プロジェクト名
  project = lookup(each.value, "project_id", null)

  # 作成するVPCのルーティングモード設定
  routing_mode = lookup(each.value, "routing_mode", null)
}

#####################
# サブネット作成モジュール
#####################

resource "google_compute_subnetwork" "subnet-create-resource" {
  #####################
  # subnet作成用ループ。変数がない場合は作成されない
  # 作成の必要なければresource/main.tfで宣言をしなければ何も作成されない
  # 実際の値はすべてtfvarsに記載
  #####################
  for_each = var.subnet

  #####################
  # 必ず宣言が必要な値
  #####################

  # 作成するサブネットのIPレンジ帯(/xxとかの設定)
  ip_cidr_range = lookup(each.value, "ip_cidr_range", null)

  # 作成するサブネット名
  name = lookup(each.value, "subnet_name", null)

  # サブネットが所属するネットワーク
  # この値に関してはgoogle_compute_networkで宣言している値を参照する必要がある
  network = google_compute_network.vpc-create-resource[lookup(each.value, "subnet_self_link_network_name", null)].name

  #####################
  # オプション宣言の値
  #####################

  # 作成するサブネットの用途説明
  description = lookup(each.value, "description", null)

  # プライベートIPからGoogleサービスへアクセスするかどうかの設定
  private_ip_google_access = lookup(each.value, "private_ip_google_access", null)

  # 作成するサブネットのプロジェクトIDの指定
  project = lookup(each.value, "subnet_project", null)

  # 作成するサブネットのリージョン名
  region = lookup(each.value, "subnet_region", null)

  #####################
  # dynamic宣言
  #####################

  # サブネットのセカンダリIP設定
  dynamic "secondary_ip_range" {
    for_each = lookup(each.value, "secondary_ip_ranges", null)
    content {
      range_name    = secondary_ip_range.value.range_name
      ip_cidr_range = secondary_ip_range.value.ip_cidr_range
    }
  }
}

#####################
# 内部IP作成モジュール
#####################

resource "google_compute_address" "internal-ip-create-resource" {
  #####################
  # subnet作成用ループ。変数がない場合は作成されない
  # 作成の必要なければresource/main.tfで宣言をしなければ何も作成されない
  # 実際の値はすべてtfvarsに記載
  #####################
  for_each = var.internal_ip

  #####################
  # 必ず宣言が必要な値
  #####################

  # 作成する内部IPアドレス名
  name = lookup(each.value, "internal_ip_name", null)

  #####################
  # オプション宣言の値
  #####################

  # 静的内部IPアドレスの指定(x.x.x.xの形)
  address = lookup(each.value, "internal_ip_address", null)

  # IPアドレスのタイプ設定(Internal or External)
  # Internal : 内部IPアドレス(今回はこちらを指定)
  # External : 外部IPアドレス(regional)
  address_type = lookup(each.value, "internal_ip_address_type", null)

  # 作成する内部IPアドレスの用途説明
  description = lookup(each.value, "description", null)

  # 作成するリージョン指定
  region = lookup(each.value, "internal_ip_region", null)

  # 作成するプロジェクトIDの指定(実際に内部IPアドレスを利用するプロジェクトID)
  project = lookup(each.value, "project_id", null)

  # サブネットワーク指定
  # この値に関してはgoogle_compute_subnetworkで宣言している値を参照する必要がある
  subnetwork = google_compute_subnetwork.subnet-create-resource[lookup(each.value, "internal_ip_self_link_subnetwork_name", null)].name
}
