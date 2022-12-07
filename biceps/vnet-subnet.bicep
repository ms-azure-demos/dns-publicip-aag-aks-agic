param clusterName string
param vNetName string
param appGatewaySubnetName string
param appGatewaySubnetAddress string
param aksSubnetAddress string
var aksSubnetName = '${clusterName}-subnet'

// resource vNet 'Microsoft.Network/virtualNetworks@2022-05-01' = {
//   name:vNetName
//   location:location
//   properties:{
//     addressSpace:{
//       addressPrefixes:[
//         vNetAddressSpace
//       ]
//     }
//   }
// }
resource AppGatewaySubnet 'Microsoft.Network/virtualNetworks/subnets@2022-05-01' = {
  name:'${vNetName}/${appGatewaySubnetName}'
  properties:{
    addressPrefix: appGatewaySubnetAddress
 }
}
resource aksSubnet 'Microsoft.Network/virtualNetworks/subnets@2022-05-01' = {
  name:'${vNetName}/${aksSubnetName}'
  // dependsOn:[
  //   vNet
  // ]
  properties:{
    addressPrefix: aksSubnetAddress
 }
}
