$ErrorActionPreference = 'Stop';

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = 'vmware-horizon-client'
  unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  fileType      = 'exe'
  url           = 'https://download3.vmware.com/software/view/viewclients/CART16Q1_2/VMware-Horizon-Client-x86-4.0.1-3698521.exe'
  url64bit      = 'https://download3.vmware.com/software/view/viewclients/CART16Q1_2/VMware-Horizon-Client-x86_64-4.0.1-3698521.exe'

  silentArgs    = '/S /V"/qn REBOOT=Reallysuppress"'
  validExitCodes= @(0, 3010, 1641)

  softwareName  = 'vmware-horizon-client*'
  checksum      = 'b8924ae95437865203243f06fd05f82e'
  checksumType  = 'md5'
  checksum64    = '58e1b8ff513aafe2a4ce2d8955d76ace'
  checksumType64= 'md5'
}

Install-ChocolateyPackage @packageArgs
