# Lots of learnings for this script come care of Maurice Kevenaar
# https://github.com/mkevenaar

import-module au

function global:au_BeforeUpdate($Package) {}

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(zhuangtongfa.Material-theme@)[^']*" = "`${1}$($Latest.RemoteVersion)"
        }
    }
}

function global:au_GetLatest {
    $Releases = "https://marketplace.visualstudio.com/items?itemName=zhuangtongfa.Material-theme"
    $PageSource = Invoke-WebRequest -UseBasicParsing $Releases

    if ($PageSource.Content -match 'assetUri":"([^"]+)') {
        $AssetUri = $Matches[1]
    } else {
        throw "Unable to grab asset uri file"
    }

    $VSCodeManifest = Invoke-RestMethod -UseBasicParsing "$assetUri/Microsoft.VisualStudio.Code.Manifest"

    @{
        Version       = $VSCodeManifest.version
        RemoteVersion = $VSCodeManifest.version
    }
}

update -ChecksumFor none
