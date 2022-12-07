// https://learn.microsoft.com/en-us/azure/dns/dns-get-started-bicep?tabs=CLI
param subdomain string
param dnsZoneName string
param publicIPName string

resource publicIp 'Microsoft.Network/publicIPAddresses@2022-05-01' existing = {
  name:publicIPName
}
resource dnszone 'Microsoft.Network/dnsZones@2018-05-01' = {
  name:dnsZoneName
  location: 'Global'
}
resource record 'Microsoft.Network/dnsZones/A@2018-05-01' ={
  parent:dnszone
  name:subdomain
  properties: {
    TTL: 3600
    ARecords: [
      {
        ipv4Address: publicIp.properties.ipAddress
      }
    ]
  }
}

