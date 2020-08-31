# Sign in and get context
Get-AzContext | Format-List

# Load AzureAD module
install-module -name AzureAD -Verbose

# Sign in
# Connect-AzureAD
Connect-AzAccount

# Command exploration
Get-Command -Module AzureAD Noun AzureADUser

# Bulk update user properties (Ref:)
# $adGroupId = "<Azure AD Group ID here>"

# $users = Get-AzureADGroupMemberr -ObjectID $adGroupId
$users = Get-AzADGroupMember -ObjectId dabd1502-1279-4f1d-9a71-e20c9d1fb5a4

foreach($u in $users){
  Write-Host $u.DisplayName
  Set-AzureADUser -ObjectId $u.Mail -Department "<New value to update here>"
}