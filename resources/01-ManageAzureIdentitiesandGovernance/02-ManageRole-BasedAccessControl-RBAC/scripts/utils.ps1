# https://docs.microsoft.com/en-us/powershell/azure/create-azure-service-principal-azureps?view=azps-4.6.1
Import-Module -Name Az.Resources
function New-Sp {
  param($Name)

  $spParams = @{
    StartDate = Get-Date
    EndDate = Get-Date -Year 2030
    Password = "P@ssw0rd2020"
  }

  $cred = New-Object Microsoft.Azure.Commands.ActiveDirectory.PSADPasswordCredentials -Property $spParams
  $sp = New-AzAdServicePrincipal -DisplayName $Name -PasswordCredential $cred

  Write-Output $sp
}

New-Sp -Name NetCoreWebApp
