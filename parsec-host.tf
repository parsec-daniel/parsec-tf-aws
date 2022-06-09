// Parsec host definition
resource "aws_instance" "parsec-tf-host1" {
    ami = "${data.aws_ami.parsecHostAMI.id}"
    instance_type = "${var.parsecHostType}"

    // Host disk size
    ebs_block_device {
      device_name = "/dev/sda1"
      volume_size = "${var.parsecHostDisk}"
    }

    // VPC
    subnet_id = "${aws_subnet.parsec-tf-private-subnet.id}"

    // Security group
    vpc_security_group_ids = ["${aws_security_group.parsec-tf-private-sg.id}"]

    // Keypair for password decryption
    key_name = "${var.awsKeypair}"

    // Parsec configuration options
    user_data =  "${var.parsecTeamsConfig}"

}
