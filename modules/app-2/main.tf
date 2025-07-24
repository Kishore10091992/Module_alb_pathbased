resource "aws_instance" "app-2_ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interface {
    device_index         = 0
    network_interface_id = var.app-2_nic_id
  }

  user_data = var.app_2_userdata

  tags = var.tags
}
