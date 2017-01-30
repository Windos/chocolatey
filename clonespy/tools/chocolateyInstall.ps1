$ErrorActionPreference = 'Stop';

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = 'clonespy'
  fileType      = 'exe'
  url           = 'http://www.clonespy.com/english/download/cspy333.exe'

  silentArgs    = '/S /NODESKTOPSHORTCUT /X64'
  validExitCodes= @(0)

  softwareName  = 'clonespy*'
  checksum      = 'BC452F8C0FE01C289C98BB4633B87C4E'
  checksumType  = 'md5'
}

Install-ChocolateyPackage @packageArgs