[CmdletBinding()]

Param (
    [bool] $clearCache = $false,
    [string] $Name = "DatareonPlatform"
)

if (Get-Service $Name -ErrorAction SilentlyContinue) {

    .\stop.ps1 -Name $Name

    if ($clearCache -eq $true) {
        .\clearCache.ps1
    }

    .\start.ps1 -Name $Name

}
else {

    Write-Host ("Service '" + $Name + "' not found") -ForegroundColor "Red"

}
