resource "aws_s3_bucket" "sensitive_data" {
  bucket = "${var.environment}-sensitive-data-bucket"
  acl    = "private"

  versioning {
    enabled = true
  }
}
