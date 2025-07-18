variable "vpc_cidr" {
 description = "cidr for vpc"
 type = string
}

variable "sub_1-cidr" {
 description = "1st subnet cidr"
 type = string
}

variable "az-1" {
 description = "availability zone 1"
 type = string
}

variable "sub_2-cidr" {
 description = "2nd subnet cidr"
 type = string
}

variable "az-2" {
 description = "availability zone 2"
 type = string
}

variable "tags" {
 description = "tags"
 type = string
}

variable "main_sg" {
 description = "sg id"
 type = string
}

variable "route_ip" {
 description = "route ip"
 type = string
}
