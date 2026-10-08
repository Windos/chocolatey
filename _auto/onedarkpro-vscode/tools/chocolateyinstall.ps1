$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-VsCodeExtension -ExtensionId "$toolsDir\zhuangtongfa.Material-theme-3.20.3.vsix"
