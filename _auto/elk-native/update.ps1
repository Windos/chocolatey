import-module Chocolatey-AU

function global:au_GetLatest {
    $LatestRelease = Invoke-RestMethod -UseBasicParsing -Uri "https://api.github.com/repos/elk-zone/elk-native/releases/latest"

    @{
        URL64        = $LatestRelease.assets | Where-Object {$_.name.EndsWith("_windows_x86_64.msi")} | Select-Object -ExpandProperty browser_download_url
        Version      = $LatestRelease.tag_name.Replace('elk-native-v', '')
        ReleaseNotes = $LatestRelease.html_url
    }
}

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*(\$)url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
            "(?i)(^\s*checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
        }

        "elk-native.nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`$1$($Latest.ReleaseNotes)`$2"
        }
    }
}

update -ChecksumFor 64
