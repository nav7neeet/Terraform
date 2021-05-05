output "aws-instance-id" {
  value = aws_instance.main.id
}

output "eip-instance-id" {
  value = aws_eip.main.instance
}