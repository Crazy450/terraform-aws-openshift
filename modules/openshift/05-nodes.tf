//  Create an SSH keypair
resource "aws_key_pair" "keypair" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

//  Masters userdata script.
data "template_file" "prep_work" {
  template = "${file("${path.module}/files/prep_work.sh")}"

}

//  Creating the Master Servers Section
resource "aws_instance" "master1" {
  ami                  = "ami-dcad28b8"
  instance_type        = "m4.xlarge"
  subnet_id            = "${aws_subnet.public-subnet.id}"
  iam_instance_profile = "${aws_iam_instance_profile.openshift-instance-profile.id}"
  user_data            = "${data.template_file.prep_work.rendered}"

  security_groups = [
    "${aws_security_group.openshift-vpc.id}",
    "${aws_security_group.openshift-public-ingress.id}",
    "${aws_security_group.openshift-public-egress.id}",
  ]

  root_block_device {
    volume_size = 50
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 40
  }

  key_name = "${aws_key_pair.keypair.key_name}"

  tags {
    Name    = "OpenShift Master 1"
    Project = "openshift"
  }
}
resource "aws_instance" "master2" {
  ami                  = "ami-dcad28b8"
  instance_type        = "m4.xlarge"
  subnet_id            = "${aws_subnet.public-subnet.id}"
  iam_instance_profile = "${aws_iam_instance_profile.openshift-instance-profile.id}"
  user_data            = "${data.template_file.prep_work.rendered}"

  security_groups = [
    "${aws_security_group.openshift-vpc.id}",
    "${aws_security_group.openshift-public-ingress.id}",
    "${aws_security_group.openshift-public-egress.id}",
  ]

  root_block_device {
    volume_size = 50
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 40
  }

  key_name = "${aws_key_pair.keypair.key_name}"

  tags {
    Name    = "OpenShift Master 2"
    Project = "openshift"
  }
}
resource "aws_instance" "master3" {
  ami                  = "ami-dcad28b8"
  instance_type        = "m4.xlarge"
  subnet_id            = "${aws_subnet.public-subnet.id}"
  iam_instance_profile = "${aws_iam_instance_profile.openshift-instance-profile.id}"
  user_data            = "${data.template_file.prep_work.rendered}"

  security_groups = [
    "${aws_security_group.openshift-vpc.id}",
    "${aws_security_group.openshift-public-ingress.id}",
    "${aws_security_group.openshift-public-egress.id}",
  ]

  root_block_device {
    volume_size = 50
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 40
  }

  key_name = "${aws_key_pair.keypair.key_name}"

  tags {
    Name    = "OpenShift Master 3"
    Project = "openshift"
  }
}

// Section where we are creating the 2 Infras Servers
resource "aws_instance" "infra1" {
  ami                  = "ami-dcad28b8"
  instance_type        = "t2.large"
  subnet_id            = "${aws_subnet.public-subnet.id}"
  iam_instance_profile = "${aws_iam_instance_profile.openshift-instance-profile.id}"
  user_data            = "${data.template_file.prep_work.rendered}"

  security_groups = [
    "${aws_security_group.openshift-vpc.id}",
    "${aws_security_group.openshift-public-ingress.id}",
    "${aws_security_group.openshift-public-egress.id}",
  ]

  root_block_device {
    volume_size = 50
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 40
  }

  key_name = "${aws_key_pair.keypair.key_name}"

  tags {
    Name    = "OpenShift Infra 1"
    Project = "openshift"
  }
}
resource "aws_instance" "infra2" {
  ami                  = "ami-dcad28b8"
  instance_type        = "t2.large"
  subnet_id            = "${aws_subnet.public-subnet.id}"
  iam_instance_profile = "${aws_iam_instance_profile.openshift-instance-profile.id}"
  user_data            = "${data.template_file.prep_work.rendered}"

  security_groups = [
    "${aws_security_group.openshift-vpc.id}",
    "${aws_security_group.openshift-public-ingress.id}",
    "${aws_security_group.openshift-public-egress.id}",
  ]

  root_block_device {
    volume_size = 50
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 40
  }

  key_name = "${aws_key_pair.keypair.key_name}"

  tags {
    Name    = "OpenShift Infra 2"
    Project = "openshift"
  }
}

// Section where we are creating the Logging Servers
resource "aws_instance" "logging1" {
  ami                  = "ami-dcad28b8"
  instance_type        = "t2.large"
  subnet_id            = "${aws_subnet.public-subnet.id}"
  iam_instance_profile = "${aws_iam_instance_profile.openshift-instance-profile.id}"
  user_data            = "${data.template_file.prep_work.rendered}"

  security_groups = [
    "${aws_security_group.openshift-vpc.id}",
    "${aws_security_group.openshift-public-ingress.id}",
    "${aws_security_group.openshift-public-egress.id}",
  ]

  root_block_device {
    volume_size = 50
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 40
  }

  key_name = "${aws_key_pair.keypair.key_name}"

  tags {
    Name    = "OpenShift Logging 1"
    Project = "openshift"
  }
}
// Section where we are creating the Metric Servers
resource "aws_instance" "metric1" {
  ami                  = "ami-dcad28b8"
  instance_type        = "t2.large"
  subnet_id            = "${aws_subnet.public-subnet.id}"
  iam_instance_profile = "${aws_iam_instance_profile.openshift-instance-profile.id}"
  user_data            = "${data.template_file.prep_work.rendered}"

  security_groups = [
    "${aws_security_group.openshift-vpc.id}",
    "${aws_security_group.openshift-public-ingress.id}",
    "${aws_security_group.openshift-public-egress.id}",
  ]

  root_block_device {
    volume_size = 50
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 40
  }

  key_name = "${aws_key_pair.keypair.key_name}"

  tags {
    Name    = "OpenShift Metric 1"
    Project = "openshift"
  }
}

//  Section where we create the two Application Nodes
resource "aws_instance" "node1" {
  ami                  = "ami-dcad28b8"
  instance_type        = "t2.large"
  subnet_id            = "${aws_subnet.public-subnet.id}"
  iam_instance_profile = "${aws_iam_instance_profile.openshift-instance-profile.id}"
  user_data            = "${data.template_file.prep_work.rendered}"

  security_groups = [
    "${aws_security_group.openshift-vpc.id}",
    "${aws_security_group.openshift-public-ingress.id}",
    "${aws_security_group.openshift-public-egress.id}",
  ]

  root_block_device {
    volume_size = 50
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 40
  }

  key_name = "${aws_key_pair.keypair.key_name}"

  tags {
    Name    = "OpenShift Node 1"
    Project = "openshift"
  }
}
resource "aws_instance" "node2" {
  ami                  = "ami-dcad28b8"
  instance_type        = "t2.large"
  subnet_id            = "${aws_subnet.public-subnet.id}"
  iam_instance_profile = "${aws_iam_instance_profile.openshift-instance-profile.id}"
  user_data            = "${data.template_file.prep_work.rendered}"

  security_groups = [
    "${aws_security_group.openshift-vpc.id}",
    "${aws_security_group.openshift-public-ingress.id}",
    "${aws_security_group.openshift-public-egress.id}",
  ]

  root_block_device {
    volume_size = 50
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 40
  }

  key_name = "${aws_key_pair.keypair.key_name}"

  tags {
    Name    = "OpenShift Node 2"
    Project = "openshift"
  }
}

// Section where we are creating the Metric Servers
resource "aws_instance" "lb1" {
  ami                  = "ami-dcad28b8"
  instance_type        = "t2.medium"
  subnet_id            = "${aws_subnet.public-subnet.id}"
  iam_instance_profile = "${aws_iam_instance_profile.openshift-instance-profile.id}"
  user_data            = "${data.template_file.prep_work.rendered}"

  security_groups = [
    "${aws_security_group.openshift-vpc.id}",
    "${aws_security_group.openshift-public-ingress.id}",
    "${aws_security_group.openshift-public-egress.id}",
  ]

  root_block_device {
    volume_size = 50
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 40
  }

  key_name = "${aws_key_pair.keypair.key_name}"

  tags {
    Name    = "OpenShift LB 1"
    Project = "openshift"
  }
}

