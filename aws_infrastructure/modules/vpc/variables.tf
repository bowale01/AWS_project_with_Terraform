variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
}

variable "public_subnets" {
  description = "A list of public subnet CIDR blocks"
}

variable "private_subnets" {
  description = "A list of private subnet CIDR blocks"
}
