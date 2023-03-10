output "vpc_id" {
  value = aws_vpc.main.id
}
output "vpc_ciddr" {
  value = aws_vpc.main.cidr_block
}
output "public_subnet_ids" {
  value = aws_subnet.public_subnet[0].id
}
output "privat_subnet_ids" {
  value = aws_subnet.privat_subnet[0].id
}
output "subnet1" {
  value = aws_subnet.subnet1.id
}
output "subnet2" {
  value = aws_subnet.subnet2.id
}
#output "subnet_zone_1" {
#  value = aws_subnet.subnet1
#}
#output "subnet_zone_2" {
#  value = aws_subnet.subnet2
#}
