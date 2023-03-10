resource "aws_instance" "bastion" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = var.vpc_security_group

  tags = {
    Name = "bastion"
  }
}
resource "aws_instance" "privat_instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.privat_subnet_id
  vpc_security_group_ids = var.vpc_security_group
}
resource "aws_instance" "psvat_instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.privat_subnet_id
  vpc_security_group_ids = var.vpc_security_group
}