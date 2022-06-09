// Terraform plugin config
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.15.1"
    }
  }
}


// AWS login info
provider "aws" {
  region	= "${var.awsRegion}"
  access_key	= "${var.awsAccessKey}"
  secret_key	= "${var.awsSecretKey}"
}
