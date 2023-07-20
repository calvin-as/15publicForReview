### Create an Application Load Balancer
resource "aws_lb" "devVPC_application_load_balancer" {
  name               = "devVPC-app-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.devVPC_sg_allow_ssh_http.id]
  subnets            = [aws_subnet.devVPC_public_subnet1.id, aws_subnet.devVPC_public_subnet2.id] 

  enable_http2 = true
  idle_timeout  = 60

  tags = {
    Environment = "production"
    Name        = "devVPC-app-load-balancer"
  }
}

resource "aws_lb_target_group" "devVPC_target_group" {
  name     = "devVPC-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.devVPC.id
}

resource "aws_lb_listener" "devVPC_listener" {
  load_balancer_arn = aws_lb.devVPC_application_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.devVPC_target_group.arn
  }
}