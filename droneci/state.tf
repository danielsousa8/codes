terraform {
  backend "s3" {
    bucket         = "terraform-state"
    key            = "droneci/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform_lock"
  }
}
