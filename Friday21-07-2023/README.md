# 18_Optimize_15publicForReview

# `deham6_vpc` Terraform Module

Status: Friday the 21.07.2023  
Challenge: Create a Wordpress on an EC2 instance in a VPC with terraform. With Load Balancing and Auto scaling.
Expected output: If you run the program in the terminal with terraform, you will get the public_ip in the terminal. You can open this IP in the browser to open your WordPress site. Then you can create your blog.

The `deham6_vpc` Terraform module provisions an AWS VPC (Virtual Private Cloud) infrastructure, including various subnets, an EC2 instance, and necessary security groups.

## File Structure
- `deham6_vpc.tf`: VPC and associated subnets.
- `sg.tf`: Security group rules.
- `vars.tf`: Variable inputs for other files.
- `main.tf`: AWS provider.
- `user-data.sh`: User-Data script executed on the EC2 instance, installs and configures WordPress.
- `application_load_balancer.tf`: Application Load Balancer.
- `auto_scaling_group.tf`: AWS Auto Scaling Group with the latest Amazon Linux AMI

## Usage
Ensure you have [Terraform](https://www.terraform.io/downloads.html) properly installed and configured, and valid AWS credentials available via AWS CLI or environment variables. Then, execute the module from the directory containing the Terraform files:

```bash
terraform init     # Initialize Terraform
terraform validate # Validate Terraform
terraform plan     # Create and display execution plan
terraform apply    # Create infrastructure
```

## Variables
Modify variables in `vars.tf` according to your requirements:

- `AWS_REGION`: Target AWS region.
- `cidr_blocks`: CIDR blocks for VPC and subnets.
- `public_cidr1` / `public_cidr2`: CIDR blocks for the first and second public subnets.
- `private_cidr1` / `private_cidr2`: CIDR blocks for the first and second private subnets.

## Security Group
`sg.tf` sets up security group rules for the EC2 instance, allowing inbound access to ports 22 (SSH), 80 (HTTP), and 8080, and unrestricted outbound connections.

## Auto Scaling Group
This script contains the Terraform resources for creating an auto-scaling group in AWS. It ensures that a correct number of EC2 instances are available to handle the application load. The script uses the latest Amazon Linux AMI for the instances and also includes a launch configuration. The `user-data.sh` script runs upon instance start to install WordPress.

## Application Load Balancer
This script contains the Terraform resources for creating an application load balancer in AWS that distributes incoming traffic across multiple destinations, such as EC2 instances, Lambda functions, and IP addresses.

## Notes
Ensure no conflicts between the IP ranges in the CIDR blocks and your other networks. Clean up resources when no longer required to avoid unnecessary costs:

```bash
terraform destroy  # Remove resources
```