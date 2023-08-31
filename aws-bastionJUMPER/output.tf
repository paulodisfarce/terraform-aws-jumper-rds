output "ip_public" {
  value = aws_instance.bastion.public_ip
}

output "dns" {
  value = aws_instance.bastion.public_dns
}