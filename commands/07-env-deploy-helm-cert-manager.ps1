##################### Merge credentials ######################
. ./00-env-params.ps1
az aks get-credentials --resource-group $resourceGroup  --name $clusterName
##############################################################

$version="v1.7.2"
helm repo add "jetstack" "https://charts.jetstack.io"
helm install "cert-manager" "jetstack/cert-manager" `
--create-namespace `
--namespace "cert-manager" `
--set installCRDs=true `
--set version=$version `
--set nodeSelector."kubernetes\.io/os"=linux
