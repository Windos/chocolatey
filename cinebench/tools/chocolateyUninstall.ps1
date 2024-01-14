$ErrorActionPreference = 'Stop'
$desktopicon = [System.IO.Path]::Combine(([System.Environment]::GetFolderPath("Desktop")), 'Cinebench 2024.lnk')

If (Test-Path -Path $desktopicon) {
  Remove-Item -Path $desktopicon -Force
}