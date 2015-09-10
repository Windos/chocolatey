$packageName = 'vmware-horizon-client'
$installerType = 'EXE'
$url = 'https://download3.vmware.com/software/view/viewclients/CART15Q3/VMware-Horizon-View-Client-x86-3.5.0-2999900.exe'
$url64 = 'https://download3.vmware.com/software/view/viewclients/CART15Q3/VMware-Horizon-View-Client-x86_64-3.5.0-2999900.exe'
$silentArgs = '/S /V"/qn REBOOT=Reallysuppress"'
$validExitCodes = @(0, 3010)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"  -validExitCodes $validExitCodes