param clusterName string
param aagMIName string

param agicToAAGMIRoleDefinitionName string = newGuid()

resource aks 'Microsoft.ContainerService/managedClusters@2022-09-01' existing = {
  name:clusterName
}

module builtinRBACRoles './modules/builtin-rbac-roles.bicep'  ={
  name:'builtinRBACRoles'
}
resource aagMI 'Microsoft.ManagedIdentity/userAssignedIdentities@2022-01-31-preview' existing = {
  name:aagMIName
}
resource agicToAAGIdentityContributorRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope:aagMI
  name:agicToAAGMIRoleDefinitionName
  properties:{
    roleDefinitionId:builtinRBACRoles.outputs.contributorRoleDefinitionId
    principalId:aks.properties.addonProfiles.ingressApplicationGateway.identity.objectId
    principalType:'ServicePrincipal'
  }
}
