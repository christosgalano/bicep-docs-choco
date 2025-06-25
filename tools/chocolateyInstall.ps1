$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version    = $env:ChocolateyPackageVersion
$baseUrl    = "https://github.com/christosgalano/bicep-docs/releases/download/v$version"

# Detect architecture
$arch = Get-ProcessorBits
if ($arch -eq 64) {
    $platform = if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') { 'arm64' } else { 'amd64' }
} elseif ($arch -eq 32) {
    $platform = 'arm'
} else {
    throw "Unsupported architecture: $arch"
}

$zipName = "bicep-docs_windows_$platform.zip"
$downloadUrl = "$baseUrl/$zipName"
$zipPath = Join-Path $toolsDir $zipName

Write-Host "Downloading $downloadUrl"
Invoke-WebRequest -Uri $downloadUrl -OutFile $zipPath
Expand-Archive -Path $zipPath -DestinationPath $toolsDir -Force

# Add the executable to PATH using Chocolatey's helper
Install-BinFile -Name "bicep-docs" -Path (Join-Path $toolsDir 'bicep-docs.exe')

# Clean up the downloaded zip
Remove-Item $zipPath -Force
Write-Host '✓ bicep-docs installed'
