terraform {
  backend "s3" {
    bucket = "koshuk-backup-terrafrom"
    key    = "lab_project/terraform.tfstate"
    region = "eu-north-1"
  }
}
 