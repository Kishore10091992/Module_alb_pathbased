resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  tags       = var.vpc_tags
}

resource "aws_subnet" "main_subnet-1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.sub_1-cidr
  availability_zone = var.az-1
  tags              = var.sub-1_tags
}

resource "aws_subnet" "main_subnet-2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.sub_2-cidr
  availability_zone = var.az-2
  tags              = var.sub-2_tags
}

resource "aws_internet_gateway" "main_IGW" {
  vpc_id = aws_vpc.main_vpc.id
  tags   = var.IGW_tags
}

resource "aws_route_table" "main_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = var.route_ip
    gateway_id = aws_internet_gateway.main_IGW.id
  }

  tags = var.rt_tags
}

resource "aws_route_table_association" "sub-1_rt_asso" {
  route_table_id = aws_route_table.main_rt.id
  subnet_id      = aws_subnet.main_subnet-1.id
}

resource "aws_route_table_association" "sub-2_rt_asso" {
  route_table_id = aws_route_table.main_rt.id
  subnet_id      = aws_subnet.main_subnet-2.id
}

resource "aws_network_interface" "app-1_nic" {
  subnet_id       = aws_subnet.main_subnet-1.id
  security_groups = var.sg_id
}

resource "aws_network_interface" "app-2_nic" {
  subnet_id       = aws_subnet.main_subnet-2.id
  security_groups = var.sg_id
}

resource "aws_eip" "app-1_eip" {
  domain            = "vpc"
  network_interface = aws_network_interface.app-1_nic.id
  tags              = var.app-1_eip_tags
}

resource "aws_eip" "app-2_eip" {
  domain            = "vpc"
  network_interface = aws_network_interface.app-2_nic.id
  tags              = var.app-2_eip_tags
}
