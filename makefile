infrastructure:
	# Get the modules, create the infrastructure.
	terraform get && terraform apply

# Installs OpenShift on the cluster.
openshift_pre-install:
	# Create our inventory, copy to the master and run the install script.
	scp ~/git/terraform-aws-openshift/host centos@$(terraform output bastion-public_dns):~
	scp ~/git/terraform-aws-openshift/install-from-bastion.sh centos@$(terraform output bastion-public_dns):~
	scp ~/git/terraform-aws-openshift/scripts/postinstall-node.sh centos@$(terraform output bastion-public_dns):~
	scp ~/git/terraform-aws-openshift/scripts/postinstall-master.sh centos@$(terraform output bastion-public_dns):~

openshift_install:
	cat install-from-bastion.sh | ssh -o StrictHostKeyChecking=no -A centos@$(terraform output bastion-public_dns)

openshift_post_install:
	# Now the installer is done, run the postinstall steps on each host.
	for i in $(cat ~/host | grep openshift.local | awk {'print $1'} | grep -v "#" | sort | uniq -u | grep -v master); do cat ~/postinstall-node.sh | ssh -A centos@$i ; done
	for i in $(cat ~/host | grep openshift.local | awk {'print $1'} | grep -v "#" | sort | uniq -u | grep master); do cat ~/postinstall-master.sh | ssh -A centos@$i ; done
