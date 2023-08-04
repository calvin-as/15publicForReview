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