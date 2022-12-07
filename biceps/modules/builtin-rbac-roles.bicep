@description('This is the built-in Contributor role. See https://docs.microsoft.com/azure/role-based-access-control/built-in-roles#contributor')
resource contributorRoleDefinition 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  scope: subscription()
  name: 'b24988ac-6180-42a0-ab88-20f7382dd24c'
}
output contributorRoleDefinitionId string = contributorRoleDefinition.id
@description('This is the built-in Reader role. See https://docs.microsoft.com/azure/role-based-access-control/built-in-roles#contributor')
resource readerRoleDefinition 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing= {
scope:subscription()
name:'acdd72a7-3385-48ef-bd42-f606fba81ae7'
}
output readerRoleDefinitionId string = readerRoleDefinition.id
