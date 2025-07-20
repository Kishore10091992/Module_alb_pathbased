resource "aws_lb" "main_lb" {
 internal = var.internal
 load_balancer_type = var.lb_type
 security_groups = [aws_security_group.main_sg.id]
 subnets = [aws_subnet.main_subnet-1.id, aws_subnet.main_subnet-2.id]
 tags = var.tags
}

resource "aws_lb_target_group" "app-1_tg" {
 port = 80
 protocol = "HTTP"
 vpc_id = aws_vpc.main_vpc.id
 tags = var.tags
}

resource "aws_lb_target_group_attachment" "app-1_tg_attach" {
 target_group_arn = aws_lb_target_group.app-1_tg.arn
 target_id = aws_instance.app-1_ec2.id
 port = 80
}

resource "aws_lb_target_group" "app-2_tg" {
 port = 80
 protocol = "HTTP"
 vpc_id = aws_vpc.main_vpc.id
 tags = var.tags
}

resource "aws_lb_target_group_attachement" "app-2_tg_attach" {
 target_group_arn = aws_lb_target_group.app-2_tg.arn
 target_id = aws_instance.app-2_ec2.id
 port = 80
}

resorce "aws_lb_listener" "main_lb_listener" {
 port = 80
 protocol = "HTTP"
 load_balancer_arn = aws_lb.main_lb.arn

 default_action {
  type = "fixed_response"

  fixed_response {
   content_type = "text/plan"
   message_body = "not found"
   status_code = "404"
  }
 }
}

resource "aws_lb_listener_rule" "app-1_listener_rule" {
 listener_arn = aws_lb_listener.main_lb_listener.arn
 priority = 10

 action {
  type = "forward"
  target_group_arn = aws_lb_target_group.app-1_tg.arn
 }

 condition {
  path_pattern {
   value = ["/app-1"]
  }
 }
}

resource "aws_lb_listener_rule" "app-2_listener_rule" {
 listener_arn = aws_lb_listener.main_lb_listener.arn
 priority = 20

 action {
  type = "forward"
  target_group_arn = aws_lb_target_group.app-2_tg.arn
 }

 condition {
  path_pattern {
   value = ["/app-2"]
  }
 }
}