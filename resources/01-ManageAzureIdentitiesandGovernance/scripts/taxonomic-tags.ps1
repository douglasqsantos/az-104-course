# Resource Groups and Taxonomic Tags

# See existing tags on a resource group
(Get-AzResourceGroup -Name 'cloudskills').Tags

# See existing tags for a particular resource
(Get-AzResource -ResourceId /subscriptions/<subscription-id>/resourceGroups/cloudskills/providers/Microsoft.Storage/storageAccounts/<storage-name>).Tags

# See existing tags for a named resource
(Get-AzResource -ResourceName 'cloudskills-keyvault1' -ResourceGroupName 'cloudskills').Tags

# Get resource groups that have a specific tag
(Get-AzResourceGroup -Tag @{ Dept = "Finance" }).ResourceGroupName

# Get resources that have a specific tag
(Get-AzResource -Tag @{ Dept = "Finance" }).Name

# Get resources that have a specific tag name
(Get-AzResource -TagName Dept).Name

# Add tags to RG without existing tags
Set-AzResourceGroup -Name cloudskills -Tag @{ Dept = "Sales"; Environment = "TheEnemy" }

# Add tags to RG that has existing tags
$tags = (Get-AzResourceGroup -Name cloudskills).Tags
$tags.Add("Status", "Approved")
Set-AzResourceGroup -Tag $tags -Name cloudskills

# Apply tags from an RG to its resources, preserving existing tags
$group = Get-AzResourceGroup "cloudskills"
if ($null -ne $group.Tags) {
    $resources = Get-AzResource -ResourceGroupName $group.ResourceGroupName
    foreach ($r in $resources) {
        $resourcetags = (Get-AzResource -ResourceId $r.ResourceId).Tags
        if ($resourcetags) {
            foreach ($key in $group.Tags.Keys) {
                if (-not($resourcetags.ContainsKey($key))) {
                    $resourcetags.Add($key, $group.Tags[$key])
                }
            }
            Set-AzResource -Tag $resourcetags -ResourceId $r.ResourceId -Force
        }
        else {
            Set-AzResource -Tag $group.Tags -ResourceId $r.ResourceId -Force
        }
    }
}

# Remove all tags
Set-AzResourceGroup -Tag @{ } -Name cloudskills