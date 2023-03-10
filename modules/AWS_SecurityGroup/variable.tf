variable "allow_ingress_port" {
  type = list  
  default = ["22","80","443","8080"]
}
variable "vpc_id" {
  default = ""
}