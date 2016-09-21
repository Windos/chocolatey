$ErrorActionPreference = 'Stop';

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = 'vmware-horizon-client'
  unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  fileType      = 'exe'
  url           = 'https://download3.vmware.com/software/view/viewclients/CART16Q3/VMware-Horizon-Client-x86-4.2.0-4336726.exe'
  url64bit      = 'https://download3.vmware.com/software/view/viewclients/CART16Q3/VMware-Horizon-Client-x86_64-4.2.0-4336726.exe'

  silentArgs    = '/S /V"/qn REBOOT=Reallysuppress"'
  validExitCodes= @(0, 3010, 1641)

  softwareName  = 'vmware-horizon-client*'
  checksum      = '9b61cb97e9877771c540ac6cc43831fa'
  checksumType  = 'md5'
  checksum64    = 'd190274ed5a651671bbb3ae8aa7a88f4'
  checksumType64= 'md5'
}

Install-ChocolateyPackage @packageArgs
