# Download and install VScode

$VScodeurl = "https://az764295.vo.msecnd.net/stable/660393deaaa6d1996740ff4880f1bad43768c814/VSCodeUserSetup-x64-1.80.0.exe"

Invoke-WebRequest -Uri $VScodeurl -OutFile .\Files\VSCodeUserSetup-x64-1.80.0.exe

Start-Process -FilePath .\Files\VSCodeUserSetup-x64-1.80.0.exe


# Download and install latest version of PowerShell
$PWHSURL = "https://objects.githubusercontent.com/github-production-release-asset-2e65be/49609581/cdb2a198-cff3-4ed7-bc59-252e090c40ab?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20230709%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20230709T092947Z&X-Amz-Expires=300&X-Amz-Signature=d5bfbeb3f8286cf19257065947ee17dcf62f01597eb4d12531f15c58e6051a16&X-Amz-SignedHeaders=host&actor_id=21298973&key_id=0&repo_id=49609581&response-content-disposition=attachment%3B%20filename%3DPowerShell-7.3.5-win-x64.msi&response-content-type=application%2Foctet-stream"

Invoke-WebRequest -Uri $PWHSURL -OutFile ".\Files\PowerShell-7.3.5-win-x64.msi"
Start-Process -FilePath ".\Files\PowerShell-7.3.5-win-x64.msi"