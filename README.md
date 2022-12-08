# dns-aag-aks-agic
Demos end to end setup of DNS Zone to AAG to AKS with App gateway Ingress Controller

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
  - cert-manager
  - cert-manager
- SSL
  - LetsEncrypt
- Automation
  - Az CLI
  - HELM Charts for Kubernetes deployment
  - Bicep as IAC
  - PowerShell for scripting

# Credits
- [https://github.com/paolosalvatori/aks-multi-tenant-agic](https://github.com/paolosalvatori/aks-multi-tenant-agic)