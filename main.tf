terraform {
 required_providers {
  aws = {
   source = "hashicorp/aws"
   version = "~>5.0"
  }
 }
}

provider "aws" {
 region = var.aws_region
}

module "vpc" {
 source = "./modules/vpc"
 vpc_cidr = "172.168.0.0/16"
 vpc_tags = { Name = "main_vpc" }
 subnet-1_cidr = "172.168.0.0/24"
 az-1 = "us-east-1a"
 sub-1_tags = { Name = "main_subnet-1" }
 subnet-2_cidr = "172.168.1.0/24"
 az-2 = "us-east-1c"
 sub-2_tags = { Name = "main_subnet-2" }
 IGW_tags = { Name = "main_IGW" }
 route_ip = "0.0.0.0/0"
 rt_tags = { Name = "main_rt" }
 app-1_eip_tags = { Name = "app-1_eip" }
 app-2_eip_tags = { Name = "app-2_eip" }
}

module "security_group" {
 source = "./modules/security_group"
 vpc_id = module.vpc.vpc_id
 from_port = 0
 to_port = 0
 protocol = "-1"
 cidr_blocks = ["0.0.0.0/0"]
 tags = { Name = "main_security_group" }
}

