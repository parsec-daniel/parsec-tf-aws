/*
____   _    ____  ____  _____ ____
|  _ \ / \  |  _ \/ ___|| ____/ ___|
| |_) / _ \ | |_) \___ \|  _|| |
|  __/ ___ \|  _ < ___) | |__| |___
|_| /_/   \_\_| \_\____/|_____\____|

Welcome to the Parsec AWS Terraform template!
Please see readme.md for information on how to use this template.
*/

// AWS IAM Variables
variable "awsAccessKey" {
  default = "your-access-key-here"
}

variable "awsSecretKey" {
  default = "your-secret-key-here"
}


// AWS Region information
variable "awsRegion" {
  default = "your-region-here"
}

variable "awsZone" {
  default = "your-zone-here"
}


// Parsec Teams config (from https://support.parsec.app/hc/en-us/articles/4408962860813-AWS-Marketplace-Listing-Usage-Instructions)
variable "parsecTeamsConfig" {
  default = "your-team-string-here"
}


// HPR AMI configuration (please visit https://cloud-images.ubuntu.com/locator/ec2/ to find your AMI)
variable "parsecRelayAMI" {
  default = "ubuntu-ami-here"
}

variable "parsecRelayType" {
  default = "t2.medium"
}
// Please see here: https://docs.aws.amazon.com/ground-station/latest/ug/create-ec2-ssh-key-pair.html
// Add the exact name of your keypair here.
variable "awsKeypair" {
  default = "your-keypair-name-here"
}


// Parsec Host configuration (using AMI as of 2022-06-09)
variable "parsecHostAMI" {
  default = "ami-0abb1e6c196a217c4"
}

variable "parsecHostType" {
  default = "g4dn.xlarge"
}

variable "parsecHostDisk" {
  default = "256"
}
