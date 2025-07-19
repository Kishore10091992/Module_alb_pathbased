variable "ami_id" {
 description = "ap-1 ami id"
 type = string
}

variable "instance_type" {
 description = "app-1 instance type"
 type = string
}

variable "key_name" {
 description = "app-1 keypair name"
 type = string
}

variable "app-1_userdata" {
 description = "app-1 userdata"
 type = string
}

variable "tags" {
 description = "app-1 tags"
 type = map(string)
}