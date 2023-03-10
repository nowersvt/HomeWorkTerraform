provider "aws" {
  region = "eu-north-1"
}
module "vpc_default" {
  source = "../modules/AWS_Network"
}
module "vpc_security_group" {
  source = "../modules/AWS_SecurityGroup"
  vpc_id = module.vpc_default.vpc_id
}
module "instance_default" {
  source             = "../modules/AWS_Instances"
  key_name           = "mykey"
  vpc_security_group = module.vpc_security_group.webserver_sg_id
  vpc_id             = module.vpc_default.vpc_id
  public_subnet_id   = module.vpc_default.public_subnet_ids
  privat_subnet_id   = module.vpc_default.privat_subnet_ids
}
module "RDS" {
  source                 = "../modules/AWS_RDS"
  name_db                = "mysqlbd"
  username               = "nowa"
  password               = "000099911"
  instance_class         = "db.t3.micro"
  allocated_storage      = "20"
  subnet1                = module.vpc_default.subnet1
  subnet2                = module.vpc_default.subnet2
  vpc_security_group_ids = module.vpc_security_group.webserver_sg_id
}
