variable "service_name" {
  description = "Name of the microservice"
  type        = string
}

variable "ami_id" {
  description = "AMI ID to use for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "EC2 key pair name for SSH access"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the instance will be deployed"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for security group attachment"
  type        = string
}

variable "secret_name" {
  description = "Name of the secret in AWS Secrets Manager"
  type        = string
}

variable "docker_port" {
  description = "Port exposed by the Docker container"
  type        = number
  default     = 8000
}

variable "enable_https" {
  description = "Whether to configure HTTPS using Let's Encrypt"
  type        = bool
  default     = false
}

variable "domain_name" {
  description = "Domain name used for HTTPS"
  type        = string
  default     = ""
}
