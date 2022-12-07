param aagMIName string
resource aagMI 'Microsoft.ManagedIdentity/userAssignedIdentities@2022-01-31-preview' = {
  name:aagMIName
  location:resourceGroup().location

}
