provider "aws" {}

module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.3.0"
  for_each = toset(["first", "second", "third"])

  name = "LinuxAWS Server"

  ami           = "ami-0cbfcdb45dcced1ca"
  instance_type = "t3.micro"
  key_name      = "vova-key-linuxaws-prod-stokholm"
  associate_public_ip_address = false
  putin_khuylo = true

  root_block_device = [
    {
      volume_type           = "gp3"
      volume_size           = "10"
      delete_on_termination = "true"
    }
  ]

  tags = {
    Name = "Linux AWS Server #${each.key}"
    Terraform = true
  }
}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.1"
  
  name = "my_SSU_VPC"

  azs = [""]
}