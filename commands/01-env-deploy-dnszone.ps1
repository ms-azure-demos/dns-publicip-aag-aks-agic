# https://learn.microsoft.com/en-us/azure/dns/dns-get-started-bicep?tabs=CLI
. ./00-env-params.ps1
az deployment group create -f ../biceps/dnszone.bicep -g $resourceGroup -p subdomain=$subdomain -p dnsZoneName=$dnsZoneName