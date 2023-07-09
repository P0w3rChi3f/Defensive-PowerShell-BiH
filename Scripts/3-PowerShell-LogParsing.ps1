###########################################################################
# Setup
###########################################################################

# Event ID cheetsheet
https://www.ultimatewindowssecurity.com/securitylog/encyclopedia

Get-EventLog -LogName * | Select-Object Log | Measure-Object
Get-WinEvent -ListLog * | Select-Object logname | Measure-Object

###########################################################################
# Basic Log Parsing
###########################################################################
foreach ($log in ((get-childitem .\files\evtx\SingleLogs).Name)){Get-WinEvent -path .\files\evtx\SingleLogs\$log}
get-winevent -path .\files\evtx\Merge.evtx

get-winevent -path .\evtx\Merge.evtx

# Explore Get-WinEvent basics and store as a variable
$importLogs = foreach ($log in (get-childitem .\files\evtx\SingleLogs)){Get-WinEvent -path $log.FullName} #v5

$importLogs | Select-Object -First 1 
$importLogs | Select-Object -First 1 | Select-Object -ExpandProperty message | select-string -pattern "Logon ID:"

$importLogs | Where-Object {$_.id -eq 4624} | Group-Object Id
($importLogs | Where-Object {$_.id -eq 4624} | Select-Object -ExpandProperty message).split("`n") | select-string -pattern "Logon type:" 

$importLogs | Where-Object {$_.id -eq "4672"} | Select-Object TaskDisplayName
$importLogs | Where-Object {$_.TaskDisplayName -eq "Special Logon"} | select-object -ExpandProperty Message
($importLogs | Where-Object {$_.TaskDisplayName -eq "Special Logon"} | select-object -ExpandProperty Message).split("`n") | select-string "Account Name"
($importLogs | Where-Object {$_.TaskDisplayName -eq "Special Logon"} | select-object -ExpandProperty Message).split("`n") | select-string "Account Name" -Context(0,3)

#Find everything a user did while logged in.
$importLogs | Where-Object {$_.message -like "*0x567515*"}
    # What IP did samir login from?
    # What was the name of their workstation?
    ($importLogs | Where-Object {$_.message -like "*0x567515*" -and $_.id -eq 4624}| Select-Object -ExpandProperty Message).split("`n") | Select-String -Pattern "Network Information:" -Context (0,3)
    
$importLogs | Where-Object {$_.id -eq "4688"}
($importLogs | Where-Object {$_.id -eq "4688"} | Select-Object -ExpandProperty message).split("`n") | Select-String -patter "New Process ID:" -Context (0,1)

###########################################################################
# Log Parsing : Filter Hash Table
# https://learn.microsoft.com/en-us/powershell/scripting/samples/creating-get-winevent-queries-with-filterhashtable?view=powershell-7.3
###########################################################################

Get-WinEvent -FilterHashTable @{path='.\files\evtx\Merge.evtx'; ID=4648} | Select-Object -ExpandProperty Message

Get-WinEvent -FilterHashTable @{logname="Security"; ID=4648} | Select-Object -ExpandProperty Message

$connectionResults | ForEach-Object {Get-WinEvent -computerName $_ -Credential $creds -FilterHashTable @{logname="Security"; ID=4648} | Select-Object -ExpandProperty Message}

Invoke-Command -Session $sessions -Command {Get-WinEvent -FilterHashTable @{logname="Security"; ID=4648} | Select-Object -ExpandProperty Message}