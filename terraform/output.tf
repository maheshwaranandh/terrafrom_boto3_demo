output "instance_id" {
  description="instance id of the ec2"
  value=aws_instance.web_server.id
}

output "instance_public_ip" {
  description="public IP the ec2"
  value=aws_instance.web_server.public_ip
}

output "security_group_id" {
  description="id of the security group"
  value=aws_security_group.web_sg.id
}

