variable "internal" {
  description = "lb internal"
  type        = bool
}

variable "lb_type" {
  description = "lb type"
  type        = string
}

variable "lb_tags" {
  description = "lb tag"
  type        = map(string)
}

variable "app-1_tg_tags" {
  description = "lb tag"
  type        = map(string)
}

variable "app-2_tg_tags" {
  description = "lb tag"
  type        = map(string)
}

variable "sg_id" {
  description = "security group id"
  type        = string
}

variable "sub_1_id" {
  description = "subnet 1 id"
  type        = string
}

variable "sub_2_id" {
  description = "subnet 2 id"
  type        = string
}

variable "vpc_id" {
  description = "vpcid"
  type        = string
}

variable "app-1_id" {
  description = "app 1 ec2 id"
  type        = string
}

variable "app-2_id" {
  description = "app 2 ec2 id"
  type        = string
}
