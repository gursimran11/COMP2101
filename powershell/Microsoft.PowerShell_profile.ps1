$env:path += ";$home/documents/github/comp2101/powershell"
new-item -path alias:np -value notepad

function welcome{
# Lab 2 COMP2101 welcome script for profile
#

write-output "Welcome to planet $env:computername Overlord $env:username"
$now = get-date -format 'HH:MM tt on dddd'
write-output "It is $now."


}

function get-cpuinfo{

$result = Get-CimInstance CIM_Processor | Select-Object Manufacturer, Name, MaxClockSpeed, CurrentClockSpeed, NumberOfCores | Format-List
return $result
}


function get-mydisks{
$result = Get-CimInstance CIM_DiskDrive | Select-Object Manufacturer, Model, SerialNumber, FirmwareRevision, Size  | Format-Table -AutoSize
return $result
}

