provider "aws" {}

module "ec2-instance" {
  source   = "terraform-aws-modules/ec2-instance/aws"
  version  = "4.3.0"
  for_each = toset(["first", "second", "third"])

  name = "LinuxAWS Server"

  ami                         = "ami-0cbfcdb45dcced1ca"
  instance_type               = "t3.micro"
  key_name                    = "vova-key-linuxaws-prod-stokholm"
  associate_public_ip_address = false
  iam_instance_profile        = "AmazonSSMRoleForInstancesQuickSetup"
  putin_khuylo                = true

  root_block_device = [
    {
      volume_type           = "gp3"
      volume_size           = "10"
      delete_on_termination = "true"
    }
  ]

  tags = {
    Name      = "Linux AWS Server #${each.key}"
    Terraform = true
  }
}

/*
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.1"
  
  name = "my_SSU_VPC"
  cidr = "10.2.0.0/16"

  azs             = ["eu-north-1a", "eu-north-1c"]
  public_subnets  = ["10.2.11.0/24", "10.2.21.0/24"]
  private_subnets = ["10.2.12.0/24", "10.2.22.0/24"]

  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true

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
}
*/