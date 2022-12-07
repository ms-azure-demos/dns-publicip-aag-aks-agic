param vNetName string 
param aagSubnetName string
param aagMIName string
param aagName string 
param location string = resourceGroup().location
param publicIPName string
resource publicIp 'Microsoft.Network/publicIPAddresses@2022-05-01' existing = {
  name:publicIPName
}
resource AppGatewaySubnet 'Microsoft.Network/virtualNetworks/subnets@2022-05-01' existing = {
  name:'${vNetName}/${aagSubnetName}'
}
resource aagMI 'Microsoft.ManagedIdentity/userAssignedIdentities@2022-01-31-preview' existing = {
  name:aagMIName
}
resource aag 'Microsoft.Network/applicationGateways@2022-05-01' = {
  name:aagName
  location:location
  identity:{
    type: 'UserAssigned'
    userAssignedIdentities: {
          '${aagMI.id}':{}
    }
  }
  properties:{
    sku:{
      name:'Standard_v2'
      tier: 'Standard_v2'
    }
    autoscaleConfiguration:{
      minCapacity:1
      maxCapacity:2
    }
    gatewayIPConfigurations:[
      {
        name:'applicationGatewayIPConfiguration'
        properties:{
          subnet:{
            id:AppGatewaySubnet.id
          }
        }
      }  
    ]
    frontendIPConfigurations:[
      {
        name:'applicationGatewayFrontendIPConfiguration'
        properties:{
          publicIPAddress:{
            id:publicIp.id
          }
        }
      }
    ]
    frontendPorts:[
      {
       name: 'fp-443'
       properties:{
        port:443
       }   
      }
      {
        name: 'fp-80'
        properties:{
         port:80
        }   
       }
    ]
    httpListeners:[
      {
        name:'defaultListener'
        properties:{
          frontendIPConfiguration:{
            id:resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations',aagName,'applicationGatewayFrontendIPConfiguration')
        
          }
          frontendPort:{
            id:resourceId('Microsoft.Network/applicationGateways/frontendPorts',aagName,'fp-80')
          }
          protocol: 'Http'
        }
      }
    ]
    backendAddressPools:[
      {
        name:'defaultBackendAddressPool'
        properties:{
        }
      }
    ]
    backendHttpSettingsCollection:[ //to satisfy the bicep.Not in use  
      {
        name:'defaulBackendHttpSetting'
        properties:{
          port:80
          protocol:'Http'
        }
      }
    ]
    // backendSettingsCollection:[
    //   {
    //     name:'defaulthttpsetting'
    //   }
    // ]
    requestRoutingRules:[
      {
        name:'defaultRoutingRule'
        properties:{
          httpListener:{
            id:resourceId('Microsoft.Network/applicationGateways/httpListeners',aagName,'defaultListener')
          }
          backendHttpSettings:{
            id:resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection',aagName,'defaulBackendHttpSetting')
          }
          priority:10
          backendAddressPool:{  
            id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools',aagName,'defaultBackendAddressPool')
          }
        }
      }
    ]
  }
}
