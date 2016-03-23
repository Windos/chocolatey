$ErrorActionPreference = 'Stop';

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = 'vmware-horizon-client'
  unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  fileType      = 'exe'
  url           = 'https://download3.vmware.com/software/view/viewclients/CART16Q1/VMware-Horizon-Client-x86-4.0.0-3677815.exe'
  url64bit      = 'https://download3.vmware.com/software/view/viewclients/CART16Q1/VMware-Horizon-Client-x86_64-4.0.0-3677815.exe'

  silentArgs    = '/S /V"/qn REBOOT=Reallysuppress"'
  validExitCodes= @(0, 3010, 1641)

  softwareName  = 'vmware-horizon-client*'
  checksum      = '630d7c339a4c76918d3f8b736c3cd0cf'
  checksumType  = 'md5'
  checksum64    = 'ba945431043999a3811b62f313973d2d'
  checksumType64= 'md5'
}

Install-ChocolateyPackage @packageArgs
