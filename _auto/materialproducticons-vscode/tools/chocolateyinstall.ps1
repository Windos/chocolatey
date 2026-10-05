$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-VsCodeExtension -ExtensionId "$toolsDir\PKief.material-product-icons-1.7.1.vsix"
