# Manage Role-Based Access Control (RBAC)

## Manage Azure Identities and Governance (15-20%)

What is role-based access control (RBAC) for Azure resources?
- Create a custom role
  - Tutorial: Create a custom role for Azure resources using Azure PowerShell
  - Tutorial: Create a custom role for Azure resources using Azure CLI
- Provide access to Azure resources by assigning roles
  - Add or remove role assignments using Azure RBAC and the Azure portal
- Interpret access assignments
  - List role assignments using Azure RBAC and the Azure portal
  - Understand deny assignments for Azure resources
- Manage multiple directories
  - Understand how multiple Azure Active Directory tenants interact


Listing the permission of a role
```powershell
Get-AzRoleDefinition -Name 'Virtual Machine Contributor'
```

Getting the actions
```powershell
$role = Get-AzRoleDefinition -Name 'Virtual Machine Contributor'
$role.Actions
Microsoft.Authorization/*/read
Microsoft.Compute/availabilitySets/*
Microsoft.Compute/locations/*
Microsoft.Compute/virtualMachines/*
Microsoft.Compute/virtualMachineScaleSets/*
Microsoft.Compute/disks/write
Microsoft.Compute/disks/read
Microsoft.Compute/disks/delete
Microsoft.DevTestLab/schedules/*
Microsoft.Insights/alertRules/*
Microsoft.Network/applicationGateways/backendAddressPools/join/action
Microsoft.Network/loadBalancers/backendAddressPools/join/action
Microsoft.Network/loadBalancers/inboundNatPools/join/action
Microsoft.Network/loadBalancers/inboundNatRules/join/action
Microsoft.Network/loadBalancers/probes/join/action
Microsoft.Network/loadBalancers/read
Microsoft.Network/locations/*
Microsoft.Network/networkInterfaces/*
Microsoft.Network/networkSecurityGroups/join/action
Microsoft.Network/networkSecurityGroups/read
Microsoft.Network/publicIPAddresses/join/action
Microsoft.Network/publicIPAddresses/read
Microsoft.Network/virtualNetworks/read
Microsoft.Network/virtualNetworks/subnets/join/action
Microsoft.RecoveryServices/locations/*
Microsoft.RecoveryServices/Vaults/backupFabrics/backupProtectionIntent/write
Microsoft.RecoveryServices/Vaults/backupFabrics/protectionContainers/protectedItems/*/read
Microsoft.RecoveryServices/Vaults/backupFabrics/protectionContainers/protectedItems/read
Microsoft.RecoveryServices/Vaults/backupFabrics/protectionContainers/protectedItems/write
Microsoft.RecoveryServices/Vaults/backupPolicies/read
Microsoft.RecoveryServices/Vaults/backupPolicies/write
Microsoft.RecoveryServices/Vaults/read
Microsoft.RecoveryServices/Vaults/usages/read
Microsoft.RecoveryServices/Vaults/write
Microsoft.ResourceHealth/availabilityStatuses/read
Microsoft.Resources/deployments/*
Microsoft.Resources/subscriptions/resourceGroups/read
Microsoft.SqlVirtualMachine/*
Microsoft.Storage/storageAccounts/listKeys/action
Microsoft.Storage/storageAccounts/read
Microsoft.Support/*
```

Processing a custom role
```powershell
CD $HOME

wget https://gist.github.com/mikepfeiffer/176776a8758b4e2910554a5c33392c12/raw/e48369b8aa73348606e76cbebc603d9e89c56666/customRoleDefinition.json

$subscription_id = (Get-AzContext).Subscription.id

(Get-Content -Path $HOME/customRoleDefinition.json) -Replace 'SUBSCRIPTION_ID', $subscription_id | 
  Set-Content -Path $HOME/customRoleDefinition.json

New-AzRoleDefinition -InputFile ./customRoleDefinition.json

Get-AzRoleDefinition -Name 'Virtual Machine Operator (Custom)'
```