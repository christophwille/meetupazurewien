$config = @{
  AllNodes = @(
  @{
    NodeName='*'
    PSDscAllowPlainTextPassword = $true
    PSDscAllowDomainUser = $true
  }
    @{  
        NodeName = 'lufthansa'
        Role= @('IIS')

        WebSites = @(
            @{
                Name = 'LuftHansa1'
                PhysicalPath = 'C:\inetpub\Lufthansa1'
                SourceFile = 'https://github.com/chwilfing/meetupazurewien/raw/master/Meetup%202016-11-17/DeploymentSample/DSC/iisstart.zip'
                BindingInfo = @{
                    Protocol              = 'http'
                    Port                  = '80'
                    HostName              = 'lufthansa1.2und40.at'
                    IPAddress             = '*'
                }
            },
            @{
                Name = 'LuftHansa2'
                PhysicalPath = 'C:\inetpub\Lufthansa2'
                SourceFile = 'https://github.com/chwilfing/meetupazurewien/raw/master/Meetup%202016-11-17/DeploymentSample/DSC/iisstart.zip'
                BindingInfo = @{
                    Protocol              = 'http'
                    Port                  = '80'
                    HostName              = 'lufthansa2.2und40.at'
                    IPAddress             = '*'
                }
            },
            @{
                Name = 'LuftHansa3'
                PhysicalPath = 'C:\inetpub\Lufthansa3'
                SourceFile = 'https://github.com/chwilfing/meetupazurewien/raw/master/Meetup%202016-11-17/DeploymentSample/DSC/iisstart.zip'
                BindingInfo = @{
                    Protocol              = 'http'
                    Port                  = '80'
                    HostName              = 'lufthansa3.2und40.at'
                    IPAddress             = '*'
                }
            },
            @{
                Name = 'NewWebSite'
                PhysicalPath = 'C:\inetpub\NewWebsite'
                SourceFile = 'https://github.com/chwilfing/meetupazurewien/raw/master/Meetup%202016-11-17/DeploymentSample/DSC/iisstart.zip'
                BindingInfo = @{
                    Protocol              = 'http'
                    Port                  = '80'
                    HostName              = 'NewWebsite.2und40.at'
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