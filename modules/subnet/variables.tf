variable "vpc_id" {
  description = "VPC id to place to subnet into"
}

//variable "availability_zone" {
//  description = "put availability zone"
//}
variable "availability_zone" {
  type        = "list"
  description = "List of avalibility zones you want. Example: eu-west-1a and eu-west-1b"
}

variable "cidrs" {
  type        = "list"
  description = "List of cidrs, for every avalibility zone you want you need one. Example: 10.0.0.0/24 and 10.0.1.0/24"
}

variable "environment" {
  default = ""
}
variable "igw_id" {
  default = ""
}