provider "aws" {}

module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.3.0"

  name = "LinuxAWS Server"

  ami           = "ami-0cbfcdb45dcced1ca"
  instance_type = "t3.micro"
  key_name      = "vova-key-linuxaws-prod-stokholm"
  


}