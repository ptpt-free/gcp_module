#
# vpc module variables
# - typeは基本的にmap(map(string))
# - nullは {} で表現
# - 一部内容はdynamicを利用するため、入れ子構造を想定
#

#####################
# VPC作成時に利用する変数
#####################
variable "vpc" {
  default = {}
}

#####################
# subnet作成時に利用する変数
#####################

variable "subnet" {
  default = {}
}

#####################
# internal-ip作成時に利用する変数
#####################
variable "internal_ip" {
  default = {}
}