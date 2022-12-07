. ./00-env-params.ps1
az deployment group create -f ../biceps/mi.bicep -g $resourceGroup -p aagMIName=$aagMIName