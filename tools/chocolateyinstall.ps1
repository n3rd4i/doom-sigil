$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$pkgName = "Doom Sigil"
$installLocation = "$ENV:LocalAppData\Programs\$pkgName"
$lnkDesktop = "$ENV:UserProfile\Desktop\$pkgName.lnk"
$lnkDesktopBD = "$ENV:UserProfile\Desktop\$pkgName BD.lnk"
$startMenuLocation = "$ENV:AppData\Microsoft\Windows\Start Menu\Programs\$pkgName"

$lnkStartMenu = "$startMenuLocation\$pkgName.lnk"
$startMenuMultiplayerLocation = "$startMenuLocation\Multiplayer"
$lnkStartServer = "$startMenuMultiplayerLocation\$pkgName BD startServer [LAN].lnk"
$lnkJoinServer = "$startMenuMultiplayerLocation\$pkgName BD joinServer [LAN].lnk"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = "$installLocation" # Install-ChocolateyZipPackage
  url           = 'https://www.romerogames.ie/s/SIGIL_V1_1.zip'
  softwareName  = 'doom-sigil*' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique
  checksum      = '9DCECE46E1DE87D90BCD2068408F7F74' # %chocolateyinstall%\tools\checksum.exe
  checksumType  = 'md5'
}
Install-ChocolateyZipPackage @packageArgs

$zandronum = "$ENV:LocalAppData\Programs\Zandronum\zandronum.exe"
$WAD = "`"$installLocation\SIGIL.wad`""
$iWAD = "`"$ENV:LocalAppData\Programs\Ultimate DOOM\DOOM_SE\DOOM.WAD`""
$BDpk3 = "$ENV:LocalAppData\Programs\BrutalDoom\brutalv21.pk3"

Install-ChocolateyShortcut -ShortcutFilePath "$lnkDesktop" `
  -TargetPath $zandronum `
  -IconLocation $zandronum `
  -Arguments "-file $WAD -iwad $iWAD" `
  -WorkingDirectory "$installLocation"
Install-ChocolateyShortcut -ShortcutFilePath "$lnkDesktopBD" `
  -TargetPath $zandronum `
  -IconLocation "$ENV:ChocolateyInstall\lib\brutaldoom\tools\assets\brutal_doom.ico" `
  -Arguments "$BDpk3 -file $WAD -iwad $iWAD" `
  -WorkingDirectory "$installLocation"

## Multiplayer [Start Menu] ##
Install-ChocolateyShortcut -ShortcutFilePath "$lnkStartServer" `
  -TargetPath $zandronum `
  -Arguments "-file $BDpk3 -file $WAD -iwad $iWAD -port 10666 -host +alwaysapplydmflags 1" `
  -WorkingDirectory "$installLocation"
Install-ChocolateyShortcut -ShortcutFilePath "$lnkJoinServer" `
  -TargetPath $zandronum `
  -Arguments "-file $BDpk3 -file $WAD -iwad $iWAD -connect 127.0.0.1:10666" `
  -WorkingDirectory "$installLocation"
