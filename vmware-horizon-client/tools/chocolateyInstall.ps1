$ErrorActionPreference = 'Stop';

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = 'vmware-horizon-client'
  unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  fileType      = 'exe'
  url           = 'https://download3.vmware.com/software/view/viewclients/CART18FQ4/VMware-Horizon-Client-4.7.0-7395453.exe'

  silentArgs    = '/silent /norestart'
  validExitCodes= @(0, 3010, 1641)

  softwareName  = 'vmware-horizon-client*'
  checksum      = '19c97592b7a9eda43d9bf43355f95c53'
  checksumType  = 'md5'
}

Install-ChocolateyPackage @packageArgs
