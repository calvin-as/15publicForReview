variable "AWS_REGION"{
    default="us-west-2"
    description="AWS Region"
}

variable "cidr_blocks"{
    default = "0.0.0.0/0"
}

variable "public_cidr1"{
    default = "10.0.1.0/24"
}
variable "private_cidr1"{
    default = "10.0.2.0/24"
}
variable "public_cidr2"{
    default = "10.0.1.0/24"
}
variable "private_cidr2"{
    default = "10.0.2.0/24"
}

#CIDR block for the VPC, Subnets
variable "VPC_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet1_cidr_block" {
  description = "CIDR block for subnet 1"
  default     = "10.0.1.0/24"
}

variable "subnet2_cidr_block" {
  description = "CIDR block for subnet 2"
  default     = "10.0.2.0/24"
}
