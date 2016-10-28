


$uri = 'https://s9events.azure-automation.net/webhooks?token=DGGfgc8BcXAOtkXrpwK%2f6Q%2brT2EwmronyK%2fRkMjBwzQ%3d'
$headers = @{"From"="Christoph@wilfing.biz";"Date"="05/28/2015 15:47:00"}

$Parameter  = @(
                @{ NumberOfInstances=2}
              )
$body = ConvertTo-Json -InputObject $Parameter

$response = Invoke-RestMethod -Method Post -Uri $uri -Headers $headers -Body $body

