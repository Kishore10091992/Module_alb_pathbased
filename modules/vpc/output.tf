output "vpc_id" {
  description = "vpc id"
  value       = aws_vpc.main_vpc.id
}

output "sub_1_id" {
  description = "subnet 1 id"
  value       = aws_subnet.main_subnet-1.id
}

output "sub_2_id" {
  description = "subnet 2 id"
  value       = aws_subnet.main_subnet-2.id
}

output "IGW_id" {
  description = "IGW id"
  value       = aws_internet_gateway.main_IGW.id
}

output "rt_id" {
  description = "route table id"
  value       = aws_route_table.main_rt.id
}

output "app-1_nic_id" {
  description = "app 1 nic id"
  value       = aws_network_interface.app-1_nic.id
}

output "app-2_nic_id" {
  description = "app 2 nic id"
  value       = aws_network_interface.app-2_nic.id
}

