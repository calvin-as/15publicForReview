resource "aws_lb" "nf-load-balancer" {
  name                              = "Webserver-alb"
  internal                          = false
  load_balancer_type                = "application"
  security_groups                   = [aws_security_group.devVPC_alb_security_group.id]
  subnets                           = [aws_subnet.devVPC_private_subnet1.id, aws_subnet.devVPC_private_subnet2.id]
  
  enable_deletion_protection        = false
  enable_http2 = true
  idle_timeout  = 60

    tags = {
        Environment = "production"
        Name        = "devVPC-app-load-balancer"

  }
}
resource "aws_lb_target_group" "target-group" {
  name                              = "CPUtest-tg"
  port                              = 80
  protocol                          = "HTTP"
  vpc_id                            = aws_vpc.devVPC.id
}
resource "aws_lb_listener" "listener" {
  load_balancer_arn                 = aws_lb.nf-load-balancer.arn
  port                              = "80"
  protocol                          = "HTTP"
  default_action {
    type                            = "forward"
    target_group_arn                = aws_lb_target_group.target-group.arn
  }
}
 