#!/usr/bin/env bash

# Install packages required to setup OpenShift.
sudo yum -y install epel-release
sudo yum -y update all
sudo yum -y install -y wget git ansible vim net-tools bind-utils firewalld bridge-utils bash-completion kexec-tools NetworkManager psacct lsof strace nc telnet httpd-tools

# Docker setup. Check the version with `docker version`, should be 1.12.
sudo yum install -y docker-1.12.6

# Creating the docker storage setup to ensure we have a docker thin pool 
cat <<EOF > /etc/sysconfig/docker-storage-setup
DEVS=/dev/xvdf
VG=docker-vg
EOF

# Configuring and installating Docker
docker-storage-setup

# Restart docker and go to clean state as required by docker-storage-setup.
systemctl stop docker
rm -rf /var/lib/docker/*
systemctl start docker
systemctl enable docker

# Allow the centos user to sudo without a pswd, which is required
cat <<EOF >> /etc/sudoers
centos	ALL=(all)	NOPASSWD: ALL
EOF

# Becoming Root for the next steps
sudo su - root

# Clone the openshift-ansible repo, which contains the installer.
git clone -b release-3.9 https://github.com/openshift/openshift-ansible /tmp/openshift-ansible
