$packageName = 'vmware-horizon-client'
$installerType = 'EXE'
$url = 'https://download3.vmware.com/software/view/viewclients/CART15Q2/VMware-Horizon-View-Client-x86-3.4.0-2769709.exe'
$url64 = 'https://download3.vmware.com/software/view/viewclients/CART15Q2/VMware-Horizon-View-Client-x86_64-3.4.0-2769709.exe'
$silentArgs = '/S /V"/qn REBOOT=Reallysuppress"'
$validExitCodes = @(0, 3010)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"  -validExitCodes $validExitCodes