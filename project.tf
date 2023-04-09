provider "aws" {}

module "ec2-instance" {
  source   = "terraform-aws-modules/ec2-instance/aws"
  version  = "4.3.0"
  for_each = toset(["first", "second"]) # Meta-argument for create 2 servers

  name     = "Private LinuxAWS Server"

  ami                         = "ami-0cbfcdb45dcced1ca"
  instance_type               = "t3.micro"
  key_name                    = "vova-key-linuxaws-prod-stokholm"
  associate_public_ip_address = false
  iam_instance_profile        = "AmazonSSMRoleForInstancesQuickSetup"
  vpc_security_group_ids = [aws_security_group.private.id]
  putin_khuylo                = true

  root_block_device = [
    {
      volume_type           = "gp3"
      volume_size           = "10"
      delete_on_termination = "true"
    }
  ]

  tags = {
    Name      = "Private LinuxAWS Server #${each.key}"
    Terraform = true
    education = true
    course    = "devops4sysadmins"
  }
}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.1"
  
  name = "my_SSU_VPC"
  cidr = "10.2.0.0/16"

# Config Aviability Zone and Subnet
  azs             = ["eu-north-1a", "eu-north-1c"]
  public_subnets  = ["10.2.11.0/24", "10.2.21.0/24"]
  private_subnets = ["10.2.12.0/24", "10.2.22.0/24"]

# Config NAT Gateway
  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true

  # Default Security Group
  default_security_group_name = "Default_Security_Grop_SSU"
  default_security_group_ingress = [{
    description      = "Default ingress SG for SSU"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = "10.2.0.0/16"
  }]
  default_security_group_egress = [{
    description      = "Default egress SG for SSU"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = "10.2.0.0/16"
  }]

# All Tags in VPC
  tags = {
    Name      = "My_SSU_VPC"
    Terraform = true
    education = true
    course    = "devops4sysadmins"
  }

  public_subnet_tags  = {
    Name = "My_public_subnet_SSU"
    Terraform = true
    Role = "public"
  }
  private_subnet_tags = {
    Name = "My_private_subnet_SSU"
    Terraform = true
    Role = "private"
  }

  default_security_group_tags = {
    Name = "Default Security Group SSU"
  }
}


# Create Public SG for VPC of SSU
resource "aws_security_group" "public" {
  vpc_id = module.vpc.vpc_id
  name   = "Security Group for Server of Public Subnet"

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
}


# Create Private SG for VPC of SSU
resource "aws_security_group" "private" {
  vpc_id = module.vpc.vpc_id
  name   = "Security Group for Server of Private Subnet"

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
}