# Lots of learnings for this script come care of Maurice Kevenaar
# https://github.com/mkevenaar

import-module Chocolatey-AU

# The VSIX is embedded so the install doesn't depend on VS Code reaching the
# Marketplace, which has been timing out in the CCR package verifier.
function global:au_BeforeUpdate($Package) {
    Remove-Item ".\tools\*.vsix" -ErrorAction SilentlyContinue

    $Latest.FileName = "PKief.material-icon-theme-$($Latest.RemoteVersion).vsix"
    $FilePath = ".\tools\$($Latest.FileName)"
    Invoke-WebRequest -UseBasicParsing -Uri $Latest.URL -OutFile $FilePath
    $Latest.Checksum = (Get-FileHash -Path $FilePath -Algorithm SHA256).Hash.ToLower()
}

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(PKief\.material-icon-theme-).*(\.vsix)" = "`${1}$($Latest.RemoteVersion)`${2}"
        }

        ".\legal\VERIFICATION.txt" = @{
            "(?i)(^\s*url:\s*).*"      = "`${1}$($Latest.URL)"
            "(?i)(^\s*checksum:\s*).*" = "`${1}$($Latest.Checksum)"
        }
    }
}

function global:au_GetLatest {
    $Releases = "https://marketplace.visualstudio.com/items?itemName=PKief.material-icon-theme"
    $PageSource = Invoke-WebRequest -UseBasicParsing $Releases

    if ($PageSource.Content -match 'assetUri":"([^"]+)') {
        $AssetUri = $Matches[1]
    } else {
        throw "Unable to grab asset uri file"
    }

    $VSCodeManifest = Invoke-RestMethod -UseBasicParsing "$assetUri/Microsoft.VisualStudio.Code.Manifest"

    Write-Output "newversion=$($VSCodeManifest.version)" >> $Env:GITHUB_OUTPUT

    @{
        Version       = $VSCodeManifest.version
        RemoteVersion = $VSCodeManifest.version
        URL           = "$AssetUri/Microsoft.VisualStudio.Services.VSIXPackage"
    }
}

update -ChecksumFor none
