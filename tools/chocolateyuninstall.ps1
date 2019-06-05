$ErrorActionPreference = 'Stop';
$pkgName = "Doom Sigil"
$installLocation = "$ENV:LocalAppData\Programs\$pkgName"
$lnkDesktop = "$ENV:UserProfile\Desktop\$pkgName.lnk"
$lnkDesktopBD = "$ENV:UserProfile\Desktop\$pkgName BD.lnk"
$startMenuLocation = "$ENV:AppData\Microsoft\Windows\Start Menu\Programs\$pkgName"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'doom-sigil*'
}
$uninstalled = $false
[array]$key = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']
if ($key.Count -eq 1) {
  $key | % {
    $packageArgs['file'] = "$($_.UninstallString)"
    if ($packageArgs['fileType'] -eq 'MSI') {
      $packageArgs['silentArgs'] = "$($_.PSChildName) $($packageArgs['silentArgs'])"
      $packageArgs['file'] = ''
    } else {
    }
    Uninstall-ChocolateyPackage @packageArgs
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | % {Write-Warning "- $($_.DisplayName)"}
}
Remove-Item "$lnkDesktopBD" -force
Remove-Item "$lnkDesktop" -force
Remove-Item "$startMenuLocation" -recurse -force
Remove-Item "$installLocation/*" -exclude "saves" -recurse -force
