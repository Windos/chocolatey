$packageName = 'clonespy'
$installerType = 'EXE'
$url = 'http://www.clonespy.com/english/download/cspy313.exe'
$silentArgs = '/S /NODESKTOPSHORTCUT'
$validExitCodes = @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"  -validExitCodes $validExitCodes