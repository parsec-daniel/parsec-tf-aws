// Parsec hpr definition
resource "aws_instance" "parsec-tf-hpr1" {
    ami = "${data.aws_ami.parsecRelayAMI.id}"
    instance_type = "${var.parsecRelayType}"

    // VPC
    subnet_id = "${aws_subnet.parsec-tf-public-subnet.id}"

    // Security group
    vpc_security_group_ids = ["${aws_security_group.parsec-tf-public-sg.id}"]

    // Keypair for instance management
    key_name = "${var.awsKeypair}"

    // Parsec hpr install
    user_data = "${file("parsechpr_bootstrap.sh")}"

    // EC2 Name
    tags = {
      Name = "${var.hprAwsName}"
    }

}

//output EIP and IIP
output "Parsec_HPR_EIP" {
    value = "${aws_instance.parsec-tf-hpr1.public_ip}"
}
output "Parsec_HPR_IIP" {
    value = "${aws_instance.parsec-tf-hpr1.private_ip}"
}
