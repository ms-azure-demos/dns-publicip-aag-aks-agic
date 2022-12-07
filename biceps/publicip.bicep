param publicIPName string
resource publicIp 'Microsoft.Network/publicIPAddresses@2022-05-01' = {
  name:publicIPName
  location: resourceGroup().location
  properties:{
    publicIPAllocationMethod: 'Static'
  }
  sku:{
    name:'Standard'
    tier: 'Regional'
  }
}
