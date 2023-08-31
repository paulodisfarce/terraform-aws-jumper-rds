resource "aws_db_instance" "mysql_instance" {
  allocated_storage = var.allocated_storage
  storage_type      = var.storage_type

  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class

  name     = var.name
  username = var.username
  password = var.password

  parameter_group_name = var.parameter_group_name
  skip_final_snapshot  = var.skip_final_snapshot

  vpc_security_group_ids = var.security_group_rds
  db_subnet_group_name   = var.db_subnet_group



  tags = {
    Name = "mydb"
  }
}