locals {
  ingress_rules_web = [
    { port = 443, description = "port 443" },
    { port = 80, description = "port 80" },
    { port = 3306, description = "port 3306" }

  ]

  ingress_rules_rds = [
    { port = 3306, description = "port MYSQL" }

  ]
}

###################SG-BASTION###########################
resource "aws_security_group" "sg-bastion" {
  vpc_id      = aws_vpc.vpc-claxton.id
  name        = "SecGroupBastion"
  description = "Sec for Bastion"

  dynamic "ingress" {
    for_each = local.ingress_rules_web
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      description = ingress.value.description
      cidr_blocks = var.cidr_myip
      protocol    = var.protocol
    }
  }

  tags = {
    Name = "sg-bastion"
  }
}



###################SG-RDS###########################
resource "aws_security_group" "sg-rds" {
  vpc_id      = aws_vpc.vpc-claxton.id
  name        = "SecGroupRDS"
  description = "Sec for rds"

  dynamic "ingress" {
    for_each = local.ingress_rules_rds
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      description = ingress.value.description
      cidr_blocks = [aws_subnet.public[0].cidr_block]
      protocol    = var.protocol
    }
  }

  tags = {
    Name = "sg-rds"
  }

}