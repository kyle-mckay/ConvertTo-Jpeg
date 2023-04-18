Clear-Host
$sScriptPath = split-path -parent $MyInvocation.MyCommand.Definition # Gets the path of the script file being executed
Set-Location $sScriptPath
# CSV directory of your photo library's to scan
$dir = "DIR1,DIR2"

# CSV array of extensions
$exten = ".heic,.png"
$exten = $exten.ToUpper() # redundancy
$exten = $exten.Split(",") # convert to array

$dir.Split(",") |ForEach-Object {
    #split directories CSV
    $cont = Get-ChildItem $_ -Recurse #contents of directory

    Foreach ($s in $cont) {
        # for each child item in directory
        If ( $exten.Contains( $s.Extension.ToUpper() ) ) {
            # only convert if extension is in the approved list
            $tar = $s.FullName -replace($s.Extension,".jpg")
            $tar2 = $s.FullName -replace($s.Extension,".jpeg")
            If ( (Test-Path -Path $tar) -or (Test-Path -Path $tar2) ) {
                # if file already exists then skip
                Write-Host "$tar already exists"
            } else {
                #convert to jpeg
                .\ConvertTo-Jpeg $s.FullName
            }
        }
            
    }
}
