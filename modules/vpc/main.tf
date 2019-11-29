# Create a VPC to launch our instances into
resource "aws_vpc" "vpc" {
  cidr_block           = "10.172.0.0/16"
  enable_dns_hostnames = true
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

