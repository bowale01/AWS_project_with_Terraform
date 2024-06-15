variable "s3_bucket" {
  description = "The S3 bucket to read CSV files from"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}
