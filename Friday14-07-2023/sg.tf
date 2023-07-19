
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