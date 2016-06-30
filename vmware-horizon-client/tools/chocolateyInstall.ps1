$ErrorActionPreference = 'Stop';

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = 'vmware-horizon-client'
  unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  fileType      = 'exe'
  url           = 'https://download3.vmware.com/software/view/viewclients/CART16Q2/VMware-Horizon-Client-x86-4.1.0-3977225.exe'
  url64bit      = 'https://download3.vmware.com/software/view/viewclients/CART16Q2/VMware-Horizon-Client-x86_64-4.1.0-3977225.exe'

  silentArgs    = '/S /V"/qn REBOOT=Reallysuppress"'
  validExitCodes= @(0, 3010, 1641)

  softwareName  = 'vmware-horizon-client*'
  checksum      = '28839eadfaba594f5cf0cf62f4d8c830'
  checksumType  = 'md5'
  checksum64    = '3ca893d2bce82e0703b9d50c863350b1'
  checksumType64= 'md5'
}

Install-ChocolateyPackage @packageArgs
