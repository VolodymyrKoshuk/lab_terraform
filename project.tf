provider "aws" {}

# Create Public Server
module "ec2-instance-public" {
  source   = "terraform-aws-modules/ec2-instance/aws"
  version  = "4.3.0"
  for_each = toset(var.number_of_public_servers) # Meta-argument to create multiple servers

  name     = var.name_public_server

  ami                         = var.ami_public_server
  instance_type               = var.instance_type_public_server
  key_name                    = var.key_name_public_server
  associate_public_ip_address = var.associate_pub_ip_public_server
  iam_instance_profile        = var.iam_instance_profile_public_server
  vpc_security_group_ids      = [aws_security_group.public.id]
  subnet_id                   = module.vpc.public_subnets[var.subnet_to_public_server]
 
  putin_khuylo                = true

  root_block_device = var.rbd_to_public_server


  tags = var.default_tags_to_public_server
}



# Create Private Server
module "ec2-instance-private" {
  source   = "terraform-aws-modules/ec2-instance/aws"
  version  = "4.3.0"
  for_each = toset(var.number_of_private_servers) # Meta-argument for create multiple servers

  name     = var.name_private_server

  ami                         = var.ami_private_server
  instance_type               = var.instance_type_private_server
  key_name                    = var.key_name_private_server
  associate_public_ip_address = var.associate_pub_ip_private_server
  iam_instance_profile        = var.iam_instance_profile_private_server
  vpc_security_group_ids      = [aws_security_group.private.id]
  subnet_id                   = module.vpc.private_subnets[var.subnet_to_private_server]
 
  putin_khuylo                = true

  root_block_device = var.rbd_to_private_server

  tags = var.default_tags_to_private_server
}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.1"
  
  name = var.vpc_name
  cidr = var.cidr_block_vpc
  create_igw = var.igw_vpc
  putin_khuylo = true

# Config Aviability Zone and Subnet
  azs             = var.azs_to_vpc
  public_subnets  = var.cidr_public_subnets_to_vpc
  private_subnets = var.cidr_private_subnets_to_vpc

# Config NAT Gateway
  enable_nat_gateway     = var.create_nat_gw_to_vpc
  single_nat_gateway     = var.single_nat_gw_to_vpc
  one_nat_gateway_per_az = var.one_nat_gw_per_azs_vpc

  # Default Security Group
  default_security_group_name = var.def_sg_name_vpc
  default_security_group_ingress = var.def_sg_ingress_vpc
  default_security_group_egress = var.def_sg_egress_vpc

# All Tags in VPC
  tags = var.common_tags_to_vpc

  public_subnet_tags  = var.pub_sub_tags_vpc
  private_subnet_tags = var.pri_sub_tags_vpc

  igw_tags = var.igw_tags_vpc

  nat_eip_tags = var.nat_eip_tags_vpc

  nat_gateway_tags = var.nat_tags_vpc

  default_route_table_tags = var.def_route_table_tags_vpc

  private_route_table_tags = var.pri_route_table_tags_vpc

  public_route_table_tags = var.pub_route_table_tags_vpc

  default_security_group_tags = var.def_sg_tags_vpc

  default_network_acl_tags    = var.def_acl_tags_vpc
}


# Create Public SG for VPC of SSU
resource "aws_security_group" "public" {
  vpc_id = module.vpc.vpc_id
  name   = var.name_public_sg

# Rule for SSH conection
  ingress {
    description      = "SSH Port"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

# Rule for HTTP conection
  ingress {
    description      = "HTTP Port"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

# Rule for HTTPS conection
  ingress {
    description      = "HTTPS Port"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

# Rule for egress to all intenet
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Security Group for Server of Public Subnet"
    Role = "Public"
    Terraform = true
    education = true
    course    = "devops4sysadmins"
  }
}


# Create Private SG for VPC of SSU
resource "aws_security_group" "private" {
  vpc_id = module.vpc.vpc_id
  name   = var.name_private_sg

# Rule for SSH conection
  ingress {
    description      = "SSH Port"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["10.2.0.0/16"]
  }

# Rule for egress to all intenet
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = var.tags_private_sg
}