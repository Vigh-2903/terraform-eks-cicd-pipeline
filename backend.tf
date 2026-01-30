terraform {
  backend "s3" {
    bucket = "devopsproject2026"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"
    profile = "dev"
  }
}
