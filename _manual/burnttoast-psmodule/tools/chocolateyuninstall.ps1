$ErrorActionPreference = 'Stop'
$moduleVersion = '1.1.0'
$moduleRoot    = Join-Path $env:ProgramFiles 'WindowsPowerShell\Modules\BurntToast'

Remove-Item -Path "$moduleRoot\$moduleVersion" -Recurse -Force -ErrorAction SilentlyContinue

if ((Test-Path $moduleRoot) -and -not (Get-ChildItem -Path $moduleRoot)) {
    Remove-Item -Path $moduleRoot -Force
}
