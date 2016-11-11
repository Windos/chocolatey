$ErrorActionPreference = 'Stop';

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = 'clonespy'
  fileType      = 'exe'
  url           = 'http://www.clonespy.com/english/download/cspy331.exe'

  silentArgs    = '/S /NODESKTOPSHORTCUT /X64'
  validExitCodes= @(0)

  softwareName  = 'clonespy*'
  checksum      = '9BF18E073963334270C4E6E567DC70BC'
  checksumType  = 'md5'
}

Install-ChocolateyPackage @packageArgs