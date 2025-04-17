<powershell>

# Ensure script runs as admin
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "This script must be run as Administrator."
    exit
}

# Variables
$domainName = "TestDomain.local"
$netbiosName = "TESTDOMAIN"
$safeModePassword = ConvertTo-SecureString "P@ssw0rd123!" -AsPlainText -Force

# Install AD DS role
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Import the ADDSDeployment module
Import-Module ADDSDeployment

# Create new forest
Install-ADDSForest `
    -DomainName $domainName `
    -DomainNetbiosName $netbiosName `
    -SafeModeAdministratorPassword $safeModePassword `
    -InstallDNS `
    -Force `
    -NoRebootOnCompletion

# Reboot to finalize promotion
Restart-Computer -Force

</powershell>
