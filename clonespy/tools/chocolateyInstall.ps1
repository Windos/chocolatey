$ErrorActionPreference = 'Stop';

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = 'clonespy'
  fileType      = 'exe'
  url           = 'http://www.clonespy.com/english/download/cspy33.exe'

  silentArgs    = '/S /NODESKTOPSHORTCUT /X64'
  validExitCodes= @(0)

  softwareName  = 'clonespy*'
  checksum      = '71A479CF3DDD91C5E00B8B834A87062B'
  checksumType  = 'md5'
}

Install-ChocolateyPackage @packageArgs