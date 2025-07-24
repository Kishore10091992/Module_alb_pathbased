variable "from_port" {
  description = "sg from port"
  type        = string
}

variable "to_port" {
  description = "sg to port"
  type        = string
}

variable "protocol" {
  description = "sg protocol"
  type        = string
}

variable "cidr_blocks" {
  description = "sg cidr block"
  type        = list(string)
}

variable "vpc_id" {
  description = "vpc id"
  type        = string
}

variable "tags" {
  description = "sg tags"
  type        = map(string)
}

