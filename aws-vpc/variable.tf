variable "cidr_vpc" {}
variable "cidr_world" {}
variable "protocol" {}
variable "cidr_myip" {}

variable "private_subnet" {
  type = map(any)
}

variable "public_subnet" {
  type = map(any)
}