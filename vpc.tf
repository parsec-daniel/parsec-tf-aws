// This file defines the VPC and associated subnets.

// AWS vpc definition
resource "aws_vpc" "parsec-tf-vpc" {
    cidr_block = "172.26.0.0/16"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    instance_tenancy = "default"
    tags = {
        Name = "parsec-tf-vpc"
    }
}

// AWS public subnet definition
resource "aws_subnet" "parsec-tf-public-subnet" {
    vpc_id = "${aws_vpc.parsec-tf-vpc.id}"
    cidr_block = "172.26.16.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "${var.awsZone}"
    tags = {
        Name = "parsec-tf-public-subnet"
    }
}

// AWS private subnet definition
resource "aws_subnet" "parsec-tf-private-subnet" {
    vpc_id = "${aws_vpc.parsec-tf-vpc.id}"
    cidr_block = "172.26.17.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "${var.awsZone}"
    tags = {
        Name = "parsec-tf-private-subnet"
    }
}
