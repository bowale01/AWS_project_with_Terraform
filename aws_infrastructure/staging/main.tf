provider "aws" {
  region = var.region
}

module "vpc" {
  source      = "../modules/vpc"
  vpc_cidr    = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

module "ec2" {
  source      = "../modules/ec2"
  vpc_id      = module.vpc.vpc_id
  public_subnet_id = element(module.vpc.public_subnets, 0)
  key_name    = var.key_name
}

module "rds" {
  source                = "../modules/rds"
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnets
  db_username           = var.db_username
  db_password           = var.db_password
}

module "s3" {
  source      = "../modules/s3"
  bucket_name = "${var.environment}-sensitive-data-bucket"
}

module "lambda" {
  source                = "../modules/lambda"
  bucket_name           = module.s3.bucket_name
  secret_name           = var.db_secret_name
  s3_bucket_name        = "${var.environment}-sensitive-data-bucket"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "my-terraform-state-bucket"
  acl    = "private"
  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_object" "state" {
  bucket = aws_s3_bucket.terraform_state.bucket
  key    = "${var.environment}/terraform.tfstate"
  source = "terraform.tfstate"
  acl    = "private"
}
