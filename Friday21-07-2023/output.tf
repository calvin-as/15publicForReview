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

# Friday Challange 14.7.2023
#not tested
output "public_ip_of_first_EC2" {
  value = aws_instance.deham6demo.public_ip
}

output "aws_instance" {
  value = aws_instance.deham6demo.id
}

output "aws_autoscaling_group" {
  value = aws_autoscaling_group.deham6demo_asg.id
}

output "aws_autoscaling_policy" {
  value = aws_autoscaling_policy.scale_up.id
}

output "aws_lb" {
  value = aws_lb.devVPC_application_load_balancer.id
}

output "aws_lb_target_group" {
  value = aws_lb_target_group.devVPC_target_group.id
}

output "aws_lb_listener" {
  value = aws_lb_listener.devVPC_listener.id
}

output "aws_launch_template" {
  value = aws_launch_template.deham6demo.id
}



/*
#IP-Adress for the Webserver


output "name_of_first_EC2" {
  value = aws_instance.deham6demo.tags.Name
}

output "ip_and_name_of_first_EC2" {
  value = "${aws_instance.deham6demo.public_ip} ${aws_instance.deham6demo.tags.Name}"
}



# Load Balancer details
output "application_load_balancer_arn" {
  value = aws_lb.devVPC_application_load_balancer.arn
}
output "application_load_balancer_id" {
  value = aws_lb.devVPC_application_load_balancer.id
}

# Auto Scaling Group details
output "auto_scaling_group_id" {
  value = aws_autoscaling_group.devVPC_auto_scaling_group.id
}
output "auto_scaling_group_arn" {
  value = aws_autoscaling_group.devVPC_auto_scaling_group.arn
}

*/



/*
# Launch Configuration details
output "launch_configuration_id" {
  value = aws_launch_configuration.devVPC_launch_configuration.id
}
output "launch_configuration_name" {
  value = aws_launch_configuration.devVPC_launch_configuration.name
}

# Target Group details
output "target_group_arn" {
  value = aws_lb_target_group.devVPC_target_group.arn
}
output "target_group_id" {
  value = aws_lb_target_group.devVPC_target_group.id
}
*/


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