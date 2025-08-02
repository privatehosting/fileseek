$repoList = @()

if ($env:WORKING_DIR) {
    $repoList += $env:WORKING_DIR
}

$repoList += "https://nexus.srv.pilichiewicz.local/repository/chocolatey-repo-public/"
$repoList += "https://community.chocolatey.org/api/v2/"

$sourceArg = $repoList -join ";"
Write-Host "Installing fileseek from sources: $sourceArg"

choco install fileseek -y --pre --force -s $sourceArg

Write-Host "Testing the installation" 
Test-Path "C:\Program Files\FileSeek"  # Example validation step, adjust to match the package installation path