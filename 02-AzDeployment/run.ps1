$scriptRoot = $PSScriptRoot
$rgTemplate   = "$scriptRoot/Templates/ResourceGroup.json"
$vnetTemplate = "$scriptRoot/Templates/Vnet.bicep"

$random     = Get-Random -Minimum 10000 -Maximum 99999
$location   = "southeastasia"

$rgName     = "rg-infraascode-dev-sea-$random"
$vnetName   = "vnet-dev-sea-$random"

az deployment sub create `
  --name deploy-$rgName `
  --location $location `
  --template-file $rgTemplate `
  --parameters resourceGroupName=$rgName location=$location

az deployment group create `
  --resource-group $rgName `
  --name deploy-vnet `
  --template-file $vnetTemplate `
  --parameters vnetName=$vnetName
