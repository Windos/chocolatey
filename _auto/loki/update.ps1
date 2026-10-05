import-module Chocolatey-AU

function global:au_GetLatest {
    $LatestRelease = Invoke-RestMethod -UseBasicParsing -Uri "https://api.github.com/repos/grafana/loki/releases/latest"
    $LatestVersion = $LatestRelease.tag_name.TrimStart('v')

    Write-Output "newversion=$($LatestVersion)" >> $Env:GITHUB_OUTPUT

    @{
        URL64        = $LatestRelease.assets | Where-Object {$_.name -eq 'loki-windows-amd64.exe.zip'} | Select-Object -ExpandProperty browser_download_url
        Version      = $LatestVersion
        ReleaseNotes = $LatestRelease.html_url
    }
}

# The Loki binary is embedded, extracted from the release zip at update time.
function global:au_BeforeUpdate($Package) {
    $ZipPath = Join-Path $env:TEMP 'loki-windows-amd64.exe.zip'
    Invoke-WebRequest -UseBasicParsing -Uri $Latest.URL64 -OutFile $ZipPath
    $Latest.Checksum64 = (Get-FileHash -Path $ZipPath -Algorithm SHA256).Hash.ToLower()

    New-Item -ItemType Directory -Path ".\tools" -Force | Out-Null
    Remove-Item ".\tools\*.exe" -ErrorAction SilentlyContinue
    Expand-Archive -Path $ZipPath -DestinationPath ".\tools" -Force
    Remove-Item $ZipPath
}

function global:au_SearchReplace {
    @{
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(^\s*url:\s*).*"      = "`${1}$($Latest.URL64)"
            "(?i)(^\s*checksum:\s*).*" = "`${1}$($Latest.Checksum64)"
        }

        "loki.nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`$1$($Latest.ReleaseNotes)`$2"
        }
    }
}

update -ChecksumFor none
