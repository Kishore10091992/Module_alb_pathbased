resource "aws_instance" "app-2_ec2" {
 ami = var.ami_id
 instance_type = var.instance_type
 key_name = var.key_name

 network_interface {
  device_index = 0
  network_interface_id = aws_network_interface.app-2_nic.id
 }

 user_data = var.app_1_userdata

 tags = var.tags
}
