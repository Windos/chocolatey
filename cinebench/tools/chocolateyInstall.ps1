$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$referer = 'https://www.maxon.net/en/downloads/cinebench-2024-downloads'
$desktopicon = [System.IO.Path]::Combine(([System.Environment]::GetFolderPath("Desktop")), 'Cinebench 2024.lnk')
$exeFile = Join-Path $toolsDir 'Cinebench.exe'

$options = @{
  Headers = @{
    Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7'
    'Accept-Language' = 'en-US,en-CA;q=0.9,en;q=0.8'
    Referer = $referer
  }
}

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  url            = 'https://mx-app-blob-prod.maxon.net/mx-package-production/website/windows/maxon/cinebench/Cinebench2024_win_x86_64.zip'
  checksum       = 'F93B4925EF0445DC4D4BFA4D44157CF036B68E1EB0CAA2EC1E6FD7B1F56A5839'
  checksumType   = 'sha256'
  unzipLocation  = $toolsDir
  options        = $options
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -ShortcutFilePath $desktopicon -TargetPath $exeFile