$ErrorActionPreference = 'Stop'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$referer     = 'https://www.maxon.net/en/downloads/cinebench-downloads'
$desktopPath = [System.Environment]::GetFolderPath('Desktop')

$url64         = 'https://mx-app-blob-prod.maxon.net/mx-package-production/website/windows/maxon/cinebench/Cinebench2026_win_x86_64.zip'
$checksum64    = 'a781ab88cbb7fa65855b4a997ab22f432e4db0fbdf9240114cf5486d8d4efb2d'
$urlArm64      = 'https://mx-app-blob-prod.maxon.net/mx-package-production/website/windows/maxon/cinebench/Cinebench2026_win_arm64.zip'
$checksumArm64 = 'cb6c765f80d53e1fe702de145b6da1c67af5b37d5a399c8f3396a7ecfed78159'

# Ask WMI for the processor's architecture (12 = ARM64), as the environment
# variables report AMD64 to processes running under x64 emulation.
$isArm64 = (Get-CimInstance -ClassName Win32_Processor | Select-Object -First 1).Architecture -eq 12

$options = @{
  Headers = @{
    Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7'
    'Accept-Language' = 'en-US,en-CA;q=0.9,en;q=0.8'
    Referer = $referer
  }
}

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  url64bit       = if ($isArm64) { $urlArm64 } else { $url64 }
  checksum64     = if ($isArm64) { $checksumArm64 } else { $checksum64 }
  checksumType64 = 'sha256'
  unzipLocation  = $toolsDir
  options        = $options
}

Install-ChocolateyZipPackage @packageArgs

# Chocolatey shims every .exe in the package. Only Cinebench itself should get
# one, marked as a GUI app so the shim doesn't wait for it to exit.
Get-ChildItem -Path $toolsDir -Filter '*.exe' -Recurse | ForEach-Object {
  $marker = if ($_.Name -eq 'Cinebench.exe') { 'gui' } else { 'ignore' }
  New-Item -Path "$($_.FullName).$marker" -ItemType File -Force | Out-Null
}

# Earlier versions of this package created a 'Cinebench 2024' shortcut.
Remove-Item -Path (Join-Path $desktopPath 'Cinebench 2024.lnk') -Force -ErrorAction SilentlyContinue

# The zip may extract into a versioned folder, so find the executable within it.
$exeFile = Get-ChildItem -Path $toolsDir -Filter 'Cinebench.exe' -Recurse | Select-Object -First 1
Install-ChocolateyShortcut -ShortcutFilePath (Join-Path $desktopPath 'Cinebench.lnk') -TargetPath $exeFile.FullName
