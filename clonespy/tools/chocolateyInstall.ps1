$ErrorActionPreference = 'Stop';

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = 'clonespy'
  fileType      = 'exe'
  url           = 'http://www.clonespy.com/english/download/cspy341.exe'

  silentArgs    = '/S /NODESKTOPSHORTCUT /X64'
  validExitCodes= @(0)

  softwareName  = 'clonespy*'
  checksum      = 'C16250E3DF3D273CD8562CEA316A8851'
  checksumType  = 'md5'
}

Install-ChocolateyPackage @packageArgs