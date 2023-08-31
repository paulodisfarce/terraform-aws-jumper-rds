output "host-rds-mysql" {
  value = module.aws-rds.host-rds
}

output "domain-rds-mysql" {
  value = module.aws-rds.domain-rds
}

output "username-rds-mysql" {
  value = module.aws-rds.username-rds
}

output "db-rds-mysql" {
  value = module.aws-rds.db-rds
}

output "dns-bastion" {
  value = module.aws-bastion.dns
}

output "ip-bastion" {
  value = module.aws-bastion.ip_public
}
