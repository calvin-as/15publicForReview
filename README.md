# 18_Optimize_15publicForReview

# `deham6_vpc` Terraform Module

Status: Friday the 14.07.2023 - Challenge: Create a Wordpress on an EC2 instance in a VPC with terraform

The `deham6_vpc` Terraform module provisions an AWS VPC (Virtual Private Cloud) infrastructure, including various subnets, an EC2 instance, and necessary security groups.

## File Structure
- `deham6_vpc.tf`: VPC and associated subnets.
- `sg.tf`: Security group rules.
- `vars.tf`: Variable inputs for other files.
- `main.tf`: AWS provider.
- `EC2.tf`: EC2 instance within the VPC.
- `user-data.sh`: User-Data script executed on the EC2 instance, installs and configures WordPress.

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

## EC2 Instance
`EC2.tf` defines an EC2 instance of type `t2.micro` using the latest Amazon Linux AMI within the VPC. The `user-data.sh` script runs upon instance start to install WordPress.

## Security Group
`sg.tf` sets up security group rules for the EC2 instance, allowing inbound access to ports 22 (SSH), 80 (HTTP), and 8080, and unrestricted outbound connections.

## Notes
Ensure no conflicts between the IP ranges in the CIDR blocks and your other networks. Clean up resources when no longer required to avoid unnecessary costs:

```bash
terraform destroy  # Remove resources
```