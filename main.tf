# My VPC
resource "aws_vpc" "Michael-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Michael-vpc"
  }
}

# Public subnet
resource "aws_subnet" "public_sub1" {
  vpc_id     = aws_vpc.Michael-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "public_sub1"
  }
}

# Public subnet 2
resource "aws_subnet" "public_sub2" {
  vpc_id     = aws_vpc.Michael-vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "public_sub2"
  }
}

# Private subnet
resource "aws_subnet" "private_sub1" {
  vpc_id     = aws_vpc.Michael-vpc.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "private_sub1"
  }
}

# Public subnet 2
resource "aws_subnet" "private_sub2" {
  vpc_id     = aws_vpc.Michael-vpc.id
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "private_sub2"
  }
}


# Public Route Table
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.Michael-vpc.id

  route = []

  tags = {
    Name = "public-route-table"
  }
}

# Private Route Table
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.Michael-vpc.id

  tags = {
    Name = "private-route-table"
  }
}

# Route association public

resource "aws_route_table_association" "public-route-table-association-1" {
  subnet_id      = aws_subnet.public_sub1.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public-route-table-association-2" {
  subnet_id      = aws_subnet.public_sub2.id
  route_table_id = aws_route_table.public-route-table.id
}

# Route association private

resource "aws_route_table_association" "private-route-table-association-1" {
  subnet_id      = aws_subnet.private_sub1.id
  route_table_id = aws_route_table.private-route-table.id
}

resource "aws_route_table_association" "private-route-table-association-2" {
  subnet_id      = aws_subnet.private_sub2.id
  route_table_id = aws_route_table.private-route-table.id
}


# Internet gateway

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.Michael-vpc.id

  tags = {
    Name = "IGW"
  }
}


# AWS Route

resource "aws_route" "public-igw-route" {
  route_table_id            = aws_route_table.public-route-table.id
  gateway_id                =aws_internet_gateway.IGW.id
  destination_cidr_block    = "0.0.0.0/0"
}