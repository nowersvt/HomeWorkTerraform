resource "aws_security_group" "webserver" {
  name   = "WebServer_Security_Group"
  vpc_id = var.vpc_id
  dynamic "ingress" {
    for_each = var.allow_ingress_port
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}