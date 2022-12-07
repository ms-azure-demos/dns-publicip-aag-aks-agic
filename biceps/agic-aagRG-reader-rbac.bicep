param clusterName string

param agicToRGReaderRoleDefinitionName string = newGuid()

resource aks 'Microsoft.ContainerService/managedClusters@2022-09-01' existing = {
  name:clusterName
}

module builtinRBACRoles './modules/builtin-rbac-roles.bicep'  ={
  name:'builtinRBACRoles'
}

resource agicToRGReaderRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope:resourceGroup()
  name:agicToRGReaderRoleDefinitionName
  properties: {
    roleDefinitionId:builtinRBACRoles.outputs.readerRoleDefinitionId
    principalId:aks.properties.addonProfiles.ingressApplicationGateway.identity.objectId
    principalType:'ServicePrincipal'
  }
}
