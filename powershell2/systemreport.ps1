param ( 
[switch]$System, 
[switch]$Disks, 
[switch]$Network)

if ($System -eq $false -and $Disks -eq $false -and $Network -eq $false) {

# calling all the function and display result
Write-Output "  "
Write-Output "  "
Write-Output "SYSTEM INFORMATION REPORT" 


Write-Output "RETRIVED HARDWARE DATA"
Retrive-SystemHardware | Format-List

Write-Output "RETRIVED OPRATING SYSTEM DATA"
Retrive-Operating | Format-List

Write-Output "RETRIVED PROCESSOR DATA"
Retrive-Processor 

Write-Output "  "
Write-Output "RETRIVED RAM MEMORY DATA"
Retrive-RAMmemory 


Write-Output "  "
Write-Output "RETRIVED DISK DRIVE DATA"
Retrive-DiskDrive | Format-Table -AutoSize


Write-Output "RETRIVED IP CONFIGURATION DATA"
Retrive-IPconfiguration

Write-Output "RETRIVED VIDEO CONTROLLER DATA"
Retrive-VideoController | Format-List
Write-Output "  "
Write-Output "END OF REPORT"
}

elseif ($System) {   

Write-Output "  "
Write-Output "  "
Write-Output "SYSTEM INFORMATION REPORT" 


Write-Output "RETRIVED HARDWARE DATA"
Retrive-SystemHardware | Format-List

Write-Output "RETRIVED OPRATING SYSTEM DATA"
Retrive-Operating | Format-List

Write-Output "RETRIVED PROCESSOR DATA"
Retrive-Processor 

Write-Output "  "
Write-Output "RETRIVED RAM MEMORY DATA"
Retrive-RAMmemory 

Write-Output "RETRIVED VIDEO CONTROLLER DATA"
Retrive-VideoController | Format-List
Write-Output "  "
Write-Output "END OF REPORT"

}

elseif ($Disks) { 

Write-Output "  "
Write-Output "  "
Write-Output "SYSTEM INFORMATION REPORT"
Write-Output "RETRIVED DISK DRIVE DATA"
Retrive-DiskDrive | Format-Table -AutoSize

Write-Output "  "
Write-Output "END OF REPORT"

}

elseif ($Network) { 
Write-Output "  "
Write-Output "  "
Write-Output "SYSTEM INFORMATION REPORT" 

Write-Output "RETRIVED IP CONFIGURATION DATA"
Retrive-IPconfiguration


Write-Output "  "
Write-Output "END OF REPORT"
}
