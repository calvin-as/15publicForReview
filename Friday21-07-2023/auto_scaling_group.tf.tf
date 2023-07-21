resource "aws_autoscaling_group" "deham6demo_asg" {
 # desired_capacity     = 2
  min_size             = 1
  max_size             = 4
  health_check_type    = "ELB"
  health_check_grace_period = 300
  launch_template {
    id = aws_launch_template.deham6demo.id
  }

  vpc_zone_identifier  = [aws_subnet.devVPC_private_subnet2.id, aws_subnet.devVPC_private_subnet1.id]

  target_group_arns = [aws_lb_target_group.devVPC_target_group.arn]

  tag {
    key                 = "Name"
    value               = "asg"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

/* old
### Create a Launch Configuration
resource "aws_launch_configuration" "devVPC_launch_configuration" {
  name          = "devVPC-lc"
  image_id      = data.aws_ami.latest_amazon_linux.id 
  instance_type = "t2.micro"
  security_groups = [aws_security_group.devVPC_sg_allow_ssh_http.id] 
    user_data              = file("user-data.sh")
    
  lifecycle {
    create_before_destroy = true
  }
}

### Create an Auto Scaling Group
resource "aws_autoscaling_group" "devVPC_auto_scaling_group" {
  desired_capacity   = 2 #number of EC2
  launch_configuration = aws_launch_configuration.devVPC_launch_configuration.id
  max_size           = 4
  min_size           = 1
  vpc_zone_identifier = [aws_subnet.devVPC_public_subnet1.id, aws_subnet.devVPC_public_subnet1.id] 
  target_group_arns = [aws_lb_target_group.devVPC_target_group.arn]

  tag {
    key                 = "Name"
    value               = "terraform18_ec2_asg"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
*/

### read Elastic Load Balancer Listeners Page 16 - register E