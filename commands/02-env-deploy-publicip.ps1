. ./00-env-params.ps1
az deployment group create -f ../biceps/publicip.bicep -g $resourceGroup -p publicIPName=$publicIPName