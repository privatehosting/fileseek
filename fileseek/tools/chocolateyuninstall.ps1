$ErrorActionPreference = 'SilentlyContinue'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

function Test-IsAdmin {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($identity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}
$isAdmin = Test-IsAdmin
$uninstalled = $false

$startMenuBase = if ($isAdmin) {
    [Environment]::GetFolderPath('CommonStartMenu')
} else {
    [Environment]::GetFolderPath('StartMenu')
}

$shortcutPath = Join-Path $startMenuBase 'Programs\Binary Fortress Software\FileSeek.lnk'

# Verknüpfung löschen
if (Test-Path $shortcutPath) {
    Remove-Item $shortcutPath -Force
    Write-Host "Shortcut deleted: $shortcutPath"
}

# Optional: Leeren Ordner ebenfalls löschen (wenn keine anderen Shortcuts darin liegen)
$folderPath = Split-Path $shortcutPath
if ((Test-Path $folderPath) -and ((Get-ChildItem $folderPath | Measure-Object).Count -eq 0)) {
    Remove-Item $folderPath -Force
    Write-Host "Empty Folder deleted: $folderPath"
}