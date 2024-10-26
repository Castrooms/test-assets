#Requires -Version 7
$ErrorActionPreference = "Stop"

# pexels.com seems like a good source of videos, but they need converting to mjpeg so they can be used in chrome.

Push-Location "$PSScriptRoot"
try {
    foreach ($f in Get-ChildItem -Path ./trimmed/*) {
        $oldName = $f.Name
        $newName = "$($f.BaseName).mjpeg"

        If (Test-Path "videos/$newName") {
            Write-Output "Skipping because $newName exists"
        }
        else {
            Write-Output "Converting $oldName to $newName"

            docker run --rm -v .:/app jrottenberg/ffmpeg `
                -i /app/trimmed/$oldName `
                /app/videos/$newName
        }
    }
}
finally {
    Pop-Location
}
