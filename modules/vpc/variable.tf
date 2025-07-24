variable "vpc_cidr" {
  description = "cidr for vpc"
  type        = string
}

variable "sub_1-cidr" {
  description = "1st subnet cidr"
  type        = string
}

variable "az-1" {
  description = "availability zone 1"
  type        = string
}

variable "sub_2-cidr" {
  description = "2nd subnet cidr"
  type        = string
}

variable "az-2" {
  description = "availability zone 2"
  type        = string
}

variable "vpc_tags" {
  description = "tags"
  type        = map(string)
}

variable "sub-1_tags" {
  description = "tags"
  type        = map(string)
}

variable "sub-2_tags" {
  description = "tags"
  type        = map(string)
}

variable "IGW_tags" {
  description = "tags"
  type        = map(string)
}

variable "app-1_eip_tags" {
  description = "tags"
  type        = map(string)
}

variable "app-2_eip_tags" {
  description = "tags"
  type        = map(string)
}

variable "rt_tags" {
  description = "tags"
  type        = map(string)
}

variable "route_ip" {
  description = "route ip"
  type        = string
}

variable "sg_id" {
  description = "security group id"
  type        = list(string)
}
