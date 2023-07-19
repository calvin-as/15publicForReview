# Query all available Availability Zone; we will use specific availability zone using index - The Availability Zones data source
# provides access to the list of AWS availabililty zones which can be accessed by an AWS account specific to region configured in the provider.

###Create VPC:
data "aws_availability_zones" "devVPC_available"{}
resource "aws_vpc" "devVPC"{
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames=true
    enable_dns_support = true
    tags = {
        Name = "dev_terraform18_vpc"
    }
}

###Create Subnets:
#AZ1: Public subnet public CIDR block available in vars.tf and provisionersVPC
resource "aws_subnet" "devVPC_public_subnet1"{
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.devVPC.id
    map_public_ip_on_launch = true
    availability_zone = data.aws_availability_zones.devVPC_available.names[1]
    tags = {
        Name = "dev_terraform_vpc_public1_subnet_az1"
    }
}
resource "aws_subnet" "devVPC_private_subnet1"{
    cidr_block = "10.0.2.0/24"
    vpc_id = aws_vpc.devVPC.id
    map_public_ip_on_launch = false
    availability_zone = data.aws_availability_zones.devVPC_available.names[1]
    tags = {
        Name = "dev_terraform_vpc_private2_subnet_az1"
    }
}

#AZ2: Public subnet public CIDR block available in vars.tf and provisionersVPC
resource "aws_subnet" "devVPC_public_subnet2"{
    cidr_block = "10.0.3.0/24"
    vpc_id = aws_vpc.devVPC.id
    map_public_ip_on_launch = true
    availability_zone = data.aws_availability_zones.devVPC_available.names[2]
    tags = {
        Name = "dev_terraform_vpc_public1_subnet_az2"
    }
}
resource "aws_subnet" "devVPC_private_subnet2"{
    cidr_block = "10.0.4.0/24"
    vpc_id = aws_vpc.devVPC.id
    map_public_ip_on_launch = false
    availability_zone = data.aws_availability_zones.devVPC_available.names[2]
    tags = {
        Name = "dev_terraform_vpc_private2_subnet_az2"
    }
}


# To access EC2 instance inside a Virtual Private Cloud (VPC) we need an Internet Gateway
# and a routing table Connecting the subnet to the Internet Gateway
# Provides a resource to create a VPC Internet Gateway

###Create Internet Gateway
resource "aws_internet_gateway" "devVPC_IGW"{
    vpc_id = aws_vpc.devVPC.id
    tags = {
        Name = "dev_terraform_vpc_igw"
    }
}
# Provides a resource to create a VPC routing table

###Create Route Tables
resource "aws_route_table" "devVPC_public_route"{
    vpc_id = aws_vpc.devVPC.id
    route{
        cidr_block = var.cidr_blocks
        gateway_id = aws_internet_gateway.devVPC_IGW.id
    }
    tags = {
        Name = "dev_terraform_vpc_public_route"
    }
}


# Provides a resource to create an association between a Public Route Table and a Public Subnet
###Create association between a Public Route Table and a Public Subnet:
#association1 to public subnet1 
resource "aws_route_table_association" "public_subnet_association1" {
    route_table_id = aws_route_table.devVPC_public_route.id
    subnet_id = aws_subnet.devVPC_public_subnet1.id
    depends_on = [aws_route_table.devVPC_public_route, aws_subnet.devVPC_public_subnet1]
}
#association2 to public subnet2 
resource "aws_route_table_association" "public_subnet_association2" {
    route_table_id = aws_route_table.devVPC_public_route.id
    subnet_id = aws_subnet.devVPC_public_subnet2.id
    depends_on = [aws_route_table.devVPC_public_route, aws_subnet.devVPC_public_subnet2]
}
