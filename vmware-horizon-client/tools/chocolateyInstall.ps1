$packageName = 'vmware-horizon-client'
$installerType = 'EXE'
$url = 'https://download3.vmware.com/software/view/viewclients/CART15Q1/VMware-Horizon-View-Client-x86-3.3.0-2507564.exe'
$url64 = 'https://download3.vmware.com/software/view/viewclients/CART15Q1/VMware-Horizon-View-Client-x86_64-3.3.0-2507564.exe'
$silentArgs = '/S /V"/qn REBOOT=Reallysuppress"'
$validExitCodes = @(0, 3010)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"  -validExitCodes $validExitCodes