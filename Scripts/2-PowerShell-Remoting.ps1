###########################################################################
# Test for WinRM Connectivity
###########################################################################

# Start by scanning your targets to see if PowerShell Remoting is enabled.

9..25 | ForEach-Object {test-connection -count 1 172.29.160.$_}
9..25 | ForEach-Object {test-connection -count 1 172.29.150.$_}
9..25 | ForEach-Object {test-connection -count 1 172.29.189.$_}
9..25 | ForEach-Object {test-connection -count 1 172.29.190.$_}

#show ICMP example
code .\DemoScripts\ICMP-Test.ps1       

# Test WinRM Connectivity
$creds = Get-Credential acme\administrator
 9..25 | ForEach-Object {Test-WSMan -ComputerName "172.29.150.$_" -Credential $creds -Authentication Default -ErrorAction Ignore}

# Test WinRM Connectivity and keep the results
$hostlist = 9..25 | ForEach-Object {"172.29.190.$_"} 
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

Get-WinEvent -ComputerName 172.29.150.11 -LogName Security -Credential $creds | Where-Object {$_.id -eq 4674}

###########################################################################
# Enter-PSSession
###########################################################################
enter-pssession 172.29.150.11 -Authentication Default
enter-pssession 172.29.150.11 -Credential $Creds -Authentication Default


###########################################################################
# Sessions
###########################################################################
New-PSSession -ComputerName 172.29.150.11 -Credential $Creds -Authentication Default
$session =  $connectionResults | New-PSSession -Credential $creds -Authentication Default

$connectionResults | New-PSSession -Credential $Creds -Authentication Default
$connectionResults | remove-PSSession
Enter-PSSession $connectionResults[5] -Credential $Creds -Authentication Default
Get-PSSession | ForEach-Object {Disconnect-PSSession -Id $_.id}
Get-PSSession | ForEach-Object {remove-PSSession -ComputerName $_.ComputerName -Credential $Creds -Authentication Default}
Get-PSSession | forEach-Object {Remove-PSSession -Id $_.id}
$sessions = $connectionResults | New-PSSession -Credential $Creds -Authentication Default

###########################################################################
# Invoke-Command
###########################################################################
Invoke-Command -computerName 172.29.150.11 -Credential $Creds -Authentication Default -ScriptBlock {Get-Process}
Invoke-Command -Session $session -ScriptBlock {Get-Process} | Select-Object ProcessName, PSComputerName
Invoke-Command -Session $session -ScriptBlock {Get-Process} | Select-Object ProcessName, PSComputerName | Group-Object ProcessName | Sort-Object count

Invoke-Command -Session $session -ScriptBlock {Get-CimInstance Win32_Process | Where-Object {$_.name -like "*lockapp*"}} -ErrorAction SilentlyContinue | Select-Object ProcessName, PSComputerName, UserName, Commandline
Invoke-Command -Session $sessions -ScriptBlock {Get-Process -name LockApp -IncludeUserName | Select-Object ProcessName, PSComputerName, UserName, Commandline} -ErrorAction SilentlyContinue 

Invoke-Command -Session $session -command { Get-EventLog Security | Where-Object {$_.eventID -eq 4688}}


###########################################################################
# Implicit Remoting
###########################################################################

$ADsession = New-PSSession -ComputerName 192.168.1.10 -Credential $creds -Authentication Default
Invoke-Command -Session $ADsession -Command {Import-Module ActiveDirectory} 
Import-PSSession -Session $ADsession -Module ActiveDirectory -Prefix PWC




Invoke-Command -ComputerName {Get-WinEvent -LogName "Microsoft-Windows-Sysmon/Operational" -Oldest}