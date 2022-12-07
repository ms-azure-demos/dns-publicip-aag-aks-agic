. ./00-env-params.ps1
$clusterIssuer="letsencrypt-application-gateway"
$template="cluster-issuer.yml"

# Check if the cluster issuer already exists
$result=$(kubectl get clusterissuer -n "default" -o jsonpath="{.items[?(@.metadata.name=='$clusterIssuer')].metadata.name}")

if ($result -ne $null) {
    echo "[$clusterIssuer] cluster issuer already exists"
    exit
}
else {
    "Going to install cluster-issuer as it's not present"
   
    #Get-Content ./commands/cluster-issuer.yml | yq  ".spec.acme.email  = `"youremail`"" # string interpolation is not working. So try formatting.
    #helm template certificate-issuer ./helm-certificate-issuer --debug --output-dir ./test --set email=$email
    helm upgrade certificate-issuer ../helm-certificate-issuer --install --set namespace="default" --set email=$email
    #Get-Content ./commands/cluster-issuer.yml | yq  e ('.spec.acme.email  = """{0}""' -f $email) | select $_ | kubectl apply -n "default" -f $_
}