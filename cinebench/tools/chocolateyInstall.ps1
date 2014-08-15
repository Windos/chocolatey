$packageName = 'cinebench'
$url = 'http://http.maxon.net/pub/benchmarks/CINEBENCH_R15.zip'
$md5Hash = '0a7353398a7f4b61f3b970c74feef726'

try { 
  $binRoot = "$env:systemdrive\tools"
  if($env:chocolatey_bin_root -ne $null -and $env:chocolatey_bin_root -notlike '*:\*'){$binRoot = join-path $env:systemdrive $env:chocolatey_bin_root}
  $installDir = Join-Path $binRoot "$packageName"
  Write-Host "Adding `'$installDir`' to the path and the current shell path"
  Install-ChocolateyPath "$installDir"
  $env:Path = "$($env:Path);$installDir"

  Install-ChocolateyZipPackage "$packageName" "$url" "$installDir" -checksum $md5Hash
  Install-ChocolateyDesktopLink -TargetFilePath "$installDir\CINEBENCH Windows 64 Bit.exe"
  
  Write-ChocolateySuccess "$packageName"
} catch {
  Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
  throw 
}