# Lots of learnings for this script come care of Maurice Kevenaar
# https://github.com/mkevenaar

import-module Chocolatey-AU

function global:au_BeforeUpdate($Package) {}

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(PKief.material-product-icons@)[^']*" = "`${1}$($Latest.RemoteVersion)"
        }
    }
}

function global:au_GetLatest {
    $Releases = "https://marketplace.visualstudio.com/items?itemName=PKief.material-product-icons"
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
    }
}

update -ChecksumFor none
