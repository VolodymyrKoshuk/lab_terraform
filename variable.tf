# Variables to module ec-2-instance-public

variable "number_of_public_servers" {
    description = "variable to multiple create public servers"
    type = list
    default = ["first"]
}

variable "name_public_server" {
    description = "variable to name public servers"
    type = string
    default = "Public LinuxAWS Server"
}

variable "ami_public_server" {
    description = "variable to ami public servers"
    type = string
    default = "ami-0cbfcdb45dcced1ca"
}

variable "instance_type_public_server" {
    description = "variable to instance type public servers"
    type = string
    default = "t3.micro"
}

variable "key_name_public_server" {
    description = "variable to key_name public servers"
    type = string
    default = "vova-key-linuxaws-prod-stokholm"
}

variable "associate_pub_ip_public_server" {
    description = "variable to associate public ip address to public servers"
    type = bool
    default = true
}

variable "iam_instance_profile_public_server" {
    description = "variable to iam instance profile public servers"
    type = string
    default = "AmazonSSMRoleForInstancesQuickSetup"
}

variable "subnet_to_public_server" {
    description = "variable to subnet to public servers (0 or 1)"
    type = number
    default = 1
}

variable "rbd_to_public_server" {
    description = "variable to root block device to public servers"
    type = list(any)
    default = [
    {
      volume_type           = "gp3"
      volume_size           = "10"
      delete_on_termination = "true"
    }
  ]
}

variable "default_tags_to_public_server" {
    description = "Common Tags to apply to Module ec2-instance-public"
    type = map
    default = {
    Terraform = true
    education = true
    course    = "devops4sysadmins"
  }
}

# Variables to module ec-2-instance-private

variable "number_of_private_servers" {
    description = "variable to multiple create private servers"
    type = list
    default = ["first", "second"]
}

variable "name_private_server" {
    description = "variable to name private servers"
    type = string
    default = "Private LinuxAWS Server"
}

variable "ami_private_server" {
    description = "variable to ami private servers"
    type = string
    default = "ami-0cbfcdb45dcced1ca"
}

variable "instance_type_private_server" {
    description = "variable to instance type private servers"
    type = string
    default = "t3.micro"
}

variable "key_name_private_server" {
    description = "variable to key_name private servers"
    type = string
    default = "vova-key-linuxaws-prod-stokholm"
}

variable "associate_pub_ip_private_server" {
    description = "variable to associate public ip address to private servers"
    type = bool
    default = false
}

variable "iam_instance_profile_private_server" {
    description = "variable to iam instance profile private servers"
    type = string
    default = "AmazonSSMRoleForInstancesQuickSetup"
}

variable "subnet_to_private_server" {
    description = "variable to subnet to private servers (0 or 1)"
    type = number
    default = 0
}

variable "rbd_to_private_server" {
    description = "variable to root block device to private servers"
    type = list(any)
    default = [
    {
      volume_type           = "gp3"
      volume_size           = "10"
      delete_on_termination = "true"
    }
  ]
}

variable "default_tags_to_private_server" {
    description = "Common Tags to apply to Module ec2-instance-private"
    type = map
    default = {
    Terraform = true
    education = true
    course    = "devops4sysadmins"
  }
}


# Variables to VPC

variable "vpc_name" {
    description = "Name to VPC SSU"
    type = string
    default = "My_SSU_VPC"
}

variable "cidr_block_vpc" {
    description = "CIDR block to VPC SSU"
    type = string
    default = "10.2.0.0/16"
}

variable "igw_vpc" {
    description = "Create Internet GW to VPC SSU"
    type = bool
    default = true
}


# Config Aviability Zone and Subnet
variable "azs_to_vpc" {
    description = "Availabilit Zones to VPC SSU"
    type = list(string)
    default = ["eu-north-1a", "eu-north-1c"]
}

variable "cidr_public_subnets_to_vpc" {
    description = "CIDR block to public subnets to VPC SSU"
    type = list(string)
    default = ["10.2.11.0/24", "10.2.21.0/24"]
}

variable "cidr_private_subnets_to_vpc" {
    description = "CIDR block to private subnets to VPC SSU"
    type = list(string)
    default = ["10.2.12.0/24", "10.2.22.0/24"]
}

# Config NAT Gateway
variable "create_nat_gw_to_vpc" {
    description = "Create NAT GW to VPC SSU"
    type = bool
    default = true
}

variable "single_nat_gw_to_vpc" {
    description = "Single NAT GW to VPC SSU"
    type = bool
    default = false
}

variable "one_nat_gw_per_azs_vpc" {
    description = "One NAT GW per Availability Zone to VPC SSU"
    type = bool
    default = true
}

# Default Security Group
variable "def_sg_name_vpc" {
    description = "Name default security group in VPC SSU"
    type = string
    default = "Default_Security_Grop_SSU"
}

variable "def_sg_ingress_vpc" {
    description = "Rules ingress for security group to VPC SSU"
    type = list(any)
    default = [{
        description      = "Default ingress SG for SSU"
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"
        cidr_blocks      = "10.2.0.0/16"
  }]
}

variable "def_sg_egress_vpc" {
    description = "Rules egress for security group to VPC SSU"
    type = list(any)
    default = [{
        description      = "Default egress SG for SSU"
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = "10.2.0.0/16"
  }]
}

# All Tags in VPC
variable "common_tags_to_vpc" {
    description = "Common Tags to apply to all VPC SSU"
    type = map
    default = {
        Terraform = true
        education = true
        course    = "devops4sysadmins"
  }
}

variable "pub_sub_tags_vpc" {
    description = "Tags to public subnet in VPC SSU"
    type = map
    default = {
        Name      = "My_public_subnet_SSU"
        Terraform = true
        Role      = "public"
  }
}

variable "pri_sub_tags_vpc" {
    description = "Tags to private subnet in VPC SSU"
    type = map
    default = {
        Name      = "My_private_subnet_SSU"
        Terraform = true
        Role      = "private"
  }
}

variable "igw_tags_vpc" {
    description = "Tags to Internet GW in VPC SSU"
    type = map
    default = { 
        Name = "IGW for VPC of SSU"
  }
}

variable "nat_eip_tags_vpc" {
    description = "Tags to NAT EIPs in VPC SSU"
    type = map
    default = { 
        Name = "EIPs for NAT GW in VPC of SSU"
  }
}

variable "nat_tags_vpc" {
    description = "Tags to NAT GW in VPC SSU"
    type = map
    default = { 
        Name = "NAT GW for Private Subnet in VPC of SSU"
  }
}

variable "def_route_table_tags_vpc" {
    description = "Tags to default Route Table in VPC SSU"
    type = map
    default = {
        Name = "Default Route Table for VPC of SSU"
  }
}

variable "pri_route_table_tags_vpc" {
    description = "Tags to private Route Table in VPC SSU"
    type = map
    default = {
        Name = "Route Table for Private Subnet"
  }
}

variable "pub_route_table_tags_vpc" {
    description = "Tags to public Route Table in VPC SSU"
    type = map
    default = {
        Name = "Route Table for Public Subnet"
  }
}

variable "def_sg_tags_vpc" {
    description = "Tags to default Security Group in VPC SSU"
    type = map
    default = {
        Name = "Default Security Group SSU"
  }
}

variable "def_acl_tags_vpc" {
    description = "Tags to default ACL Network in VPC SSU"
    type = map
    default = {
        Name = "Default ACL for VPC of SSU"
  }
}


#Variables to Public Security Group for VPC SSU
variable "name_public_sg" {
    description = "Name to public Security Group"
    type = string
    default = "Security Group for Servers of Public Subnet"
}

variable "tags_pub_sg" {
    description = "Tags to public Seurity Group"
    type = map
    default = {
        Role = "Public"
        Terraform = true
        education = true
        course    = "devops4sysadmins"
  }
}


#Variables to Private Security Group for VPC SSU
variable "name_private_sg" {
    description = "Name to private Security Group"
    type = string
    default = "Security Group for Servers of Private Subnet"
}

variable "tags_private_sg" {
    description = "Tags to private Seurity Group"
    type = map
    default = {
        Role = "Private"
        Terraform = true
        education = true
        course    = "devops4sysadmins"
  }
}