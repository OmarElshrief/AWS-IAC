resource "aws_vpc" "vois" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.vois.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = var.public_az
  map_public_ip_on_launch = true 
  tags = {
    Name = var.public_subnet_name
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.vois.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.private_az
  tags = {
    Name = var.private_subnet_name
  }
}


resource "aws_internet_gateway" "vois" {
  vpc_id = aws_vpc.vois.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vois.id
  tags = {
    Name = var.public_route_table_name
  }
}

resource "aws_route" "public_internet_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vois.id
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vois.id
  tags = {
    Name = var.private_route_table_name
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
