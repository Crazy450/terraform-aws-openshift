#!/usr/bin/env bash

# OpenShift setup
# See: https://docs.openshift.org/latest/install_config/install/host_preparation.html

# Install packages required to setup OpenShift.
yum install -y wget git net-tools bind-utils iptables-services bridge-utils bash-completion httpd-tools
yum update -y

yum-config-manager --enable rhui-REGION-rhel-server-extras

# Docker setup. Check the version with `docker version`, should be 1.12.
yum install -y docker

# http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-using-volumes.html
# Creating the docker storage setup to ensure we have a docker thin pool 
cat <<EOF > /etc/sysconfig/docker-storage-setup
DEVS=/dev/xvdf
VG=docker-vg
EOF

#
docker-storage-setup

# Restart docker and go to clean state as required by docker-storage-setup.
systemctl stop docker
rm -rf /var/lib/docker/*
systemctl restart docker

# Allow the ec2-user to sudo without a tty, which is required when we run post
# install scripts on the server.
echo Defaults:ec2-user \!requiretty >> /etc/sudoers