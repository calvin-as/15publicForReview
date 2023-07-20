
#Select newest AMI-id
data "aws_ami" "latest_amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"] # Amazon
}

### Create a Launch Configuration
resource "aws_launch_configuration" "devVPC_launch_configuration" {
  name          = "devVPC-lc"
  image_id      = data.aws_ami.latest_amazon_linux.id 
  instance_type = "t2.micro"
  security_groups = [aws_security_group.devVPC_sg_allow_ssh_http.id] 
    user_data              = "${file("user-data.sh")}"
    
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
  vpc_zone_identifier = [aws_subnet.devVPC_public_subnet1.id] #subnet

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

### read Elastic Load Balancer Listeners Page 16 - register EC2

/* friday challange 14.7
###Create EC2
resource "aws_instance" "deham6demo"{
    ami                    = data.aws_ami.latest_amazon_linux.id
    instance_type          = "t2.micro"
    key_name               = "vockey"
    vpc_security_group_ids = [aws_security_group.devVPC_sg_allow_ssh_http.id]
    subnet_id              = aws_subnet.devVPC_public_subnet1.id   
    tags = {
        Name = "terraform18_ec2_for_public_subnet1_az1"
    }
    user_data              = file("user-data.sh")
    }
    */