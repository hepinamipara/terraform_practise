resource "aws_lb_target_group" "mybackendtg" {
  name       = "mybacktend-tg"
  port       = 80
  protocol   = "HTTP"
  vpc_id     = aws_vpc.vpc3tier.id
  depends_on = [aws_vpc.vpc3tier]

}

resource "aws_lb" "my-backend" {
  name               = "backend-loadbalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-backend-sg.id]
  subnets            = [aws_subnet.pub1.id, aws_subnet.pub2.id]

  tags = {
    Name = "backend-loadbalancer"
  }
  depends_on = [aws_lb_target_group.mybackendtg]
}

resource "aws_lb_listener" "my_backend_listener" {
  load_balancer_arn = aws_lb.my-backend.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.mybackendtg.arn
  }
  depends_on = [aws_lb_target_group.mybackendtg]
}

