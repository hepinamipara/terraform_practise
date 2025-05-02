resource "aws_lb_target_group" "myfronttg" {
  name       = "myfrontend-tg"
  port       = 80
  protocol   = "HTTP"
  vpc_id     = aws_vpc.vpc3tier.id
  depends_on = [aws_vpc.vpc3tier]

}

resource "aws_lb" "my-frontend" {
  name               = "frontend-loadbalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-frontend-sg.id]
  subnets            = [aws_subnet.pub1.id, aws_subnet.pub2.id]

  tags = {
    Name = "frontend-loadbalancer"
  }
  depends_on = [aws_lb_target_group.myfronttg]
}

resource "aws_lb_listener" "myfrontend_listener" {
  load_balancer_arn = aws_lb.my-frontend.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.myfronttg.arn
  }
  depends_on = [aws_lb_target_group.myfronttg]
}

