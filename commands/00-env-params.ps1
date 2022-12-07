
$resourceGroup = "<your RG name>"
$vNetName = "<your vNet name>"
######################### DNS Zone specific ############################
$dnsZoneName = "<top level domain name>" #eg contoso.com
$subdomain ="venus" # This will be coming as subdomain.yourdomain.com eg: tenant1.contoso.com

######################## Public IP specific ############################
$publicIPName = "aag1-PublicIp" # change if it conflicts

############################ AAG Specific ##############################
$aagSubnetName = "aag1-subnet"
$aagName = "aag1"
$aagMIName = "aag1-ManagedIdentity"
############################ AKS Specific ##############################
$clusterName = "aks1"
$aksSubnetName = "aks1-subnet"
$email="<your email>" # used for cluster-issuer

########################## AKS app deployment ##########################
$tenantName = "venus" # this is nothing but the subdomain
$imageRepository = "ealen/echo-server" # eg: mendhak/http-https-echo, hashicorp/http-echo
