variable "region" {
  description = "AWS region"
  default     = "eu-west-1"
}

variable "environment" {
  description = "Environment (staging or production)"
  default     = "staging"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "Public subnet CIDR blocks"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "Private subnet CIDR blocks"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "key_name" {
  description = "Key name for SSH access to EC2 instances"
}

variable "db_username" {
  description = "Username for the RDS database"
  default     = "admin"
}

variable "db_password" {
  description = "Password for the RDS database"
  default     = "admin123"
}

variable "db_secret_name" {
  description = "Secrets Manager secret name for DB credentials"
  default     = "my-db-secret"
}
