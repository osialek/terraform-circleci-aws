output "private_subnet_ids" {
  description = "The IDs of the private subnets created"
  value = aws_subnet.private_subnet01.id
}