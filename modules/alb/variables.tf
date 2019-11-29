variable "vpc_id" {
  description = "VPC id to place to subnet into"
}

variable "subnet_ids" {
  type        = "list"
  description = "List of public subnet IDs"
}

variable "instaces_web_ids" {
  type    = "list"
  description = "List of instances IDs"
}
