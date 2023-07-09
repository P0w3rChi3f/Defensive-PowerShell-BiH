# Defensive PowerShell (BiH)

## Description

This is an 8 hour workshop comprised of two main sections.  The topics come from my PowerShell Crash Course and my original Defensive PowerShell workshops

The first part of the day we spend learing the various PowerShell Remoting techique and applying what we learned to scan and connect to machines in a lab environment.  We will even import the Active Directory module from the Domain Controller into our remote session.  Most of this section was taught in my PowerShell Crash Course workshop.

The last part of the day we will learn various techniques to parse windows logs, both evtx and plain text logs.  We will connect to our lab environment and practice what we learned.  We will use PowerShell remoting to connect to the lab environment, parse some logs and pull back the results.  This portion of the work shop comes from my original Defensive PowerShell workshop.

## PowerShell Remoting  

* [Testing for WinRM](https://github.com/P0w3rChi3f/Defensive-PowerShell-BiH/blob/main/Scripts/2-PowerShell-Remoting.ps1#L2)  
* [Using the ComputerName Parameter](https://github.com/P0w3rChi3f/Defensive-PowerShell-BiH/blob/main/Scripts/2-PowerShell-Remoting.ps1#L36)  
* [One to One Connection using Enter-PSSession](https://github.com/P0w3rChi3f/Defensive-PowerShell-BiH/blob/main/Scripts/2-PowerShell-Remoting.ps1#L43)  
* [Working with sessions and variables](https://github.com/P0w3rChi3f/Defensive-PowerShell-BiH/blob/main/Scripts/2-PowerShell-Remoting.ps1#L50)  
* [One to Many Connection using Invoke](https://github.com/P0w3rChi3f/Defensive-PowerShell-BiH/blob/main/Scripts/2-PowerShell-Remoting.ps1#L62)  
* [Importing tools from another machine using Implicit Remoting](https://github.com/P0w3rChi3f/Defensive-PowerShell-BiH/blob/main/Scripts/2-PowerShell-Remoting.ps1#L75)  
