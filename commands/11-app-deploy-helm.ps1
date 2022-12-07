##################### Merge credentials ######################
. ./00-env-params.ps1
az aks get-credentials --resource-group $resourceGroup  --name $clusterName
##############################################################

################### Params to change #########################
$location = "../helm"

##############################################################
$namespace = $tenantName # Convention - The name of namespace will be same as tenant name
$tenantHostName = "$tenantName.$dnsZoneName" # example - mars.contoso.com
helm upgrade $tenantName ../helm --install --set namespace=$namespace --set image.repository=$imageRepository --set image.tag=latest --set ingress.hosts[0].host=$tenantHostName --set ingress.tls[0].hosts[0]=$tenantHostName

# helm uninstall "venus"