$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition
$exePath  = Join-Path $toolsDir 'FileSeek\fileseek.exe'

$url        = 'https://binaryfortressdownloads.com/Download/BFSFiles/103/FileSeek-7.0-x64.zip' # download url, HTTPS preferred

Install-ChocolateyZipPackage `
    -PackageName    $packageName `
    -Url            $url `
    -UnzipLocation  $toolsDir `
    -Checksum       '5CF723D1DF7FF6E93F287C5685681B4F1003DF6F35A48451CDB5C18773E05C93' `
    -ChecksumType   'sha256'

if (-not (Test-Path $exePath)) {
    throw "fileseek.exe not found in folder $exePath"
}

# Prüfen, ob mit Adminrechten ausgeführt wird
$isAdmin = ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

# Basisverzeichnis des Startmenüs je nach Benutzerkontext
$startMenuBase = if ($isAdmin) {
    [Environment]::GetFolderPath('CommonStartMenu')
} else {
    [Environment]::GetFolderPath('StartMenu')
}

# Zielordner "Binary Fortress Software" im Startmenü anlegen
$targetFolder = Join-Path $startMenuBase 'Programs\Binary Fortress Software'
$null = New-Item -ItemType Directory -Force -Path $targetFolder

# Pfad zur .lnk-Verknüpfung
$shortcutPath = Join-Path $targetFolder 'FileSeek.lnk'

# Optional: Arbeitsverzeichnis und Icon
$workingDir = Split-Path $exePath -Parent
$iconPath   = $exePath

# Verknüpfung erstellen – bevorzugt mit Chocolatey Helper
Install-ChocolateyShortcut `
    -ShortcutFilePath $shortcutPath `
    -TargetPath $exePath `
    -WorkingDirectory $workingDir `
    -IconLocation $iconPath `
    -Description 'FileSeek'

Write-Host ("Shutcut created: {0} ({1})" -f $shortcutPath, $(if ($isAdmin) { "All Users" } else { "Current Users" }))    