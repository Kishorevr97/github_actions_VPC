provider "aws" {
  region = "eu-north-1"
}

resource "aws_vpc" "infra" {
  cidr_block = "10.0.0.0/16"

 tags = {
    Name = "infraVPC"
  }

}

resource "aws_subnet" "infra" {
  vpc_id            = aws_vpc.infra.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-north-1a"

 tags = {
    Name = "infraSubnet"
   }
}

resource "aws_internet_gateway" "infra" {
  vpc_id = aws_vpc.infra.id

 tags = {
    Name = "infraIGW"
   }
}

resource "aws_route_table" "infra" {
  vpc_id = aws_vpc.infra.id

 tags = {
    Name = "infraRoutetable"
   }
}

resource "aws_route" "infra" {
  route_table_id         = aws_route_table.infra.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.infra.id
}

resource "aws_route_table_association" "infra" {
  subnet_id      = aws_subnet.infra.id
  route_table_id = aws_route_table.infra.id
}

