provider "aws" {
  region = var.location
}

resource "aws_instance" "demo-server" {
 ami = var.os_name
 key_name = var.key 
 instance_type  = var.instance-type
 associate_public_ip_address = true
 subnet_id = aws_subnet.demo_subnet-1.id
 vpc_security_group_ids = [aws_security_group.demo-vpc-sg.id]
 tags = {
     Name = "demo-server"
 }
}

// Create VPC
resource "aws_vpc" "demo-vpc" {
  cidr_block = var.vpc-cidr
  tags = {
    Name = "demo-vpc"
  }
}

// Create Subnet
resource "aws_subnet" "demo_subnet-1" {
  vpc_id     = aws_vpc.demo-vpc.id 
  cidr_block = var.subnet1-cidr
  availability_zone = var.subent_az

  tags = {
    Name = "demo_subnet-1"
  }
}

resource "aws_subnet" "demo_subnet-2" {
  vpc_id     = aws_vpc.demo-vpc.id 
  cidr_block = var.subnet2-cidr
  availability_zone = var.subent2_az

  tags = {
    Name = "demo_subnet-2"
  }
}
// Create Internet Gateway

resource "aws_internet_gateway" "demo-igw" {
  vpc_id = aws_vpc.demo-vpc.id

  tags = {
    Name = "demo-igw"
  }
}

resource "aws_route_table" "demo-rt" {
  vpc_id = aws_vpc.demo-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo-igw.id
  }
  tags = {
    Name = "demo-rt"
  }
}

// associate subnet with route table 
resource "aws_route_table_association" "demo-rt_association-1" {
  subnet_id      = aws_subnet.demo_subnet-1.id 

  route_table_id = aws_route_table.demo-rt.id
}

resource "aws_route_table_association" "demo-rt_association-2" {
  subnet_id      = aws_subnet.demo_subnet-2.id 

  route_table_id = aws_route_table.demo-rt.id
}
// create a security group 

resource "aws_security_group" "demo-vpc-sg" {
  name        = "demo-vpc-sg"
 
  vpc_id      = aws_vpc.demo-vpc.id

  ingress {

    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
resource "aws_db_subnet_group" "demo_db_subnet_group" {
  name        = "demo-db-subnet-group"
  description = "Demo DB subnet group"
  subnet_ids = [aws_subnet.demo_subnet-1.id,aws_subnet.demo_subnet-2.id]
}

module "eks_sgs" {
  source = "./sg_eks"
  vpc_id = aws_vpc.demo-vpc.id 
}

module "eks" {
  source = "./eks"
  sg_ids = module.eks_sgs.security_group_public
  vpc_id = aws_vpc.demo-vpc.id
  subnet_ids = [aws_subnet.demo_subnet-1.id,aws_subnet.demo_subnet-2.id]

}

module "redis" {
  source = "./redis"
  vpc_id = aws_vpc.demo-vpc.id
  subnet_ids = [aws_subnet.demo_subnet-1.id,aws_subnet.demo_subnet-2.id]

}

module "rds" {
  source = "./rds"
  # db_subnet_group_name = aws_db_subnet_group.demo_db_subnet_group
  
}

# module "kafka" {
#   source = "./kafka"
# }




