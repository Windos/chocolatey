$ErrorActionPreference = 'Stop';

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = 'vmware-horizon-client'
  unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  fileType      = msi
  url           = 'https://download3.vmware.com/software/view/viewclients/CART15Q3/VMware-Horizon-View-Client-x86-3.5.2-3150477.exe'
  url64bit      = 'https://download3.vmware.com/software/view/viewclients/CART15Q3/VMware-Horizon-View-Client-x86_64-3.5.2-3150477.exe'

  silentArgs    = '/S /V"/qn REBOOT=Reallysuppress"'
  validExitCodes= @(0, 3010, 1641)

  softwareName  = 'vmware-horizon-client*'
  checksum      = 'b934a3b1f0e0ebddbc87cdd602fb332c'
  checksumType  = 'md5'
  checksum64    = '5b45412098b76d29eeca3459490dc75e'
  checksumType64= 'md5'
}

Install-ChocolateyPackage @packageArgs
