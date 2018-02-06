//  The region we will deploy our cluster into.
variable "region" {
  description = "Region to deploy the cluster into"
    default = "ca-central-1"
}

variable "profile" {
  description = "Profile configured using aws-cli"
  default = "tf-aws-work"
}
//  The public key to use for SSH access.
variable "public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}

//  This map defines which AZ to put the 'Public Subnet' in.
variable "subnetaz" {
  type = "map"

  default = {
    ca-central-1 = "ca-central-1a"
    ca-central-1 = "ca-central-1b"
  }
}
