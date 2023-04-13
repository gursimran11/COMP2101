function Retrive-SystemHardware{
    $RetrivedData = WmiObject -Class Win32_ComputerSystem
    $data= "{0:N2}" -f ([double]$RetrivedData.TotalPhysicalMemory / 1GB)
    
    $result = [PSCustomObject]@{
        "MANUFACTURER" = $RetrivedData.Manufacturer
        "MODEL" = $RetrivedData.Model
        "TOTAL PHYSICAL-MEMORY" = "$data"
        "DESCRIPTION" =$RetrivedData.Description
        "TYPE" = $RetrivedData.SystemType
    }
    return $result
}


# retrives operating system data
function Retrive-Operating{
    $RetrivedData = WmiObject -Class Win32_OperatingSystem
    $result=[PSCustomObject]@{
        "NAME" = $RetrivedData.Caption
        "VERSION" = $RetrivedData.Version
    }
return $result
}

# retrives system processor data
function Retrive-Processor {
   $RetrivedData = WmiObject -Class Win32_Processor
    $result = [ordered]@{
        "NAME" = $RetrivedData.Name
        "NUMBER of cores" = $RetrivedData.NumberOfCores
        "SPEED" = $RetrivedData.MaxClockSpeed
        "L1 CACHE SIZE" = if ($RetrivedData.L1CacheSize) { ($RetrivedData.L1CacheSize[0] / 1KB).ToString("#.## KB") } else { "N/A" }
        "L2 CACHE SIZE" = if ($RetrivedData.L2CacheSize) { ($RetrivedData.L2CacheSize[0] / 1KB).ToString("#.## KB") } else { "N/A" }
        "L3 CACHE SIZE" = if ($RetrivedData.L3CacheSize) { ($RetrivedData.L3CacheSize[0] / 1KB).ToString("#.## KB") } else { "N/A" }
    }
    return $result.GetEnumerator()   | Format-List 
    
}


# retrives system memory data
function Retrive-RAMmemory {
   $Retrived = WmiObject -Class Win32_PhysicalMemory
    $physicaldata = 0
    $result = foreach ($RetrivedData in $Retrived) {
        [PSCustomObject]@{
            VENDOR = $RetrivedData.Manufacturer
            DESCRIPTION = $RetrivedData.Description
            CAPACITY = "{0:N2} GB" -f ($RetrivedData.Capacity / 1GB)
            SLOT = $RetrivedData.DeviceLocator
            TYPE = $RetrivedData.MemoryType
            SPEED = $RetrivedData.Speed
        }
        $physicaldata += $RetrivedData.Capacity
    }

    $result | Format-Table -AutoSize

    Write-Output "Total $(('{0:N2}' -f ($physicaldata / 1GB))) GB is available in the system"
  

 }

# retrives system disk data
function Retrive-DiskDrive{
  $diskdrives = CIMInstance CIM_diskdrive

  foreach ($disk in $diskdrives) {
      $partitions = $disk|cimassociatedinstance -resultclassname CIM_diskpartition
      foreach ($partition in $partitions) {
            $logicaldisks = $partition | cimassociatedinstance -resultclassname CIM_logicaldisk
            foreach ($logicaldisk in $logicaldisks) {
                $space = [math]::Round(($logicaldisk.FreeSpace / $logicaldisk.Size) * 100, 2)
        $result= [PSCustomObject]@{

          MANUFACTURER=$disk.Manufacturer
          MODEL=$disk.Model     
          SIZE = "{0:N2} GB" -f ($logicaldisk.Size / 1GB)
          "AVAILABLE-SPACE" = "{0:N2} GB" -f ($logicaldisk.FreeSpace / 1GB)
          "FREE-SPACE" = "$space%"
                                                                 }
         $result
           }
      }
  }

}
                                                         
# retrives system controoler data
function Retrive-VideoController{
    $Retrived = WmiObject -Class Win32_VideoController
    $result= foreach ($RetrivedData in $Retrived) {
        [PSCustomObject]@{
            VENDOR = $RetrivedData.VideoProcessor
            DESCRIPTION = $RetrivedData.Description
            RESOLUTION = "{0}x{1}" -f $RetrivedData.CurrentHorizontalResolution, $RetriveData.CurrentVerticalResolution
        }
    }
    $result | Format-List
}

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
        "DHCP SERVER" = $RetrivedData.DHCPServer
    }
}
$result | Format-Table -AutoSize

}

function welcome {
write-output "Welcome to planet $env:computername Overlord $env:username"
$now = get-date -format 'HH:MM tt on dddd'
write-output "It is $now."
}

function get-cpuinfo{
Get-CimInstance CIM_Processor | Select-Object Manufacturer, Name, MaxClockSpeed, CurrentClockSpeed, NumberOfCores | Format-List
}


function get-mydisks{
Get-CimInstance CIM_DiskDrive | Select-Object Manufacturer, Model, SerialNumber, FirmwareRevision, Size  | Format-Table -AutoSize
}
