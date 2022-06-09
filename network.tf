// This file defines a simple two-tier network. Edit at your own risk.

// AWS igw config
resource "aws_internet_gateway" "parsec-tf-igw" {
    vpc_id = "${aws_vpc.parsec-tf-vpc.id}"
    tags = {
        Name = "parsec-tf-igw"
    }
}

// AWS nat gateway config
resource "aws_eip" "parsec-tf-natgw-eip" {
  vpc = true
}

resource "aws_nat_gateway" "parsec-tf-natgw" {
  allocation_id = "${aws_eip.parsec-tf-natgw-eip.id}"
  subnet_id = "${aws_subnet.parsec-tf-public-subnet.id}"
  tags = {
    "Name" = "parsec-tf-natgw"
  }
}

// AWS public route table
resource "aws_route_table" "parsec-tf-public-crt" {
    vpc_id = "${aws_vpc.parsec-tf-vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.parsec-tf-igw.id}"
    }

    tags = {
        Name = "parsec-tf-public-crt"
    }
}

// AWS private route table
resource "aws_route_table" "parsec-tf-private-crt" {
    vpc_id = "${aws_vpc.parsec-tf-vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.parsec-tf-natgw.id}"
    }
    tags = {
        Name = "parsec-tf-private-crt"
    }
}

// AWS public route table association
resource "aws_route_table_association" "parsec-tf-crta-public-subnet" {
    subnet_id = "${aws_subnet.parsec-tf-public-subnet.id}"
    route_table_id = "${aws_route_table.parsec-tf-public-crt.id}"
}

// AWS private route table association
resource "aws_route_table_association" "parsec-tf-crta-private-subnet" {
    subnet_id = "${aws_subnet.parsec-tf-private-subnet.id}"
    route_table_id = "${aws_route_table.parsec-tf-private-crt.id}"
}

// AWS public security groups
resource "aws_security_group" "parsec-tf-public-sg" {
    vpc_id = "${aws_vpc.parsec-tf-vpc.id}"
    // Allow all out
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    // Allow ssh
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
	      cidr_blocks = ["0.0.0.0/0"]
    }
    // Allow parsec-hpr
    ingress {
	     from_port = 5000
        to_port = 5000
        protocol = "udp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    // Allow comms from private
    ingress {
	      from_port = 0
	      to_port = 0
	      protocol = -1
        cidr_blocks = ["172.26.17.0/24"]
    }
    tags = {
        Name = "parsec-tf-public-sg"
    }
}

// AWS private security groups
resource "aws_security_group" "parsec-tf-private-sg" {
    vpc_id = "${aws_vpc.parsec-tf-vpc.id}"
    // Allow all out
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    // Allow comms from public
    ingress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["172.26.16.0/24"]
    }
    tags = {
        Name = "parsec-tf-private-sg"
    }
}
