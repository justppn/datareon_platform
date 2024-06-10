
$curLoc = (Get-Location).Path

If ($curLoc.Substring(0,2) -eq "\\") {
    $curLoc = "UNC" + $curLoc.Remove(0,1)
}

$literalPath = "\\?\$curLoc\devData\Cache"

Remove-Item -LiteralPath $literalPath -Recurse -Force

Write-Host "Cache is deleted" -ForegroundColor DarkYellow