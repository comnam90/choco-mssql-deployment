
$ErrorActionPreference = 'Stop';


$packageName= 'sql2016-clrtypes'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download.microsoft.com/download/8/7/2/872BCECA-C849-4B40-8EBE-21D48CDF1456/ENU/x86/SQLSysClrTypes.msi'
$url64      = 'https://download.microsoft.com/download/8/7/2/872BCECA-C849-4B40-8EBE-21D48CDF1456/ENU/x64/SQLSysClrTypes.msi'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'msi'
  url           = $url
  url64bit      = $url64

  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)

  softwareName  = 'Microsoft System CLR Types for SQL Server 2016*'
}

# If we are on a x64 system we need to install the x86 package as well.
$IsSystem32Bit = Get-ProcessorBits -Compare 32
if (!$IsSystem32Bit) {
  Write-Host 'Installing 32bit version with 64bit.'
  $packageArgs.url64bit = $params.url
  Install-ChocolateyPackage @packageArgs
  
  $packageArgs.url64bit = $params.url64bit
  Install-ChocolateyPackage @packageArgs
}
else {
  Write-Host 'Installing 32bit version.'
  Install-ChocolateyPackage @packageArgs
}


