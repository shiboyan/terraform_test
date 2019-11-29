provider "aws" {
  region     = "ap-southeast-2"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
  #shared_credentials_file = "~/.aws/credentials"
}

module "vpc" {
  source            = "./modules/vpc"
  availability_zone = var.availability_zone
}

module "subnet" {
  source            = "./modules/subnet"
  environment        = var.environment
  igw_id             = module.vpc.igw
  availability_zone = var.availability_zone
  vpc_id            = module.vpc.id
  cidrs              = var.subnet_cidrs
}

module "ec2" {
  source            = "./modules/ec2"
  availability_zone = var.availability_zone
  ec2_count         = var.ec2_count

  private_key_path = var.private_key_path
  key_name         = var.key_name
  vpc_id           = module.vpc.id
  subnet_ids       = module.subnet.ids
}

module "alb" {
  source           = "./modules/alb"
  vpc_id           = module.vpc.id
  subnet_ids       = module.subnet.ids
  instaces_web_ids = module.ec2.ids
}

variable "availability_zone" {
  type = "list"
}

variable "private_key_path" {
  type = "string"
}

variable "key_name" {
  type = "string"
}

variable "ec2_count" {
  default = 0
}
variable "subnet_cidrs" {
   type = "list"
}
variable "environment" {
  default = ""
}
