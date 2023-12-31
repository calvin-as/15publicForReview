output "vpc_id"{
    value = aws_vpc.devVPC.id
}
output "aws_internet_gateway"{
    value = aws_internet_gateway.devVPC_IGW.id 
}
output "public_subnet1"{
    value = aws_subnet.devVPC_public_subnet1.id  
}
output "public_subnet2"{
    value = aws_subnet.devVPC_public_subnet2.id  
}

output "security_group"{
    value = aws_security_group.devVPC_sg_allow_ssh_http # devVPC_sg_allow_http.id
}

#IP-Adress for the Webserver
output "public_ip_of_first_EC2" {
  value = aws_instance.deham6demo.public_ip
}

output "name_of_first_EC2" {
  value = aws_instance.deham6demo.tags.Name
}

output "ip_and_name_of_first_EC2" {
  value = "${aws_instance.deham6demo.public_ip} ${aws_instance.deham6demo.tags.Name}"
}


/*
output "packer_ami"{
    value= data.aws_ami.packeramisjenkins.devVPC_IGW.id
}
output "aws_instance"{
    value=aws_instance.jenkins-instance.devVPC_IGW.id
}
# For more attributes https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#attributes-reference
output "public_ip"{
    value = aws_instance.jenkins-instance.public_ip
}
output "public_dns"{
    value = aws_instance.jenkins-instance.public_dns
}
*/