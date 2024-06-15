variable "vpc_id" {
  description = "The ID of the VPC"
}

variable "private_subnet_ids" {
  description = "A list of private subnet IDs"
}

variable "db_username" {
  description = "The username for the database"
}

variable "db_password" {
  description = "The password for the database"
}
