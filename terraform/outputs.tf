output "instance_id" {
  value = aws_instance.jamulus_instance.id
}

output "public_ip" {
  value = aws_instance.jamulus_instance.public_ip
}
