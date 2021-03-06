# Lots of learnings for this script come care of Maurice Kevenaar
# https://github.com/mkevenaar

import-module au

function global:au_BeforeUpdate($Package) {}

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(ms-vscode.azure-account@)[^']*" = "`${1}$($Latest.RemoteVersion)"
        }
    }
}

function global:au_GetLatest {
    $Releases = "https://marketplace.visualstudio.com/items?itemName=ms-vscode.azure-account"
    $PageSource = Invoke-WebRequest -UseBasicParsing $Releases

    if ($PageSource.Content -match 'assetUri":"([^"]+)') {
        $AssetUri = $Matches[1]
    } else {
        throw "Unable to grab asset uri file"
    }

    $VSCodeManifest = Invoke-RestMethod -UseBasicParsing "$assetUri/Microsoft.VisualStudio.Code.Manifest"

    Write-Host "::set-output name=newversion::$($VSCodeManifest.version)"

    @{
        Version       = $VSCodeManifest.version
        RemoteVersion = $VSCodeManifest.version
    }
}

update -ChecksumFor none
