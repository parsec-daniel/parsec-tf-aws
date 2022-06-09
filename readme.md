# Welcome to the Parsec AWS Terraform Template

### This package is designed to fully build a Parsec deployment for you in a matter of minutes.

#### What this template *will* do:
 - Create an AWS VPC
 - Create two subnets: Public and Private
 - Create an Internet Gateway and NAT Gateway
 - Create two security groups for Public and Private subnets
 - Create and bootstrap a Parsec HPR based on Ubuntu 20.04 LTS
 - Ingest and assign your Keypair to the project
 - Create a Parsec Host from our AWS AMI
 - Automagically attach the Parsec Host to your Teams account

#### What this template *won't* do:
 - Attach to your domain and create user accounts
 - Retrieve instance passwords
 - Create SSH Keys
 - Install additional software
 - Configure your HPR in the Teams UI
 - Make a grilled cheese
 - Port *Paper Mario: The Thousand Year Door* to Nintento Switch

Please use the `vars.tf` file to configure this Terraform template.
Editing the other TF files is not reccomended, but can be done.

Use at your own risk. **The Parsec Team offers no warranty for this template,
and cannot reimburse you for AWS resource charges.**

---
# Getting Started
#### Basic Requirments
 - A Parsec for Teams Enterprise Subscription
 - An AWS Account with ~~phenominal cosmic powers~~ the ability to create resources like VPCs, Subnets, EC2, Keypairs, and so on.
 - `terraform` on your Mac/PC, if you're running locally.

#### Preparing the Variables
0. `git clone` this repo onto your machine.
1. Open the `vars.tf` file within the `parsec-tf-aws` folder.
2. Obtain your AWS IAM information from the AWS dashboard.
3. Pick your region and zone.
4. [Create your Teams configuration string by following our docs.](https://support.parsec.app/hc/en-us/articles/4408962860813-AWS-Marketplace-Listing-Usage-Instructions)
5. [Generate a Keypair in AWS EC2.](https://docs.aws.amazon.com/ground-station/latest/ug/create-ec2-ssh-key-pair.html)
6. [Find the Ubuntu AMI most appropriate for your region.](https://cloud-images.ubuntu.com/locator/ec2/)
7. Find the Parsec Host AMI by using the AMI Catalog.
8. Fill-in the gathered information within the `vars.tf` file.

#### Getting Terraform Ready
1. Using a terminal emulator, `cd` to the working directory `parsec-tf-aws`.
2. Get Terraform acclimated by running `terraform init`. This will prepare our project.
3. Ensure everything is in working order by running `terraform plan`. **If errors are thrown, do not proceed until you have corrected the outlined problems.**

#### The Fun Part
1. When you're ready to go, run `terraform apply` to start deployment. After confirming correctness, this will automatically create all resources as defined in `vars.tf` and other TF files. **This will incur AWS charges.**
2. After Terraform completes successfuly, congratulations! You should now have a fully-configured AWS environment complete with a Parsec Host and HPR.
3. The last step is to Assign your Parsec Host in the Teams UI, and enter your `Parsec_HPR_IIP` under **App Rules** in the format of `1.2.3.4:4900`.

If your Parsec host doesn't populate right away, grab a cup of coffee or a snack. It can take 10-20 minutes for the Host to get ready. The HPR, however, is ready immediately.

---
Made in Toronto by Daniel Shiels (daniel.shiels@parsec.app)
