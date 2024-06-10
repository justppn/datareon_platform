
[CmdletBinding()]

Param (
    [string] $Name = "DatareonPlatform",
    [bool] $showName = $true,
    [bool] $showDisplayName = $true,
    [bool] $showStartType = $true,
    [bool] $showStatus = $true
)

$svc = (Get-Service $Name -ErrorAction SilentlyContinue)

if ($svc) {

    $svcObj = ($svc | Select-Object *)

    if ($svcObj.StartType -eq "Manual") {
        $startTypeFColor = "DarkBlue"
    }
    elseif ($svcObj.StartType -eq "Automatic") {
        $startTypeFColor = "DarkGreen"
    }

    if ($svcObj.Status -eq "Stopped") {
        $statusBColor = "DarkRed"
    }
    elseif ($svcObj.Status -eq "Running") {
        $statusBColor = "DarkGreen"
    }

    $grayFColor = "DarkGray"

    Write-Host "------------"
    
    if ($showName) {
        Write-Host "Name        : " -NoNewline
        Write-Host $svcObj.Name -ForegroundColor $grayFColor
    }
    
    if ($showDisplayName) {
        Write-Host "DisplayName : " -NoNewline
        Write-Host $svcObj.DisplayName -ForegroundColor $grayFColor
    }
    
    if ($showStartType) {
        Write-Host "StartType   : " -NoNewline
        Write-Host $svcObj.StartType -ForegroundColor $startTypeFColor
    }
    
    if ($showStatus) {
        Write-Host "Status      : " -NoNewline
        Write-Host $svcObj.Status -ForegroundColor $statusBColor
    }
    
    Write-Host "------------"

}
else {
    
    Write-Host ("Service '" + $Name + "' not found") -ForegroundColor "Red"

}
