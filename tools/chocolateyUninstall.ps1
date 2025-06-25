$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
Remove-Item "$toolsDir\bicep-docs.exe" -Force -ErrorAction SilentlyContinue
Uninstall-BinFile -Name "bicep-docs"
Write-Host '✓ bicep-docs uninstalled'
