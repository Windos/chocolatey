$packageName = 'vmware-horizon-client'
$installerType = 'EXE'
$url = 'https://download3.vmware.com/software/view/viewclients/VMware-Horizon-View-Client-x86-3.1.0-2085634.exe'
$url64 = 'https://download3.vmware.com/software/view/viewclients/VMware-Horizon-View-Client-x86_64-3.1.0-2085634.exe'
$silentArgs = '/S /V"/qn REBOOT=Reallysuppress"'
$validExitCodes = @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"  -validExitCodes $validExitCodes