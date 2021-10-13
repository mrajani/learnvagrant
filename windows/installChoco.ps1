Set-WinHomeLocation -GeoId 0x71
Set-Culture en-IN
Set-TimeZone -name "India Standard Time"
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco feature enable -n allowGlobalConfirmation
choco upgrade chocolatey
cd "c:/tmp"
echo $pwd
powershell choco install $pwd\apps.config --no-progress

