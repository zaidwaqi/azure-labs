$scriptRoot = $PSScriptRoot
$roleDefinition   = "$scriptRoot/RoleDefinitions/CustomRoleVMPowerOperator.json"

New-AzRoleDefinition -InputFile $roleDefinition