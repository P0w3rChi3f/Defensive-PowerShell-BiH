###########################################################################
# Test for WinRM Connectivity
###########################################################################

# Start by scanning your targets to see if PowerShell Remoting is enabled.

9..25 | ForEach-Object {test-connection -count 1 192.168.1.$_}

#show ICMP example
code .\DemoScripts\ICMP-Test.ps1       

# Test WinRM Connectivity
 9..25 | ForEach-Object {Test-WSMan -ComputerName "192.168.1.$_" -Credential $creds -Authentication Default -ErrorAction Ignore}

# Test WinRM Connectivity and keep the results
$creds = Get-Credential vagrant
$hostlist = 9..25 | ForEach-Object {"192.168.1.$_"} 
$connectionResults = @()

ForEach ($item in $hostlist) {
        try {
            if ((Test-WSMan -ComputerName $item -Credential $creds -Authentication Default -ErrorAction Ignore).HasAttributes -eq "True")
            {
                $connectionResults += $item
                Write-host "$item - Connection" 
            }
            else {Write-host "$item - No connection"}
        
        }
        catch {
            <#Do this if a terminating exception happens#>
        }
}

###########################################################################
# ComputerName Parameter
###########################################################################
code .\DemoScripts\Restart-Server.ps1

Get-WinEvent -ComputerName 192.168.1.21 -LogName Security -Credential $creds | Where-Object {$_.id -eq 4688}

###########################################################################
# Enter-PSSession
###########################################################################
enter-pssession 192.168.1.21 -Authentication Default
enter-pssession 192.168.1.21 -Credential $Creds -Authentication Default
Enter-PSSession $connectionResults[0] -Credential $Creds -Authentication Default

###########################################################################
# Sessions
###########################################################################
New-PSSession -ComputerName 192.168.1.21 -Credential $Creds -Authentication Default
$connectionResults | New-PSSession -Credential $Creds -Authentication Default
Get-PSSession | ForEach-Object {Disconnect-PSSession -Id $_.id}
Get-PSSession | ForEach-Object {Connect-PSSession -ComputerName $_.ComputerName -Credential $Creds -Authentication Default}
Get-PSSession | forEach-Object {Remove-PSSession -Id $_.id}

$session = New-PSSession 192.168.1.21 -Credential $Creds -Authentication Default
$sessions = $connectionResults | New-PSSession -Credential $Creds -Authentication Default

###########################################################################
# Invoke-Command
###########################################################################
Invoke-Command -computerName 192.168.1.21 -Credential $Creds -Authentication Default -ScriptBlock {Get-Process}
Invoke-Command -Session $sessions -ScriptBlock {Get-Process} | Select-Object ProcessName, PSComputerName
Invoke-Command -Session $sessions -ScriptBlock {Get-Process} | Select-Object ProcessName, PSComputerName | group ProcessName | Sort-Object count

Invoke-Command -Session $sessions -ScriptBlock {Get-Process -name LockApp -IncludeUserName} -ErrorAction SilentlyContinue | Select-Object ProcessName, PSComputerName, UserName, Commandline
Invoke-Command -Session $sessions -ScriptBlock {Get-Process -name LockApp -IncludeUserName | Select-Object ProcessName, PSComputerName, UserName, Commandline} -ErrorAction SilentlyContinue 

Invoke-Command -Session $sessions -command { Get-EventLog Security | Where-Object {$_.eventID -eq 4688}}


###########################################################################
# Implicit Remoting
###########################################################################

$ADsession = New-PSSession -ComputerName 192.168.1.10 -Credential $creds -Authentication Default
Invoke-Command -Session $ADsession -Command {Import-Module ActiveDirectory} 
Import-PSSession -Session $ADsession -Module ActiveDirectory -Prefix PWC
