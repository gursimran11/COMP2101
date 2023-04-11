# retrives system Network data
function Retrive-IPconfiguration{
$Retrived = WmiObject -Class Win32_NetworkAdapterConfiguration | Where-Object {$_.IPEnabled}
$result = foreach ($RetrivedData in $Retrived ) {
    [PSCustomObject]@{
        "DESCRIPTION" = $RetrivedData.Description
        "INDEX" = $RetrivedData.Index
        "IP ADDRESS" = $RetrivedData.IPAddress
        "SUBNET MASK" = $RetrivedData.IPSubnet
        "DNS DOMAIN NAME" = $RetrivedData.DNSDomain
        "DNS SERVER" = $RetrivedData.DNSServerSearchOrder
        "DEFAULT GATEWAY" = $RetrivedData.DefaultIPGateway
       
    }
}
$result | Format-Table -AutoSize

}

Retrive-IPconfiguration