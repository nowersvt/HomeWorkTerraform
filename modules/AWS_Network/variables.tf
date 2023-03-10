variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "env" {
  default = "dev"
}
variable "public_subnet_cidrs" {
  type = list
  default = ["10.0.11.0/24","10.0.12.0/24"]
}
variable "privat_subnet_cidrs" {
  type = list
  default = ["10.0.22.0/24","10.0.23.0/24"]
}


