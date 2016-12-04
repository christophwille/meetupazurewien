#requires -Version 5
configuration NewDomain
{
<#
    param
    (
        [PSCredential]
        [Parameter(Mandatory = $true)]
        [ValidateNotNullorEmpty()]
        $AdminCred
    )
#>

    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName xActiveDirectory
    Import-DscResource -ModuleName xPendingReboot
    Import-DscResource -ModuleName xDhcpServer
    Import-Module -Name AzureRM.Profile
    Import-Module -Name AzureRM.Resources
    Import-Module -Name AzureRM.KeyVault

# Get ServiceCredential and Connect to Keyvault
    $servicePrincipalConnection = Get-AutomationConnection -Name 'AzureRunAsConnection';
    Add-AzureRmAccount -ServicePrincipal `
                       -TenantId $servicePrincipalConnection.TenantId `
                       -ApplicationId $servicePrincipalConnection.ApplicationId `
                       -CertificateThumbprint $servicePrincipalConnection.CertificateThumbprint

    $Key = Get-AzureKeyVaultSecret -VaultName 'CWKeyVault01' -Name 'VMAdminPassword'
#    $AdminCred = Get-AzureRmAutomationCredential -Name 'JosefMaier' -ResourceGroupName 'CWAutomation01' -AutomationAccountName 'CWAutomation01';


    node ($AllNodes.Where{$_.Role -eq 'DomainController'}.NodeName )
    {
        WindowsFeature 'ADDSInstall'
        {
            Ensure = 'Present'
            Name = 'AD-Domain-Services'
        }
        
        xADDomain 'FirstDS'
        {
            DomainName = $Node.DomainName
            DomainAdministratorCredential = [pscredential]::new($Node.DomainName + '\' + $Key.Name,$Key.SecretValue)
            SafemodeAdministratorPassword = [pscredential]::new($Node.DomainName + '\' + $Key.Name,$Key.SecretValue)
            DependsOn = '[WindowsFeature]ADDSInstall'

        }
        xWaitForADDomain 'DscForestWait'
        {
            DomainName = $Node.DomainName
            DomainUserCredential = [pscredential]::new($Node.DomainName + '\' + $Key.Name,$Key.SecretValue)
            RetryCount = $Node.RetryCount
            RetryIntervalSec = $Node.RetryIntervalSec
            DependsOn = '[xADDomain]FirstDS'
        }

        # Install DHCP Server
        WindowsFeature 'DHCP'
        {
            Ensure = 'Present'
            Name = 'DHCP'
        }

        WindowsFeature 'RSAT-DHCP'
        {
            Ensure = 'Present'
            Name = 'RSAT-DHCP'
        }
        # Create Scopes
        foreach ($Scope in $Node.Scopes) 
        {
            xDhcpServerScope $Scope.Name
            {
                Name = $Scope.Name
                Ensure = 'Present'
                State = $Scope.State
                IPStartRange = $Scope.IPStartRange
                IPEndRange = $Scope.IPEndRange
                SubnetMask = $Scope.SubnetMask
                LeaseDuration = $Scope.LeaseDuration
                AddressFamily = $Scope.AddressFamily
            }
        }
    }
}


<#
Add-AzureRmAccount
$azAutoAccount = Get-AzureRmAutomationAccount | Out-GridView -Title 'Select Automation Account to Deploy Config to' -OutputMode Single
$Automation = Get-ChildItem -Path $PSScriptRoot -Recurse -File | ? { $_.Extension -eq '.ps1' }

Import-AzureRmAutomationDscConfiguration -SourcePath 'C:\Users\ChristophWilfing\Documents\GitHub\meetupazurewien\Meetup 2016-11-17\DeploymentSample\DSC\NewDomain.ps1' -Published -Force -ResourceGroupName $azAutoAccount.ResourceGroupName -AutomationAccountName $azAutoAccount.AutomationAccountName -LogVerbose $true
#>