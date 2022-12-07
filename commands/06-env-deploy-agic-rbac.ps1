. ./00-env-params.ps1
# Giving permissions one by one 
az deployment group create -f ../biceps/agic-aagRG-reader-rbac.bicep -g $resourceGroup -p clusterName=$clusterName #--what-if
"AGIC identity got reader permission on the resource group of AAG"
az deployment group create -f ../biceps/agic-aag-contributor-rbac.bicep -g $resourceGroup -p clusterName=$clusterName -p aagName=$aagName #--what-if
"AGIC identity got contributor permission on aag"
az deployment group create -f ../biceps/agic-aagMI-contributor-rbac.bicep -g $resourceGroup -p clusterName=$clusterName -p aagMIName=$aagMIName #--what-if
"AGIC identity got contributor permission on the managed identity of aag"