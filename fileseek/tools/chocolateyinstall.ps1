$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = Split-Path -parent $MyInvocation.MyCommand.Definition
$url        = 'https://binaryfortressdownloads.com/Download/BFSFiles/103/FileSeek-7.0-x64.zip' # download url, HTTPS preferred

Install-ChocolateyZipPackage `
    -PackageName    $packageName `
    -Url            $url `
    -UnzipLocation  $toolsDir `
    -Checksum       '5CF723D1DF7FF6E93F287C5685681B4F1003DF6F35A48451CDB5C18773E05C93' `
    -ChecksumType   'sha256'