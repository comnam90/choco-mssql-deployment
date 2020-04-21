
$ErrorActionPreference = 'Stop';


$packageName = 'sql2019-clrtypes'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://download.microsoft.com/download/d/d/1/dd194c5c-d859-49b8-ad64-5cbdcbb9b7bd/SQLSysClrTypes.msi'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'msi'
  url            = $url

  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)

  softwareName   = 'Microsoft System CLR Types for SQL Server 2019*'
}

Write-Host 'Installing.'
Install-ChocolateyPackage @packageArgs

