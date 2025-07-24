resource "aws_instance" "app-1_ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interface {
    device_index         = 0
    network_interface_id = var.app-1_nic_id
  }

  user_data = var.app_1_userdata

  tags = var.tags
}

