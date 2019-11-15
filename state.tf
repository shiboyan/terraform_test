terraform {
  backend "s3" {
    bucket = "mina-terraform-state"
    key    = "terraform-state-aws-with-gitlab.tfstate"
    region = "ap-southeast-2"
  }
}

