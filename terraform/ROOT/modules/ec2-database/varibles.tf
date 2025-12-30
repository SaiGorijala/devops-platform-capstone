variable "ami_id" {
  description = "AMI ID for EC2"
  type        = string
}

variable "subnet_id" {
  description = "Subnet where EC2 will be launched"
  type        = string
}

variable "security_group_id" {
  description = "Security group attached to EC2"
  type        = string
}
