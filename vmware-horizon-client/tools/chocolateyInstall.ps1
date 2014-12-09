$packageName = 'vmware-horizon-client'
$installerType = 'EXE'
$url = 'https://download3.vmware.com/software/view/viewclients/CART14Q4/VMware-Horizon-View-Client-x86-3.2.0-2331566.exe'
$url64 = 'https://download3.vmware.com/software/view/viewclients/CART14Q4/VMware-Horizon-View-Client-x86_64-3.2.0-2331566.exe'
$silentArgs = '/S /V"/qn REBOOT=Reallysuppress"'
$validExitCodes = @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"  -validExitCodes $validExitCodes