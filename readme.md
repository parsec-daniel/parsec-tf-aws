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
 - Port *Paper Mario: The Thousand Year Door* to Nintendo Switch

Please use the `vars.tf` file to configure this Terraform template.
Editing the other TF files is not recommended, but can be done.

Use at your own risk. **The Parsec Team offers no warranty for this template,
and cannot reimburse you for AWS resource charges.**

---
# Getting Started
#### Basic Requirments
 - A Parsec for Teams Enterprise Subscription
 - An AWS Account with ~~phenomenal cosmic powers~~ the ability to create resources like VPCs, Subnets, EC2, Keypairs, and so on.
 - `terraform` on your Mac/PC, if you're running locally.

#### Preparing the Variables
0. `git clone` this repo onto your machine.
1. Open the `vars.tf` file within the `parsec-tf-aws` folder.
2. Obtain your AWS IAM information from the AWS dashboard.
3. Pick your region and zone (e.g. `ca-central-1` for region, and `ca-central-1b` for zone).
4. [Create your Teams configuration string by following our docs.](https://support.parsec.app/hc/en-us/articles/4408962860813-AWS-Marketplace-Listing-Usage-Instructions)
5. [Generate a Keypair in AWS EC2.](https://docs.aws.amazon.com/ground-station/latest/ug/create-ec2-ssh-key-pair.html) **Save this key! You'll need it to decrypt the Windows password.**
6. Fill-in the gathered information within the `vars.tf` file.

#### Adding the ~Ingredients~ Variables to `vars.tf`
There are **six** required variables within the `vars.tf` file.
1. `awsAccessKey` your IAM access key from AWS.
2. `awsSecretKey` your IAM secret key.
3. `awsRegion` defines the region where all resources will be deployed.
4. `awsZone` defines the zone *within* our region.
5. `awsKeypair` the name of the EC2 keypair you created in **Step 5** above.
6. `parsecTeamsConfig` is your complete Parsec for Teams string in the following format:
```
 team_id=1234:key=5678:name=mycoolhost:user_email=person@company.com:is_guest_access=true
```
You can further customize the Teams string by [following our guide here.](https://support.parsec.app/hc/en-us/articles/360054176332-Team-Computers)

All other variables are *optional* and can be customized according to your preferences.

#### Getting Terraform Ready
1. Using a terminal emulator, `cd` to the working directory `parsec-tf-aws`.
2. Get Terraform acclimated by running `terraform init`. This will prepare our project.
3. Ensure everything is in working order by running `terraform plan`. **If errors are thrown, do not proceed until you have corrected the outlined problems.**

#### The Fun Part
1. When you're ready to go, run `terraform apply` to start deployment. After confirming correctness, this will automatically create all resources as defined in `vars.tf` and other TF files. **This will incur AWS charges.**
2. After Terraform completes successfully, congratulations! You should now have a fully-configured AWS environment complete with a Parsec Host and HPR.
3. The last step is to assign your Parsec Host in the Teams UI, and enter your `Parsec_HPR_IIP` under **App Rules** in the format of `1.2.3.4:4900`.

If your Parsec host doesn't populate right away, grab a cup of coffee or a snack. It can take 10-20 minutes for the Host to get ready. The HPR, however, is ready immediately.

---
# Troubleshooting
#### AWS Issues
If you run into errors like: `Error creating EIP: AddressLimitExceeded: The maximum number of addresses has been reached.` Please ensure your AWS account has at least **2** Elastic IPs available for allocation. **Same goes for vCPU errors**; this template *cannot* increase your EIP or vCPU allocations automatically.

If you receive an `availabilityZone is invalid` error, please follow the guidance in the error message. Some AWS zones like `us-west-1a` cannot host resources.

#### HPR Issues
In the event your HPR isn't functioning, ensure that the following are true (e.g. `6023` errors on the host and/or client):
  - You have an active Parsec for Teams Enterprise subscription.
  - [The HPR is properly configured in the Parsec for Teams UI.](https://support.parsec.app/hc/en-us/articles/360054483251-The-Parsec-Relay-Server-An-On-Prem-High-Performance-Relay-Server)

If the above are true, try these steps:
  - Reboot the HPR EC2 instance.
  - Reboot the Host EC2 instance (sometimes the Relay IP isn't detected by Parsec right away).
  - If you are still seeing errors, use `ssh` on your local machine to connect to the HPR EIP.
    - Once connected, run `sudo service parsechpr status`. This should return a result like this:
    ```
    ● parsechpr.service - Parsec High Performance Relay
     Loaded: loaded (/etc/systemd/system/parsechpr.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2022-06-02 00:37:08 UTC; 1 months 5 days ago
     Main PID: 665 (parsechpr)
     Tasks: 1 (limit: 4610)
     Memory: 1.8M
     CGroup: /system.slice/parsechpr.service
             └─665 /bin/parsechpr x.x.x.x 5000 4900
    ```
    - If this command fails, you will need to manually launch the HPR [using our documentation.](https://support.parsec.app/hc/en-us/articles/360054483251-The-Parsec-Relay-Server-An-On-Prem-High-Performance-Relay-Server)

#### Parsec Issues
If you've made it this far, congratulations! Most issues from here-on-out are addressed in our [documentation.](https://support.parsec.app/hc/en-us)

---
Made in Toronto by Daniel Shiels (daniel.shiels@parsec.app)
