$packageName = 'cinebench'
$url = 'https://http.maxon.net/pub/benchmarks/CINEBENCHR15.038.zip'
$md5Hash = 'E254FE22253DFD81EAECCD566CAFDE60'

$installDir = $env:chocolateyPackageFolder

Install-ChocolateyZipPackage -PackageName "$packageName" -Url "$url" -UnzipLocation "$installDir" -checksum $md5Hash
Install-ChocolateyDesktopLink -TargetFilePath "$installDir\CINEBENCH R15.038_RC184115\CINEBENCH Windows 64 Bit.exe"
