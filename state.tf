terraform {
  backend "s3" {
    bucket = "terraform-state-mina"
    key    = "terraform-state-aws-with-gitlab.tfstate"
    region = "ap-southeast-2"
  }
}
