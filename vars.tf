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


// HPR AMI configuration (AMI will be automatically selected for your region)
data "aws_ami" "parsecRelayAMI" {
  most_recent = true
  owners = ["099720109477"]
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server*"]
  }
}
// Change instance type, if desired.
variable "parsecRelayType" {
  default = "t2.medium"
}
// Please see here: https://docs.aws.amazon.com/ground-station/latest/ug/create-ec2-ssh-key-pair.html
// Add the exact name of your keypair here.
variable "awsKeypair" {
  default = "your-keypair-name-here"
}


// Parsec Host configuration (AMI will be automatically selected for your region)
// Use "Parsec for Teams G4dn*" for NVIDIA and "Parsec for Teams G4ad*" for AMD
data "aws_ami" "parsecHostAMI" {
  most_recent = true
  owners = ["679593333241"]
  filter {
    name = "name"
    values = ["Parsec for Teams G4dn*"]
  }
}
// Change instance type, if desired. "g4dn" for NVIDIA, "g4ad" for AMD.
variable "parsecHostType" {
  default = "g4dn.xlarge"
}
// Change disk size, if desired.
variable "parsecHostDisk" {
  default = "256"
}
