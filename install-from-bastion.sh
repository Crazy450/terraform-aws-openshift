#!/bin/bash

# Install dev tools and Ansible 2.2
sudo yum install -y "@Development Tools" python2-pip openssl-devel python-devel gcc libffi-devel vim
sudo pip install -Iv ansible==2.3.0.0

# Clone the openshift-ansible repo, which contains the installer.
git clone -b release-3.6 https://github.com/openshift/openshift-ansible

# SSH Keys fix
mv -f ~/.ssh/id_rsa.new ~/.ssh/id_rsa
mv -f ~/.ssh/id_rsa.pub.new ~/.ssh/id_rsa.pub

# Adding the list of hosts into known host to remove the need to type Yes on initial ssh connexion
for i in $(cat ~/inventory.cfg | grep openshift.local | awk {'print $1'} | grep -v "#" | sort | uniq -u); do ssh-keyscan -t ecdsa $i >> ~/.ssh/known_hosts; done

# Communication test to ensure ssh working on all host
/usr/local/bin/ansible-playbook -i ./inventory.cfg nodes -m ping

# Run the playbook.
#/usr/local/bin/ansible-playbook -i ./inventory.cfg ./openshift-ansible/playbooks/byo/config.yml # uncomment for verbose! -vvv

# If needed, uninstall with the below:
# ansible-playbook playbooks/adhoc/uninstall.yml

# Post Installation Work
#for i in $(cat ~/inventory.cfg | grep openshift.local | awk {'print $1'} | grep -v "#" | sort | uniq -u | grep -v master); do cat ./scripts/postinstall-node.sh | ssh -A ec2-user@$i ; done
#for i in $(cat ~/inventory.cfg | grep openshift.local | awk {'print $1'} | grep -v "#" | sort | uniq -u | grep master); do cat ./scripts/postinstall-master.sh | ssh -A ec2-user@$i ; done