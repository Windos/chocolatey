$ErrorActionPreference = 'Stop';

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = 'vmware-horizon-client'
  unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  fileType      = 'exe'
  url           = 'https://download3.vmware.com/software/view/viewclients/CART16Q4/VMware-Horizon-Client-4.3.0-4710077.exe'

  silentArgs    = '/S /V"/qn REBOOT=Reallysuppress"'
  validExitCodes= @(0, 3010, 1641)

  softwareName  = 'vmware-horizon-client*'
  checksum      = '9ea08d1b73492b8c664046fbce22b289'
  checksumType  = 'md5'
}

Install-ChocolateyPackage @packageArgs
