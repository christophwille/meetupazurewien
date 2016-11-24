$config = @{
  AllNodes = @(
  @{
    NodeName='*'
    PSDscAllowPlainTextPassword = $true
    PSDscAllowDomainUser = $true
  }
    @{  
        NodeName = 'lufthansa'
        DomainName = '2und40.at'
        RetryCount = 10
        RetryIntervalSec = 30
        Role= @('IIS')

        WebSites = @(
            @{
                Name = 'LuftHansa'
                PhysicalPath = 'C:\inetpub\wwwroot'
                BindingInfo = @{
                    Protocol              = 'http'
                    Port                  = '80'
                    HostName              = 'lufthansa.2und40.at'
                    IPAddress             = '*'
                }
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