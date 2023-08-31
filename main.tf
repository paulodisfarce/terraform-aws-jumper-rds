data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}


module "aws-vpc" {
  source     = "./aws-vpc"
  cidr_vpc   = "198.168.0.0/16"
  cidr_world = "0.0.0.0/0"


  private_subnet = {
    us-east-1a = "198.168.1.0/24"
    us-east-1b = "198.168.2.0/24"
    us-east-1c = "198.168.3.0/24"
  }

  public_subnet = {
    us-east-1a = "198.168.101.0/24"
  }

  protocol  = "tcp"
  cidr_myip = ["${chomp(data.http.myip.body)}/32"]


}

module "aws-rds" {
  source            = "./aws-rdsMYSQL"
  allocated_storage = 20
  storage_type      = "gp2"

  engine         = "mysql"
  engine_version = "5.7"
  instance_class = "db.t2.micro"

  name                 = "mydb"
  username             = "admin"
  password             = "mydbpassword"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true

  security_group_rds = [module.aws-vpc.security_group_rds]
  db_subnet_group    = module.aws-vpc.db_subnet_group

}

module "aws-bastion" {
  source = "./aws-bastionJUMPER"

  instance_type = "t2.micro"
  key_name      = "aws-class-1"


  subnet_id             = module.aws-vpc.subnet_id
  security_group_public = [module.aws-vpc.security_group_bastion]
}