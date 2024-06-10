[CmdletBinding()]

Param (
    [string] $Name = "DatareonPlatform"
)

if (Get-Service $Name -ErrorAction SilentlyContinue) {

    Write-Host "Starting ..." -ForegroundColor DarkYellow

    Start-Service $Name

    .\status.ps1 -Name $Name -showName 0 -showDisplayName 0 -showStartType 0

}
else {

    Write-Host ("Service '" + $Name + "' not found") -ForegroundColor "Red"

}
