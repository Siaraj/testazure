$connectionName = "AzureRunAsConnection"
        try
        {
            # Get the connection "AzureRunAsConnection "
            $servicePrincipalConnection=Get-AutomationConnection -Name $connectionName         

            "Logging in to Azure..."
            Add-AzureRmAccount `
                -ServicePrincipal `
                -TenantId $servicePrincipalConnection.TenantId `
                -ApplicationId $servicePrincipalConnection.ApplicationId `
                -CertificateThumbprint $servicePrincipalConnection.CertificateThumbprint 
        }
        catch {
            if (!$servicePrincipalConnection)
            {
                $ErrorMessage = "Connection $connectionName not found."
                throw $ErrorMessage
            } else{
                Write-Error -Message $_.Exception
                throw $_.Exception
            }
        }

$number1 = 10
$number2 = 20
$total = $number1 + $number2
write-output "total value is $total"

# Define the keyvault variables
#$automationKeyVaultName = Get-AutomationVariable -Name "kv-cdp-demo-enu1-aut"
$automationKeyVaultName = "kv-cdp-demo-enu1-aut"

# Create the customer variable in key vault
$customerName = "Demo"
$customerAzureAccntUseridVar = $customerName+"-Account-Userid";
$customerAzureAccntPasswordVar = $customerName+"-Account-Password"

write-verbose "customer vault var is $customerAzureAccntUseridVar , $customerAzureAccntPasswordVar "

# Get the customer credential from key vault
$customerAccntUserid = (get-azurekeyvaultsecret -vaultName $automationKeyVaultName -name $customerAzureAccntUseridVar).SecretValueText
$customerAccntPassword = (get-azurekeyvaultsecret -vaultName $automationKeyVaultName -name $customerAzureAccntPasswordVar).SecretValueText

write-verbose "customer user id is :$customerAccntUserid pass is :$customerAccntPassword "
write-verbose "completed"