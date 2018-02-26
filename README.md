# Openshift on AWS using Terraform

This project shows you how to set up OpenShift Origin on AWS using Terraform.

The infrastructure is composed of the following servers:  
- 3 Masters Node  
- 2 Infra Node  
- 1 Metric Node  
- 1 Logging Node  
- 2 Application Node  
- 1 Bashion server  

A Load balancer configuration is also included, to ensure the load and requests are being properly replicated within all of the masters and Infra servers.  

Prior to start, you must ensure you already have an aws account.  

### Terraform Section

**Step 1**  
The first step is to clone the repository:  
```
mkdir ~/git ; cd ~/git
git clone ssh://git@git.bnc.ca:7999/iac/iac_openshift.git 
cd ~/git/iac_openshift
```

**Step 2**  
Then you will need to update the variable to include your aws profile:  

**How to create a profile:**  

On aws, access the IAM section, and create a new user with the following accesses:  
- Programmatic access  
Attach the following Policy Access:  
- AdministratorAccess  
*don't forget to save the cvs file, since you will need it for the next step.*  

**How to import profile into aws-cli**  
```
aws configure --profile $ProfileName
# Follow the OnScreen Instructions
```

Then you will need to edit the variable file for terraform to include your Profile Name:
```
vim ~/git/iac_openshift/variables.tf
# Edit the line following block to replace the default value:
variable "profile" {
  description = "Profile configured using aws-cli"
  default = "$ProfileName"
}
```

You must initiate terraform, use the following command:  
```
cd ~/git/iac_openshift/
terraform init
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
Create your infrastructure using Terraform, using the following command:  
```
terraform plan 
# if the previous command did not retrun and errors, you should be good to install, run the following command now:  
terraform apply
```
*This step might take a few minutes since we are creating multiple file:*  
- Vpc  
- Instance  
- Security Group and policies  
- Route53 DNS Entries  
- Load Balancers  
- and much more  

### Openshift Section

**Step 5**  
Replace the url for the master and public url:  
```
vim ~/git/iac_openshift/inventory.cfg
# Review and replace all variables within the configuration.
```

Then, you must upload the file to the bastion server:  
```
scp ~/git/iac_openshift/inventory.cfg ec2-user@$(terraform output bastion-public_dns):~
chmod 744 ~/git/iac_openshift/install-from-bastion.sh
scp ~/git/iac_openshift/install-from-bastion.sh ec2-user@$(terraform output bastion-public_dns):~
```

**Generate the keys on the bashion server**
```
ssh ec2-user@$(terraform output bastion-public_dns)
ssh-keygen
exit
```

**Execute the installation from the bashion server:**  
```
ssh ec2-user@$(terraform output bastion-public_dns)
~/git/iac_openshift/install-from-bastion.sh
```
