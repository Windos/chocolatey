$ErrorActionPreference = 'Stop';

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = 'vmware-horizon-client'
  unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  fileType      = 'exe'
  url           = 'https://download3.vmware.com/software/view/viewclients/CART18FQ3/VMware-Horizon-Client-4.6.1-6748947.exe'

  silentArgs    = '/silent /norestart'
  validExitCodes= @(0, 3010, 1641)

  softwareName  = 'vmware-horizon-client*'
  checksum      = '0e2b2d1a1e2b0838069d81f3b6e66315'
  checksumType  = 'md5'
}

Install-ChocolateyPackage @packageArgs
