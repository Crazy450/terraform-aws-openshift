# Openshift on AWS using Terraform

### How to Get Up and Running

**Step 1**
The first step is to clone the repository:  
```
mkdir ~/git ; cd ~/git
git clone https://github.com/Crazy450/terraform-aws-openshift.git
cd ~/git/terraform-aws-openshift
```

**Step 2**  
Then you will need to update the variable to include your aws profile:  

**How to create a profile:**  
```
aws configure --profile $ProfileName
# Follow the OnScreen Instructions
```

Then you will need to edit the variable file for terraform to include your Profile Name:
```
vim ~/git/terraform-aws-openshift/variables.tf
# Edit the line following block to replace the default value:
variable "profile" {
  description = "Profile configured using aws-cli"
  default = "$ProfileName"
}
```

**Step 3**  
Ensure you have an ssh key created within your machine, since it does get used and replicated on the hosts.  
```
ls -la ~/.ssh/id_rsa
ls -la ~/.ssh/id_rsa.pub
```

If there is no keys, you must create one, using the following command:
```
ssh-keygen # follow the on screen
```

**Step 4**  
copy the inventory file and replace the url for the master and public url:
```
cp ~/git/terraform-aws-openshift/inventory.template.cfg ~/git/terraform-aws-openshift/inventory.cfg
vim ~/git/terraform-aws-openshift/inventory.cfg
# Review and replace all variables within the configuration.
```

Then, you must upload the file to the bastion server:
```
scp ~/git/terraform-aws-openshift/inventory.cfg ec2-user@$(terraform output bastion-public_dns):~
chmod 744 ~/git/terraform-aws-openshift/install-from-bastion.sh
scp ~/git/terraform-aws-openshift/install-from-bastion.sh ec2-user@$(terraform output bastion-public_dns):~
```

**Generate the keys on the bashion server**
```
ssh ec2-user@$(terraform output bastion-public_dns)
mkdir ~/.ssh ; chmod 600 ~/.ssh
exit
```

Copy the keys over to ensure the Bashion is able to access the other servers via ssh without password:  
```
scp ~/.ssh/id_rsa ec2-user@$(terraform output bastion-public_dns):~/.ssh/id_rsa.new
scp ~/.ssh/id_rsa.pub ec2-user@$(terraform output bastion-public_dns):~/.ssh/id_rsa.pub.new
```

Execute the installation from the bashion server:  
```
~/git/terraform-aws-openshift/install-from-bastion.sh
```

Ensure you are able to connect to all hosts within your inventory

ansible -i ./inventory.cfg nodes -m ping
