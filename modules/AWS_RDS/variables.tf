variable "username" {
  default = ""
}
variable "password" {
  default = ""
}
variable "name_db" {
  default = ""
}
variable "instance_class" {
  default = ""
}
variable "allocated_storage" {
  default = "20"
}
variable "subnet_id" {
  type = list(string)
  default = ["10.0.11.0/24"]
}
variable "subnet1" {
  default = ""
}
variable "subnet2" {
  default = ""
}
variable "vpc_security_group_ids" {
  default = ""
}
