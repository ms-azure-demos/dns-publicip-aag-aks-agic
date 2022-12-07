param location string = resourceGroup().location
param clusterName string
param nodeCount int = 1
param vmSize string = 'standard_d2s_v5'
param aagName string
param vNetName string 
param aksSubnetName string

// resource mi 'Microsoft.ManagedIdentity/userAssignedIdentities@2022-01-31-preview' existing = {
//   name: aigcManagedIdentityName
//   scope: resourceGroup('MC_K8ClusterWithAGIC_aks-do3sscryjv3nw_northcentralus')
// }
resource aksSubnet 'Microsoft.Network/virtualNetworks/subnets@2022-05-01' existing  ={
  name:'${vNetName}/${aksSubnetName}'
}
resource aag 'Microsoft.Network/applicationGateways@2022-05-01' existing = {
  name:aagName
}
resource aks 'Microsoft.ContainerService/managedClusters@2022-09-01' = {
  location:location
  name:clusterName
  dependsOn:[
  ]
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    dnsPrefix: clusterName
    enableRBAC: true
    agentPoolProfiles: [
      {
        name: 'linuxpool1'
        count: nodeCount
        vmSize: vmSize
        mode: 'System'
        vnetSubnetID:aksSubnet.id
      }
    ]
    networkProfile: {
      networkPlugin:'azure' 
      serviceCidr:'10.240.0.0/16'
      dnsServiceIP:'10.240.0.10'
    }
    addonProfiles : {
      ingressApplicationGateway: {
        config: {
          applicationGatewayId: aag.id
        }
        enabled: true
        // identity: { //Seems this is readonly. The MI will be created new and needs to give permissions separately to AAG and 
        //   clientId: mi.properties.clientId
        //   objectId: mi.properties.principalId
        //   resourceId: mi.id
        // }
      }
    }
  }
}
