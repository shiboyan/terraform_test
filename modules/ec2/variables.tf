variable "vpc_id" {
  description = "VPC id to place to subnet into"
}

variable "subnet_ids" {
  type        = "list"
  description = "List of private subnet IDs"
}


variable "availability_zone" {
  description = "put availability zone"
}

variable "key_name" {
  description = "put key name"
}

variable "private_key_path" {
  description = "put private key path"
}

variable "ec2_count" {
  #default=2
  description = "put ec2 count"
}

