output "lb_id" {
  description = "load balancer id"
  value       = aws_lb.main_lb.id
}

output "lb_arn" {
  description = "load balancer arn"
  value       = aws_lb.main_lb.arn
}

output "app-1_tg_arn" {
  description = "app 1 tg arn"
  value       = aws_lb_target_group.app-1_tg.arn
}

output "app-2_tg_arn" {
  description = "app 2 tg arn"
  value       = aws_lb_target_group.app-2_tg.arn
}

output "aws_lb_listener" {
  description = "listener arn"
  value       = aws_lb_listener.main_lb_listener.arn
}

