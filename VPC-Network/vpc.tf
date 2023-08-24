#Create vpc + InternetGateway + Nat
resource "aws_vpc" "VPC" {
  cidr_block       = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "VPC"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name = "gw"
  }
}

resource "aws_eip" "ip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "Nat" {
  allocation_id = aws_eip.ip.id
  subnet_id         = aws_subnet.Public_Subnet[1].id
  tags = {
    Name = "Nat"
  }
}

#Create public Subnet
resource "aws_subnet" "Public_Subnet" {
  vpc_id = aws_vpc.VPC.id
  count = var.number_of_public_subnets
  cidr_block = "${element(var.Public_subnete_cidr_block, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"
  tags = {
    Name = "Public_Subnet-${count.index}"
  }
}
#Create private Subnet
resource "aws_subnet" "Private_Subnet" {
  vpc_id     = aws_vpc.VPC.id
  count = var.number_of_private_subnets
  cidr_block = "${element(var.Private_subnete_cidr_block, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"
  tags = {
    Name = "Private_Subnet-${count.index}"
  }
}
#Create private route table
resource "aws_route_table" "Private_Route_table" {
  vpc_id     = aws_vpc.VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.Nat.id
  }
   tags = {
    Name = "Private_Route_table"
  }
}
resource "aws_route_table_association" "Private" {
  count = var.number_of_private_subnets  
  subnet_id      = aws_subnet.Private_Subnet[count.index].id
  route_table_id = aws_route_table.Private_Route_table.id
  depends_on = [aws_subnet.Private_Subnet]
}
#Create public route table
resource "aws_route_table" "Public_Route_table" {
  vpc_id     = aws_vpc.VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
   tags = {
    Name = "Public_Route_table"
  }
}
resource "aws_route_table_association" "Public" {
  count = var.number_of_public_subnets  
  subnet_id      = aws_subnet.Public_Subnet[count.index].id
  route_table_id = aws_route_table.Public_Route_table.id
  depends_on = [aws_internet_gateway.gw, aws_subnet.Public_Subnet]
}
#Security_grp
resource "aws_security_group" "SGrp" {
  lifecycle {
    ignore_changes = [name]
  }
  name   = "SGrp"
  vpc_id = aws_vpc.VPC.id
  ingress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = [var.vpc_cidr_block]
  }
  egress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
#Connect to ecr Docker - api
resource "aws_vpc_endpoint" "ecr" {
  vpc_id = aws_vpc.VPC.id
  service_name      = "com.amazonaws.us-east-1.ecr.dkr"
  vpc_endpoint_type = "Interface"
  subnet_ids          = aws_subnet.Private_Subnet.*.id

  security_group_ids = [
    aws_security_group.SGrp.id,
  ]
  private_dns_enabled = true
  tags = {
    Name = "ECR Docker"
  }
}
resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id = aws_vpc.VPC.id
  service_name = "com.amazonaws.us-east-1.ecr.api"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  subnet_ids          = aws_subnet.Private_Subnet.*.id

  security_group_ids = [
    aws_security_group.SGrp.id,
  ]

  tags = {
    Name = "ECR API"
  }
}
# CloudWatch
resource "aws_vpc_endpoint" "cloudwatch" {
  vpc_id = aws_vpc.VPC.id
  service_name = "com.amazonaws.us-east-1.logs" 
  vpc_endpoint_type = "Interface"
  subnet_ids          = aws_subnet.Private_Subnet.*.id
  private_dns_enabled = true

  security_group_ids = [
    aws_security_group.SGrp.id,
  ]

  tags = {
    Name = "CloudWatch VPC Endpoint Interface"
  }
}



