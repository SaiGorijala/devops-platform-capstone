terraform {
  backend "s3" {
    bucket         = "my-terraform-bobby-1"
    key            = "phase1/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}