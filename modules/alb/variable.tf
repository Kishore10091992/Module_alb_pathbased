variable "internal" {
 description = "lb internal"
 type = bool
}

variable "lb_type" {
 description = "lb type"
 type = string
}

variable "tags" {
 description = "lb tag"
 type = string
}

variable "sg_id" {
 description = "security group id"
 type = string
}

variable "subnet-1_id" {
 description = "subnet 1 id"
 type= string
}

variable "subnet-2_id" {
 description = "subnet 2 id"
 type = string
}

variable "vpc_id" {
 description = "vpcid"
 type = string
}

variable "app-1_id" {
 description = "app 1 ec2 id"
 type = string
}

variable "app-2_id" {
 description = "app 2 ec2 id"
 type = string
}
