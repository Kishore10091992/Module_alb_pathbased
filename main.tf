terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source         = "./modules/vpc"
  vpc_cidr       = "172.168.0.0/16"
  vpc_tags       = { Name = "main_vpc" }
  sub_1-cidr     = "172.168.0.0/24"
  az-1           = "us-east-1a"
  sub-1_tags     = { Name = "main_subnet-1" }
  sub_2-cidr     = "172.168.1.0/24"
  az-2           = "us-east-1c"
  sub-2_tags     = { Name = "main_subnet-2" }
  IGW_tags       = { Name = "main_IGW" }
  route_ip       = "0.0.0.0/0"
  sg_id          = [module.security_group.sg_id]
  rt_tags        = { Name = "main_rt" }
  app-1_eip_tags = { Name = "app-1_eip" }
  app-2_eip_tags = { Name = "app-2_eip" }
}

module "security_group" {
  source      = "./modules/security_group"
  vpc_id      = module.vpc.vpc_id
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  tags        = { Name = "main_security_group" }
}

data "aws_ami" "ec2_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
}

resource "tls_private_key" "generate_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "main_key" {
  key_name   = "main_key"
  public_key = tls_private_key.generate_key.public_key_openssh

  tags = {
    Name = "main_key"
  }
}

module "app-1" {
  source         = "./modules/app-1"
  ami_id         = data.aws_ami.ec2_ami.id
  instance_type  = "t2.micro"
  key_name       = aws_key_pair.main_key.key_name
  app-1_nic_id   = module.vpc.app-1_nic_id
  app_1_userdata = <<-EOF
                     #!/bin/bash
                     yum update -y
                     amazon-linux-extras install nginx1 -y
                     systemctl enable nginx
                     systemctl start nginx
                     mkdir -p /usr/share/nginx/html/app-1
                     echo "This is app-1" > /usr/share/nginx/html/app-1/index.html
                EOF
  tags           = { Name = "app-1_ec2" }
}

module "app-2" {
  source         = "./modules/app-2"
  ami_id         = data.aws_ami.ec2_ami.id
  instance_type  = "t2.micro"
  key_name       = aws_key_pair.main_key.key_name
  app-2_nic_id   = module.vpc.app-2_nic_id
  app_2_userdata = <<-EOF
                     #!/bin/bash
                     yum update -y
                     amazon-linux-extras install nginx1 -y
                     systemctl enable nginx
                     systemctl start nginx
                     mkdir -p /usr/share/nginx/html/app-1
                     echo "This is app-2" > /usr/share/nginx/html/app-1/index.html
                   EOF
  tags           = { Name = "app-2_ec2" }
}

module "alb" {
  source        = "./modules/alb"
  internal      = true
  lb_type       = "application"
  sg_id         = module.security_group.sg_id
  sub_1_id      = module.vpc.sub_1_id
  sub_2_id      = module.vpc.sub_2_id
  lb_tags       = { Name = "main_alb" }
  vpc_id        = module.vpc.vpc_id
  app-1_tg_tags = { Name = "app-1_tg" }
  app-1_id      = module.app-1.app-1_id
  app-2_tg_tags = { Name = "app-1_tg" }
  app-2_id      = module.app-2.app-2_id
}

