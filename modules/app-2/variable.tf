variable "ami_id" {
  description = "app-2 ami id"
  type        = string
}

variable "instance_type" {
  description = "app-2 instance type"
  type        = string
}

variable "key_name" {
  description = "app-2 key name"
  type        = string
}

variable "app_2_userdata" {
  description = "app-1 userdata"
  type        = string
}

variable "tags" {
  description = "app-2 tags"
  type        = map(string)
}

variable "app-2_nic_id" {
  description = "app 2 nic id"
  type        = string
}
