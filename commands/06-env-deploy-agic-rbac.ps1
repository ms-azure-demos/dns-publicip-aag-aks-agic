. ./00-env-params.ps1
az deployment group create -f ../biceps/agic-rbac.bicep -g $resourceGroup -p clusterName=$clusterName -p aagName=$aagName -p aagMIName=$aagMIName #--what-if