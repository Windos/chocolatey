$packageName = 'cinebench'
$url = 'http://http.maxon.net/pub/cinebench/CinebenchR23.zip'
$md5Hash = 'ab936936b97c7b54a05fda185f846bf8'

$installDir = $env:chocolateyPackageFolder

Install-ChocolateyZipPackage -PackageName "$packageName" -Url "$url" -UnzipLocation "$installDir" -checksum $md5Hash
Install-ChocolateyDesktopLink -TargetFilePath "$installDir\Cinebench.exe"
