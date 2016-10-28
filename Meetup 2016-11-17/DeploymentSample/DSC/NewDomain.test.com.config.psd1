$config = @{
  AllNodes = @(
    @{
        NodeName = '*';
        PSDscAllowPlainTextPassword = $True;
        PSDscAllowDomainUser = $True;
    }
    @{  
        NodeName = 'cwtestdc0' ;
        DomainName = 'test.com';
        RetryCount = 10;
        RetryIntervalSec = 30;
        Role= @('DomainController','DHCP');
        AdminCredName = 'TestDomAdmin'; #Name of Credential in automation account
        Scopes = @(
                    @{
                        Name = 'Internal';
                        State = 'Active';
                        AddressFamily = 'IPv4';
                        IPStartRange = '10.10.10.20';
                        IPEndRange = '10.10.10.50';
                        SubnetMask = '255.255.255.0';
                        LeaseDuration = '00:08:00';
                    },
                    @{
                        Name = 'Internal1';
                        State = 'Active';
                        AddressFamily = 'IPv4';
                        IPStartRange = '10.10.11.20';
                        IPEndRange = '10.10.11.50';
                        SubnetMask = '255.255.255.0';
                        LeaseDuration = '00:08:00';
                    }
                 )
    }
        @{  
        NodeName = 'cwtestdc1' ;
        DomainName = '2und40.com';
        RetryCount = 10;
        RetryIntervalSec = 30;
        Role= @('DomainController','DHCP');
        AdminCredName = 'TestDomAdmin'; #Name of Credential in automation account
        Scopes = @(
                    @{
                        Name = 'Internal';
                        State = 'Active';
                        AddressFamily = 'IPv4';
                        IPStartRange = '10.10.12.20';
                        IPEndRange = '10.10.12.50';
                        SubnetMask = '255.255.255.0';
                        LeaseDuration = '00:08:00';
                    },
                    @{
                        Name = 'Internal1';
                        State = 'Active';
                        AddressFamily = 'IPv4';
                        IPStartRange = '10.10.13.20';
                        IPEndRange = '10.10.13.50';
                        SubnetMask = '255.255.255.0';
                        LeaseDuration = '00:08:00';
                    }
                 )
    }
  )
}

<#
Start-AzureRmAutomationDscCompilationJob -ConfigurationName 'NewDomain' -ConfigurationData (Resolve-Path -Path .\NewDomain.config.psd1).Path -AutomationAccountName $azAutoAccount.AutomationAccountName -ResourceGroupName $azAutoAccount.ResourceGroupName

#>