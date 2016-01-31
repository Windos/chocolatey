$packageName = 'clonespy'
$installerType = 'EXE'
$url = 'http://www.clonespy.com/english/download/cspy323.exe'
$silentArgs = '/S /NODESKTOPSHORTCUT /X64'
$validExitCodes = @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"  -validExitCodes $validExitCodes