
<u> My NOTES </u>

<b>Objective:</b>
My objective of this project to create a dublicate enviroment of a small orginization on Azure using Terraform. (Later on might use Ansible) 

1. create Resource group, VNET, Subnet, Windows datacenter server ✔️ 
2. Set up AD ✔️
3. Bulk import Users to AD using powershell script
4. Set up file server and create network drive
5. create 3 departments with seperate subnet. Departments must be able to communicate via peering.




### Note ##
- To delete backup and clean up local files:

rm *.terraform.lock.hcl
rm *.tfstate.*
rm *.tfstate

- VM must have a public IP to access/RDP into it. (12/04/24)

- DO NOT DELETE tfstate file UNTILL YOU HAVE DESTROYED RESOURCES USING TERRAFORM DESTROY

- Use version 3.6.0 Terraform, Latest version asks for a subscription ID. Might be a bug!

- For VMs, You can replace the version number in the URN with latest to use the latest version of the image.

- Resource name cannot be all capitals