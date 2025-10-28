resource "aws_vpc" "vpc_ac1" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-ac1"
  }
}

resource "aws_subnet" "ac1_public_subnet" {
  vpc_id                  = aws_vpc.vpc_ac1.id
  cidr_block              = var.private_subnet
  availability_zone       = var.vpc_aws_az
  map_public_ip_on_launch = true

  tags = {
    Name = "ac1-public-subnet"
  }
}

resource "aws_subnet" "ac1_public_subnet_2" {
  vpc_id                  = aws_vpc.vpc_ac1.id
  cidr_block              = var.private_subnet-2
  availability_zone       = var.vpc_aws_az-2
  map_public_ip_on_launch = true

  tags = {
    Name = "ac1-public-subnet-2"
  }
}

resource "aws_internet_gateway" "ac1_igw" {
  vpc_id = aws_vpc.vpc_ac1.id

  tags = {
    Name = "ac1-igw"
  }
}

resource "aws_route_table" "ac1_rt" {
  vpc_id = aws_vpc.vpc_ac1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ac1_igw.id
  }

  tags = {
    Name = "ac1-rt"
  }
}

resource "aws_route_table_association" "ac1_rt_assoc_1" {
  subnet_id      = aws_subnet.ac1_public_subnet.id
  route_table_id = aws_route_table.ac1_rt.id
}

resource "aws_route_table_association" "ac1_rt_assoc_2" {
  subnet_id      = aws_subnet.ac1_public_subnet_2.id
  route_table_id = aws_route_table.ac1_rt.id
}