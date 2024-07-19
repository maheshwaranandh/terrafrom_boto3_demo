variable "aws_region" {
  description = "The AWS region where resources are created"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0b72821e2f351e396" # amazon linux 2023
}

variable "instance_type" {
  description = "The type of the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "key_pair_name" {
  description = "The name of the key pair to access the EC2 instance"
  type        = string
  default     = "testing-key-pair"
}

variable "volume_size" {
  description = "The size of the EBS volume in GB"
  type        = number
  default     = 8
}