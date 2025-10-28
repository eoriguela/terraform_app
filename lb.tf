resource "aws_lb_target_group" "ac1_tg" {
  name        = "ac1-tg"
  port        = 80
  target_type = "instance"
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc_ac1.id
}

resource "aws_lb_target_group_attachment" "ac1_tg_attachment" {
  target_group_arn = aws_lb_target_group.ac1_tg.arn
  target_id        = aws_instance.ac1_instance.id
  port             = 80
}

resource "aws_lb" "ac1_lb" {
  name               = "ac1-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ac1_lb_sg.id]
  subnets            = [aws_subnet.ac1_public_subnet.id, aws_subnet.ac1_public_subnet_2.id]
  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_listener" "ac1_listener" {
  load_balancer_arn = aws_lb.ac1_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ac1_tg.arn
  }
}

resource "aws_lb_listener_rule" "ac1_listener_rule" {
  listener_arn = aws_lb_listener.ac1_listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ac1_tg.arn
  }

  condition {
    path_pattern {
      values = ["/index.html"]
    }
  }
}