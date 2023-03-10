variable "key_name" {
  default = ""
}
variable "public_subnet_id" {
  default = ""
}
variable "privat_subnet_id" {
  default = ""
}
variable "ami" {
  default = "ami-09e1162c87f73958b"
}
variable "instance_type" {
  default = "t3.micro"
}
variable "vpc_id" {
  default = ""
}
variable "vpc_security_group" {
  default = ""
}