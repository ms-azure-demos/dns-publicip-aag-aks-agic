. ./00-env-params.ps1
$appGatewaySubnetName
az deployment group create -f ../biceps/aag.bicep -g $resourceGroup -p vNetName=$vNetName -p aagSubnetName=$aagSubnetName -p aagName=$aagName -p publicIPName=$publicIPName -p aagMIName=$aagMIName
    
