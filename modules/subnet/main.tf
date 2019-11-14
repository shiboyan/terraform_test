# Create a subnet to launch our instances into
resource "aws_subnet" "subnet" {
  # Use az from variables we specified
  availability_zone = "${var.availability_zone}"
  vpc_id            = "${var.vpc_id}"

  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
}
