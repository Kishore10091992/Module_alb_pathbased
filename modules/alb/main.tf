resource "aws_lb" "main_lb" {
  internal           = var.internal
  load_balancer_type = var.lb_type
  security_groups    = [var.sg_id]
  subnets            = [var.sub_1_id, var.sub_2_id]
  tags               = var.lb_tags
}

resource "aws_lb_target_group" "app-1_tg" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  tags     = var.app-1_tg_tags
}

resource "aws_lb_target_group_attachment" "app-1_tg_attach" {
  target_group_arn = aws_lb_target_group.app-1_tg.arn
  target_id        = var.app-1_id
  port             = 80
}

resource "aws_lb_target_group" "app-2_tg" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  tags     = var.app-2_tg_tags
}

resource "aws_lb_target_group_attachment" "app-2_tg_attach" {
  target_group_arn = aws_lb_target_group.app-2_tg.arn
  target_id        = var.app-2_id
  port             = 80
}

resource "aws_lb_listener" "main_lb_listener" {
  port              = 80
  protocol          = "HTTP"
  load_balancer_arn = aws_lb.main_lb.arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "not found"
      status_code  = "404"
    }
  }
}

resource "aws_lb_listener_rule" "app-1_listener_rule" {
  listener_arn = aws_lb_listener.main_lb_listener.arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app-1_tg.arn
  }

  condition {
    path_pattern {
      values = ["/app-1"]
    }
  }
}

resource "aws_lb_listener_rule" "app-2_listener_rule" {
  listener_arn = aws_lb_listener.main_lb_listener.arn
  priority     = 20

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app-2_tg.arn
  }

  condition {
    path_pattern {
      values = ["/app-2"]
    }
  }
}
