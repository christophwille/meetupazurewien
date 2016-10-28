$config = @{
  AllNodes = @(
  @{
    NodeName='*'
    PSDscAllowPlainTextPassword = $true
    PSDscAllowDomainUser = $true
  }
    @{  
        NodeName = 'FirstDOmainController'
        DomainName = '2und40.at'
        RetryCount = 10
        RetryIntervalSec = 30
        Role= @('DomainController','DHCP')
        Scopes = @(
                    @{
                        Name = 'Internal'
                        State = 'Active'
                        AddressFamily = 'IPv4'
                        IPStartRange = '10.10.10.20'
                        IPEndRange = '10.10.10.50'
                        SubnetMask = '255.255.255.0'
                        LeaseDuration = '00:08:00'
                    },
                    @{
                        Name = 'Internal1'
                        State = 'Active'
                        AddressFamily = 'IPv4'
                        IPStartRange = '10.10.11.20'
                        IPEndRange = '10.10.11.50'
                        SubnetMask = '255.255.255.0'
                        LeaseDuration = '00:08:00'
                    }
                 )
    }
  )
}
<#
Import-Module -Name AzureRM.Compute


#$AzureCredential = Get-Credential -Message 'AzureAdmin' -UserName 'user@irgendwas.onmicrosoft.com'

if ($AzureSubscription -eq $null) {
    Add-AzureRmAccount
    $AzureSubscription = Get-AzureRMSubscription | Out-GridView -Title 'Select Azure Subscription' -OutputMode Single
    
} else {
    Select-AzureRMSubscription -SubscriptionId $AzureSubscription.SubscriptionId
}

$DeploymentName = (New-Guid).Guid
$AzureResourceGroupName = ''
$AzureLocation = 'West Europe'

$azAutoAccount = Get-AzureRmAutomationAccount -ResourceGroupName 'CWAutomation01'


Start-AzureRmAutomationDscCompilationJob -ConfigurationName 'NewDomain' -ConfigurationData $config -AutomationAccountName $azAutoAccount.AutomationAccountName -ResourceGroupName $azAutoAccount.ResourceGroupName

#>	