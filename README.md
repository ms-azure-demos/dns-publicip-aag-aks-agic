# dns-aag-aks-agic
Demos end to end setup of DNS Zone to AAG to AKS with App gateway Ingress Controller

# Prerequisite

- Az command line tool
- Azure subscription

# Running

- Replace values in [00-env-params](/commands/00-env-params.ps1)
- Change the working directory to [./commands](/commands/)   
- Execute the powershell files inside [./commands](/commands/) one by one sequentially based on prefix number.
  - The files 01-env to 05-env are straightforward as the name. They deploy Azure services by invoking the .bicep files
  - The 06-env-deploy-agic-rbac.ps1 setup permissions to AGIC to update the Azure Application Gateway
  - 07-env and 09-env is to install cert manager and cluster issuer. These are required to setup SSL. The SSL certificates are issued from Let's encrypt.
  - 11-app-deploy-helm.ps1 deploys the application to Kubernetes.

# Tech used

- Azure 
  - Azure Public IP Address
  - Azure DNS Zone
  - Azure user-assigned managed identity
  - Azure RBAC
  - Azure App Gateway
  - AKS
- Kubernetes
  - AGIC - ingress
  - cert-manager & cluster issuer
- SSL
  - LetsEncrypt
- Automation
  - Az CLI
  - HELM Charts for Kubernetes deployment
  - Bicep as IAC
  - PowerShell for scripting

# Credits
- [https://github.com/paolosalvatori/aks-multi-tenant-agic](https://github.com/paolosalvatori/aks-multi-tenant-agic)