[CmdletBinding()]

Param (
    [bool] $clearCache = $false
)

Write-Host "Stopping ..." -ForegroundColor DarkYellow

Stop-Service DatareonPlatform

if ($clearCache -eq $true) {
    .\clearCache.ps1
}

Write-Host "Starting ..." -ForegroundColor DarkYellow

Start-Service DatareonPlatform

.\status.ps1