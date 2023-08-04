
/*
###Create security group
#SG http only | No SSH or https
resource "aws_security_group" "devVPC_sg_allow_http" {
  vpc_id = aws_vpc.devVPC.id
  name   = "devVPC_terraform_vpc_allow_http"
  tags = {
    Name = "devVPC_terraform_sg_allow_http"
  }
}

# Ingress Security Port 80 (Inbound)
# Default port for HTTP connections
## Necessary so that the IP can be called in the browser.
resource "aws_security_group_rule" "devVPC_http_ingress_access" {
  from_port          = 80
  protocol           = "tcp"
  security_group_id = aws_security_group.devVPC_sg_allow_http.id
  to_port            = 80
  type               = "ingress"
  cidr_blocks        = [var.cidr_blocks]
}


# Egress Security (Outbound) - Allow all outbound traffic
## Necessary for the commands to be executed on the EC2.
resource "aws_security_group_rule" "devVPC_egress_access" {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.devVPC_sg_allow_http.id
    type = "egress"
}

*/
#old rules ssh

# Creation of the main security group within the VPC.
## SSH & https
resource "aws_security_group" "devVPC_sg_allow_ssh_http"{
    vpc_id = aws_vpc.devVPC.id
    name = "devVPC_terraform_vpc_allow_ssh_http"
    tags = {
        Name = "devVPC_terraform_sg_allow_ssh_http"
    }
}

# Ingress Security Port 22 (Inbound) - Provides a security group rule resource (https://registry.terraform.io.providers/hashicorp/aws/latest/docs/resources/security_group_rule)
# Typically used for SSH connections
resource "aws_security_group_rule" "devVPC_ssh_ingress_access"{
    from_port = 22
    protocol = "tcp"
    security_group_id = aws_security_group.devVPC_sg_allow_ssh_http.id
    to_port = 22
    type = "ingress"
    cidr_blocks = [var.cidr_blocks]
}

# Ingress Security Port 80 (Inbound)
# Default port for HTTP connections
## Necessary so that the IP can be called in the browser.
resource "aws_security_group_rule" "devVPC_http_ingress_access"{
    from_port = 80
    protocol = "tcp"
    security_group_id = aws_security_group.devVPC_sg_allow_ssh_http.id
    to_port= 80
    type = "ingress"
    cidr_blocks = [var.cidr_blocks]
}

# Ingress Security Port 8080 (Inbound)
# Often used for web applications running on a port other than the default HTTP port.
resource "aws_security_group_rule" "devVPC_http8080_ingress_access"{
    from_port = 8080
    protocol = "tcp"
    security_group_id = aws_security_group.devVPC_sg_allow_ssh_http.id
    to_port= 8080
    type = "ingress"
    cidr_blocks = [var.cidr_blocks]
}

# Egress Security (Outbound) - Allow all outbound traffic
## Necessary for the commands to be executed on the EC2.
resource "aws_security_group_rule" "devVPC_egress_access" {
    from_port   = 0
    protocol    = "-1"
    security_group_id = aws_security_group.devVPC_sg_allow_ssh_http.id
    to_port     = 0
    type = "egress"
    cidr_blocks = [var.cidr_blocks]
}



## SG for Load Balancer:
resource "aws_security_group" "devVPC_alb_security_group" {
  name_prefix = "devVPC-alb-sg"
  description = "Security Group for Application Load Balancer"

  vpc_id = aws_vpc.devVPC.id

  # Inbound rule to allow incoming HTTP traffic (port 80)
  ingress {
    description = "HTTP inbound traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


## SG for RDS:
#Security group to allow port 3306
resource "aws_security_group" "allow_mysql" {
  vpc_id = aws_vpc.devVPC.id

  # Inbound rule to allow incoming HTTP traffic (port 80)
  ingress {
    description = "HTTP inbound traffic"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  /*
    # Egress Security (Outbound) - Allow all outbound traffic
  egress {
    description = "egress all traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_blocks]
  }
  */
}