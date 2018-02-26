// Preparation Work on Servers script.
data "template_file" "prep_work_bastion" {
  template = "${file("${path.module}/files/prep_work_bastion.sh")}"
}

//  Launch configuration for the consul cluster auto-scaling group.
resource "aws_instance" "bastion" {
  ami                  = "ami-dcad28b8"
  instance_type        = "t2.micro"
  subnet_id            = "${aws_subnet.public-subnet.id}"
  user_data            = "${data.template_file.prep_work_bastion.rendered}"

  security_groups = [
    "${aws_security_group.openshift-vpc.id}",
    "${aws_security_group.openshift-ssh.id}",
    "${aws_security_group.openshift-public-egress.id}",
  ]

  key_name = "${aws_key_pair.keypair.key_name}"

  tags {
    Name    = "OpenShift Bastion"
    Project = "openshift"
  }
}
