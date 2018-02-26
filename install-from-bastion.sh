#!/bin/bash

# Adding the list of hosts into known host fileto remove the need to type Yes on initial ssh connexion
for i in $(cat ~/host | grep openshift.local | awk {'print $1'} | grep -v "#" | sort | uniq -u); do ssh-keyscan -t ecdsa $i >> ~/.ssh/known_hosts; done

# Communication test to ensure ssh working on all host
/usr/local/bin/ansible-playbook -i ./host nodes -m ping

# Run the playbook.
#/usr/local/bin/ansible-playbook -i ./host ./openshift-ansible/playbooks/byo/config.yml # uncomment for verbose! -vvv

# If needed, uninstall with the below:
# ansible-playbook playbooks/adhoc/uninstall.yml

# Post Installation Work
#for i in $(cat ~/host | grep openshift.local | awk {'print $1'} | grep -v "#" | sort | uniq -u | grep -v master); do cat ./scripts/postinstall-node.sh | ssh -A ec2-user@$i ; done
#for i in $(cat ~/host | grep openshift.local | awk {'print $1'} | grep -v "#" | sort | uniq -u | grep master); do cat ./scripts/postinstall-master.sh | ssh -A ec2-user@$i ; done
