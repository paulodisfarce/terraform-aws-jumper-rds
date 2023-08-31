
variable "security_group_public" {
  type    = list(string)
  default = []
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "subnet_id" {}
