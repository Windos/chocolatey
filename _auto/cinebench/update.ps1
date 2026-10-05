import-module Chocolatey-AU

$Referer   = 'https://www.maxon.net/en/downloads/cinebench-downloads'
$StateFile = "$PSScriptRoot\upstream.txt"

# Maxon replaces the zips in place, behind URLs that only carry the year. So
# compare each zip's URL and Content-MD5 with those recorded at the last update,
# and only download them when something has changed.
function global:au_GetLatest {
    $ProgressPreference = 'SilentlyContinue'
    $Headers = @{ Referer = $Referer }

    $Page = Invoke-WebRequest -UseBasicParsing -Uri $Referer
    $Urls = [ordered]@{
        x64   = [regex]::Match($Page.Content, 'https://[^"''\s<>]+_win_x86_64\.zip').Value
        arm64 = [regex]::Match($Page.Content, 'https://[^"''\s<>]+_win_arm64\.zip').Value
    }
    if (-not $Urls.x64 -or -not $Urls.arm64) {
        throw "Unable to find the Cinebench Windows downloads on $Referer"
    }

    $State = foreach ($Arch in $Urls.Keys) {
        $Head = Invoke-WebRequest -UseBasicParsing -Method Head -Uri $Urls[$Arch] -Headers $Headers
        "$Arch=$($Urls[$Arch])|$($Head.Headers['Content-MD5'] | Select-Object -First 1)"
    }
    $State = $State -join "`n"

    $NuspecVersion = ([xml](Get-Content "$PSScriptRoot\cinebench.nuspec")).package.metadata.version
    # Line endings depend on how git checked the file out, so ignore them.
    $StoredState = if (Test-Path $StateFile) { (Get-Content $StateFile -Raw).Trim() -replace "`r", '' }
    if ($State -eq $StoredState) {
        return @{ Version = $NuspecVersion }
    }

    $Checksums = @{}
    foreach ($Arch in $Urls.Keys) {
        $ZipPath = Join-Path $env:TEMP "cinebench-$Arch.zip"
        Invoke-WebRequest -UseBasicParsing -Uri $Urls[$Arch] -Headers $Headers -OutFile $ZipPath
        $Checksums[$Arch] = (Get-FileHash -Path $ZipPath -Algorithm SHA256).Hash.ToLower()

        if ($Arch -eq 'x64') {
            Add-Type -AssemblyName System.IO.Compression.FileSystem
            $Zip = [IO.Compression.ZipFile]::OpenRead($ZipPath)
            $ExeEntry = $Zip.Entries | Where-Object { $_.Name -eq 'Cinebench.exe' } | Sort-Object { $_.FullName.Length } | Select-Object -First 1
            $ExePath = Join-Path $env:TEMP 'Cinebench.exe'
            [IO.Compression.ZipFileExtensions]::ExtractToFile($ExeEntry, $ExePath, $true)
            $Zip.Dispose()
            $VersionInfo = (Get-Item $ExePath).VersionInfo
            $Version = '{0}.{1}.{2}' -f $VersionInfo.FileMajorPart, $VersionInfo.FileMinorPart, $VersionInfo.FileBuildPart
            Remove-Item $ExePath
        }
        Remove-Item $ZipPath
    }

    # The files changed but the version didn't, so publish a fix version
    # rather than leave the published checksums broken.
    $NuspecBase = ($NuspecVersion -split '\.')[0..2] -join '.'
    if ($Version -eq $NuspecBase) {
        $Version = "$Version.$(Get-Date -Format yyyyMMdd)"
    }

    Write-Output "newversion=$($Version)" >> $Env:GITHUB_OUTPUT

    @{
        Version       = $Version
        URL64         = $Urls.x64
        Checksum64    = $Checksums.x64
        URLArm64      = $Urls.arm64
        ChecksumArm64 = $Checksums.arm64
        State         = $State
    }
}

function global:au_BeforeUpdate($Package) {
    Set-Content -Path $StateFile -Value $Latest.State
}

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*\`$url64\s*=\s*)('.*')"         = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*\`$checksum64\s*=\s*)('.*')"    = "`$1'$($Latest.Checksum64)'"
            "(?i)(^\s*\`$urlArm64\s*=\s*)('.*')"      = "`$1'$($Latest.URLArm64)'"
            "(?i)(^\s*\`$checksumArm64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumArm64)'"
        }
    }
}

# Maxon's download URLs reject requests without a Referer, which AU's URL check doesn't send.
update -ChecksumFor none -NoCheckUrl
