output "vpc_id" {
  description = "vpc id"
  value       = module.vpc.vpc_id
}

output "sub_1-id" {
  description = "subnet 1 id"
  value       = module.vpc.sub_1_id
}

output "sub_2-id" {
  description = "subnet 2 id"
  value       = module.vpc.sub_2_id
}

output "IGW_id" {
  description = "internet gateway id"
  value       = module.vpc.IGW_id
}

output "rt_id" {
  description = "route table id"
  value       = module.vpc.rt_id
}

output "app-1_nic_id" {
  description = "app 1 nic id"
  value       = module.vpc.app-1_nic_id
}

output "app-2_nic_id" {
  description = "app 2 nic id"
  value       = module.vpc.app-2_nic_id
}

output "sg_id" {
  description = "security group id"
  value       = module.security_group.sg_id
}

output "app-1_id" {
  description = "app 1 ec2 id"
  value       = module.app-1.app-1_id
}

output "app-2_id" {
  description = "app 2 ec2 id"
  value       = module.app-2.app-2_id
}

output "lb_id" {
  description = "load balancer id"
  value       = module.alb.lb_id
}

output "lb_arn" {
  description = "load balancer arn"
  value       = module.alb.lb_arn
}

output "app-1_tg_arn" {
  description = "app 1 target group arn"
  value       = module.alb.app-1_tg_arn
}

output "app-2_tg_arn" {
  description = "app 2 target group arn"
  value       = module.alb.app-2_tg_arn
}

output "listener_arn" {
  description = "listener arn"
  value       = module.alb.aws_lb_listener
}
