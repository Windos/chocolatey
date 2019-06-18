$packageName = 'cinebench'
$url = 'http://http.maxon.net/pub/cinebench/CinebenchR20.zip'
$md5Hash = 'F6FA0F554CEBC22F10D91F1D148710DE'

$installDir = $env:chocolateyPackageFolder

Install-ChocolateyZipPackage -PackageName "$packageName" -Url "$url" -UnzipLocation "$installDir" -checksum $md5Hash
Install-ChocolateyDesktopLink -TargetFilePath "$installDir\CinebenchR20\Cinebench.exe"
