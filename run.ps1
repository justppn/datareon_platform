[CmdletBinding()]

Param (
    [string]$configFileName = "developerConfig.json"
    )

$developerConfig = "-developerConfig=" + (Get-Location).path + "\" + $configFileName

& "C:\Program Files (x86)\Datareon\Platform\DatareonPlatformService.exe" developer $developerConfig