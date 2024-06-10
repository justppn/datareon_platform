$curpath = (Get-Location).path
$curdate = (Get-Date -Format "yyyyMMddHHmm")
$curbranch = (git branch --show-current)

foreach ( $folder in (Get-ChildItem .\devConfig\ -Directory) ) {
    
    $source = $curpath + "\devConfig\" + $folder.Name
    $destination = $curpath + "\build\"  + $folder.Name + "_" + $curbranch + "_" + $curdate + ".zip"

    & "C:\Program Files\7-Zip\7z.exe" a -tzip -ssw -mx9 -r0 $destination $source

}