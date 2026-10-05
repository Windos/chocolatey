$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-VsCodeExtension -ExtensionId "$toolsDir\PKief.material-icon-theme-5.39.0.vsix"
