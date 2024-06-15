terraform {
  backend "s3" {
    bucket = "my-terraform-state-bucket"
    key    = "${var.environment}/terraform.tfstate"
    region = var.region
  }
}
