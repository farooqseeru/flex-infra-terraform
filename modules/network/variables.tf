variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "subnet_cidr_block" {
  type        = string
  description = "CIDR block for the Subnet"
}

variable "availability_zone" {
  type        = string
  description = "Availability Zone"
}

variable "env" {
  type        = string
  description = "Environment name (dev, uat, prod)"
}
