output "subnet_id" {
  value = aws_subnet.public[0].id
}

output "security_group_bastion" {
  value = aws_security_group.sg-bastion.id
}

output "security_group_rds" {
  value = aws_security_group.sg-rds.id
}

output "db_subnet_group" {
  value = aws_db_subnet_group.private_db_group.id
}