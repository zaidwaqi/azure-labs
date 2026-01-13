param vnetName string
param location string = resourceGroup().location
param addressPrefix string = '10.0.0.0/16'
param subnetPrefix string = '10.0.1.0/24'

resource vnet 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    subnets: [
      {
        name: 'default'
        properties: {
          addressPrefix: subnetPrefix
        }
      }
    ]
  }
}
