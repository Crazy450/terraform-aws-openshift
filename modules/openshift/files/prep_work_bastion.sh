#!/usr/bin/env bash

# Install packages required to setup OpenShift.
sudo yum -y install epel-release
sudo yum -y update all
sudo yum -y install -y wget git ansible vim net-tools bind-utils firewalld bridge-utils bash-completion kexec-tools NetworkManager psacct lsof strace nc telnet httpd-tools

# Allow the centos user to sudo without a pswd, which is required
cat <<EOF >> /etc/sudoers
centos	ALL=(all)	NOPASSWD: ALL
EOF

# Becoming Root for the next steps
sudo su - root

# Clone the openshift-ansible repo, which contains the installer.
git clone -b release-3.6 https://github.com/openshift/openshift-ansible /tmp/openshift-ansible
