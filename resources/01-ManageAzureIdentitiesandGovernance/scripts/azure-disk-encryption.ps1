New-AzKeyVault -name 'cloudskills704kv' -ResourceGroupName 'CloudSkills' -Location EastUS2 -EnabledForDiskEncryption

$KeyVault = Get-AzKeyVault -VaultName 'cloudskills704kv' -ResourceGroupName 'CloudSkills'

Set-AzVMDiskEncryptionExtension -ResourceGroupName 'CloudSkills' -VMName 'win1' `
   -DiskEncryptionKeyVaultUrl $KeyVault.VaultUri `
   -DiskEncryptionKeyVaultId $KeyVault.ResourceId