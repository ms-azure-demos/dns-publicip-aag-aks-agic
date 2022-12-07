param aagName string 
param clusterName string
param aagMIName string

param agicToRGReaderRoleDefinitionName string = newGuid()
param agicToAAGRoleDefinitionName string = newGuid()
param agicToAAGMIRoleDefinitionName string = newGuid()

resource aag 'Microsoft.Network/applicationGateways@2022-05-01' existing = {
  name:aagName
}
resource aks 'Microsoft.ContainerService/managedClusters@2022-09-01' existing = {
  name:clusterName
}
@description('This is the built-in Contributor role. See https://docs.microsoft.com/azure/role-based-access-control/built-in-roles#contributor')
resource contributorRoleDefinition 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  scope: subscription()
  name: 'b24988ac-6180-42a0-ab88-20f7382dd24c'
}
@description('This is the built-in Reader role. See https://docs.microsoft.com/azure/role-based-access-control/built-in-roles#contributor')
resource readerRoleDefinition 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing= {
scope:subscription()
name:'acdd72a7-3385-48ef-bd42-f606fba81ae7'
}

resource agicToRGReaderRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope:resourceGroup()
  name:agicToRGReaderRoleDefinitionName
  properties: {
    roleDefinitionId:readerRoleDefinition.id
    principalId:aks.properties.addonProfiles.ingressApplicationGateway.identity.objectId
    principalType:'ServicePrincipal'
  }
}
resource agicToAAGContributorRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope:aag
  name:agicToAAGRoleDefinitionName
  properties: {
    roleDefinitionId:contributorRoleDefinition.id
    principalId:aks.properties.addonProfiles.ingressApplicationGateway.identity.objectId
    principalType:'ServicePrincipal'
  }
}
resource aagMI 'Microsoft.ManagedIdentity/userAssignedIdentities@2022-01-31-preview' existing = {
  name:aagMIName
}
resource agicToAAGIdentityContributorRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope:aagMI
  name:agicToAAGMIRoleDefinitionName
  properties:{
    roleDefinitionId:contributorRoleDefinition.id
    principalId:aks.properties.addonProfiles.ingressApplicationGateway.identity.objectId
    principalType:'ServicePrincipal'
  }
}
