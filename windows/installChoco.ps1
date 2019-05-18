#Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
#choco feature enable -n allowGlobalConfirmation
#choco upgrade chocolatey
cd "c:/tmp"
echo $pwd
choco install $pwd\apps.config