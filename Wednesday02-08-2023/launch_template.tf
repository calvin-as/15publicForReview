resource "aws_launch_template" "deham6demo" {
  name_prefix   = "deham6demo2"
  description   = "Template2 for the deham6demo instance"
  ebs_optimized = true
  
  instance_type = "t3.micro"

  image_id      = data.aws_ami.latest_amazon_linux.id
  key_name      = null
  user_data     = filebase64("user-data.sh")

  vpc_security_group_ids = [aws_security_group.devVPC_sg_allow_ssh_http.id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "terraform21_4_ec2_asg"
    }
  }
}