resource "aws_subnet" "subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = element(var.cidrs, count.index)
  availability_zone = element(var.availability_zone, count.index)
  count             = length(var.cidrs)

}



resource "aws_route_table" "table" {
  vpc_id = var.vpc_id
  count  = length(var.cidrs)

  tags ={
    Name        = "minasubnet_${element(var.availability_zone, count.index)}"
    Environment = var.environment
  }
}


resource "aws_route" "public_igw_route" {
  count                  = length(var.cidrs)
  route_table_id         = element(aws_route_table.table.*.id, count.index)
  gateway_id             = var.igw_id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "subnet" {
  subnet_id      = element(aws_subnet.subnet.*.id, count.index)
  route_table_id = element(aws_route_table.table.*.id, count.index)
  count          = length(var.cidrs)
}
