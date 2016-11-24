configuration WebServer
{

    Import-DscResource -ModuleName xWebAdministration


    node ($AllNodes.Where{$_.Role -eq 'IIS'}.NodeName )
    {
        LocalConfigurationManager
        {
            ConfigurationMode = 'ApplyAndAutoCorrect'
            RebootNodeIfNeeded = $true
        }

        WindowsFeature Web-Server                     { Ensure = 'Present';Name = 'Web-Server' }
        WindowsFeature Web-Mgmt-Tools                 { Ensure = 'Present';Name = 'Web-Mgmt-Tools' }
        WindowsFeature Web-Mgmt-Console               { Ensure = 'Present';Name = 'Web-Mgmt-Console' }
        WindowsFeature Web-WebServer                  { Ensure = 'Present';Name = 'Web-WebServer' }
        WindowsFeature Web-Common-Http                { Ensure = 'Present';Name = 'Web-Common-Http' }
        WindowsFeature Web-Default-Doc                { Ensure = 'Present';Name = 'Web-Default-Doc' }
        WindowsFeature Web-Performance                { Ensure = 'Present';Name = 'Web-Performance' }
        WindowsFeature Web-Static-Content             { Ensure = 'Present';Name = 'Web-Static-Content' }
        WindowsFeature Web-Stat-Compression           { Ensure = 'Present';Name = 'Web-Stat-Compression' }
        WindowsFeature Web-Dyn-Compression            { Ensure = 'Present';Name = 'Web-Dyn-Compression' }
        WindowsFeature Web-Security                   { Ensure = 'Present';Name = 'Web-Security' }
        WindowsFeature Web-Filtering                  { Ensure = 'Present';Name = 'Web-Filtering' }
        WindowsFeature Web-Windows-Auth               { Ensure = 'Present';Name = 'Web-Windows-Auth' }
        WindowsFeature Web-App-Dev                    { Ensure = 'Present';Name = 'Web-App-Dev' }
        WindowsFeature Web-Net-Ext45                  { Ensure = 'Present';Name = 'Web-Net-Ext45' }
        WindowsFeature Web-Asp-Net45                  { Ensure = 'Present';Name = 'Web-Asp-Net45' }
        WindowsFeature Web-ISAPI-Ext                  { Ensure = 'Present';Name = 'Web-ISAPI-Ext' }
        WindowsFeature Web-ISAPI-Filter               { Ensure = 'Present';Name = 'Web-ISAPI-Filter' }
        WindowsFeature Web-Includes                   { Ensure = 'Present';Name = 'Web-Includes' }
        WindowsFeature Windows-Identity-Foundation    { Ensure = 'Present';Name = 'Windows-Identity-Foundation' }

        # Stop the default website
        xWebsite DefaultSite 
        {
            Ensure          = 'Present'
            Name            = 'Default Web Site'
            State           = 'Stopped'
            PhysicalPath    = 'C:\inetpub\wwwroot'
            DependsOn       = '[WindowsFeature]Web-Server'
        }

        foreach ($WebSite in $Node.WebSites)
        {
            xWebsite $WebSite.Name
            {
                Ensure = 'Present'
                Name = $WebSite.Name
                PhysicalPath = $WebSite.PhysicalPath
                BindingInfo = $WebSite.BindingInfo
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