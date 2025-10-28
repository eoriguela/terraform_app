variable "perfil" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "private_subnet" {
  type = string
}

variable "private_subnet-2" {
  type = string
}

variable "vpc_aws_az" {
  default = "us-east-1a"
}

variable "vpc_aws_az-2" {
  default = "us-east-1b"
}
output "ec2_id" {
  description = "ID de la instancia EC2"
  value       = aws_instance.ac1_instance.id
}

output "ec2_dns" {
  description = "DNS público de la instancia EC2"
  value       = aws_instance.ac1_instance.public_dns
}

output "ec2_public_ip" {
  description = "IP pública de la instancia EC2"
  value       = aws_instance.ac1_instance.public_ip
}

output "lb_dns" {
  description = "DNS público del Load Balancer"
  value       = aws_lb.ac1_lb.dns_name
}

variable "ami" {
  description = "AMI utilizada para lanzar la instancia EC2"
  type        = string
}