provider "aws" {
  region = "eu-west-1"
}

module "vpc" {
  source = "../modules/vpc"
  env    = "staging"
}

module "ec2" {
  source      = "../modules/ec2"
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.public_subnets
  environment = "staging"
}

module "rds" {
  source      = "../modules/rds"
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.private_subnets
  environment = "staging"
}

module "s3" {
  source      = "../modules/s3"
  environment = "staging"
}

module "lambda" {
  source      = "../modules/lambda"
  s3_bucket   = module.s3.bucket_id
  environment = "staging"
}
