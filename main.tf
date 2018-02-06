//  Setup the core provider information.
provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"
}

//  Create the OpenShift cluster using our module.
module "openshift" {
  source          = "./modules/openshift"
  region          = "${var.region}"
  amisize         = "t2.large"    //  Smallest that meets the min specs for OS
  vpc_cidr        = "10.0.0.0/16"
  subnetaz        = "${var.subnetaz}"
  subnet_cidr     = "10.0.1.0/24"
  key_name        = "openshift"
  public_key_path = "${var.public_key_path}"
}

//  Output some useful variables for quick SSH access etc.
output "master1-url" {
  value = "https://${module.openshift.master1-public_ip}.xip.io:8443"
}
output "master1-public_dns" {
  value = "${module.openshift.master1-public_dns}"
}
output "master1-public_ip" {
  value = "${module.openshift.master1-public_ip}"
}
output "master2-public_ip" {
  value = "${module.openshift.master2-public_ip}"
}
output "master3-public_ip" {
  value = "${module.openshift.master3-public_ip}"
}
output "infra1-public_ip" {
  value = "${module.openshift.infra1-public_ip}"
}
output "infra2-public_ip" {
  value = "${module.openshift.infra2-public_ip}"
}
output "logging1-public_ip" {
  value = "${module.openshift.logging1-public_ip}"
}
output "metric1-public_ip" {
  value = "${module.openshift.metric1-public_ip}"
}
output "bastion-public_dns" {
  value = "${module.openshift.bastion-public_dns}"
}
output "bastion-public_ip" {
  value = "${module.openshift.bastion-public_ip}"
}
