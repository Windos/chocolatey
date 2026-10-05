$ErrorActionPreference = 'Stop'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$moduleVersion = '1.1.0'
$moduleRoot    = Join-Path $env:ProgramFiles 'WindowsPowerShell\Modules\BurntToast'

# Earlier versions of this package installed BurntToast for all users with
# Install-Module. Remove any existing all-users copy so only this version remains.
if (Test-Path $moduleRoot) {
    try {
        Remove-Item -Path $moduleRoot -Recurse -Force
    } catch {
        throw "Unable to remove the existing BurntToast module from '$moduleRoot'. Close any PowerShell sessions using BurntToast and try again. $_"
    }
}

Get-ChocolateyUnzip -FileFullPath "$toolsDir\BurntToast.zip" -Destination "$moduleRoot\$moduleVersion"
