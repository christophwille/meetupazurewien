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
            DomainAdministratorCredential = Get-AutomationPSCredential -Name $Node.AdminCredName
            SafemodeAdministratorPassword = Get-AutomationPSCredential -Name $Node.AdminCredName
            DependsOn = '[WindowsFeature]ADDSInstall'

        }
        xWaitForADDomain 'DscForestWait'
        {
            DomainName = $Node.DomainName
            DomainUserCredential = Get-AutomationPSCredential -Name $Node.AdminCredName
            RetryCount = $Node.RetryCount
            RetryIntervalSec = $Node.RetryIntervalSec
            DependsOn = '[xADDomain]FirstDS'
        }
    }

    node ($AllNodes.Where{$_.Role -eq 'DHCP'}.NodeName ) {
        LocalConfigurationManager
        {
            ActionAfterReboot = 'ContinueConfiguration'
            ConfigurationMode = 'ApplyAndAutoCorrect'
            RebootNodeIfNeeded = $true
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

Import-AzureRmAutomationDscConfiguration -SourcePath C:\Users\ChristophWilfing\Documents\GitHub\AzureSamples\AzureDSC\DomainController\NewDomain.ps1 -Published -Force -ResourceGroupName $azAutoAccount.ResourceGroupName -AutomationAccountName $azAutoAccount.AutomationAccountName -LogVerbose $true
#>