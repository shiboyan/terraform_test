provider "aws" {
  region                  = "ap-southeast-2"
  shared_credentials_file = "~/.aws/credentials"
}
module "vpc" {
  source      = "modules/vpc"
  availability_zone ="${var.availability_zone}"
}
module "subnet" {
  source      = "modules/subnet"
  availability_zone ="${var.availability_zone}"
  vpc_id            = "${module.vpc.id}"
}
module "ec2" {
  source             = "modules/ec2"
  availability_zone ="${var.availability_zone}"
  ec2_count = "${var.ec2_count}"

  key_name ="${var.key_name}"
  vpc_id            = "${module.vpc.id}"
  subnet_id            = "${module.subnet.id}"
}
module "elb" {
  source            = "modules/elb"
  vpc_id            = "${module.vpc.id}"
  subnet_ids            = "${module.subnet.ids}"
  instaces_web_ids     = "${module.ec2.ids}"
}



variable "availability_zone" {
  type = "string"
}

variable "key_name" {
  type = "string"
}
variable "ec2_count" {
default=0
}
