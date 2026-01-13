$rgName   = "rg-infraascode-dev-sea-01"
$vnetName = "vnet-dev-sea-01"
$location = "southeastasia"

az deployment sub create `
  --name deploy-$rgName `
  --location $location `
  --template-file ResourceGroup.json `
  --parameters resourceGroupName=$rgName location=$location

az deployment group create `
  --resource-group $rgName `
  --name deploy-vnet `
  --template-file vnet.bicep `
  --parameters vnetName=$vnetName
