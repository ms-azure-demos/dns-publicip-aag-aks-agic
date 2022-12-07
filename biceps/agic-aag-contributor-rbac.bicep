param aagName string 
param clusterName string

param agicToAAGRoleDefinitionName string = newGuid()

resource aag 'Microsoft.Network/applicationGateways@2022-05-01' existing = {
  name:aagName
}
resource aks 'Microsoft.ContainerService/managedClusters@2022-09-01' existing = {
  name:clusterName
}
module builtinRBACRoles './modules/builtin-rbac-roles.bicep' = {
  name:'builtinRBACRoles'
}

resource agicToAAGContributorRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope:aag
  name:agicToAAGRoleDefinitionName
  properties: {
    roleDefinitionId: builtinRBACRoles.outputs.contributorRoleDefinitionId
    principalId:aks.properties.addonProfiles.ingressApplicationGateway.identity.objectId
    principalType:'ServicePrincipal'
  }
}
