$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. "$toolsDir\commonEnv.ps1"
. "$toolsDir\dependenciesEnv.ps1"

$url = 'https://www.romerogames.ie/s/SIGIL_V1_1.zip'
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = "$installLocation"
  url           = $url
  softwareName  = 'doom-sigil*'
  checksum      = '9DCECE46E1DE87D90BCD2068408F7F74' # %chocolateyinstall%\tools\checksum.exe
  checksumType  = 'md5'
}
Install-ChocolateyZipPackage @packageArgs

$WAD = "`"$installLocation\SIGIL.wad`""

## StartMenu
Install-ChocolateyShortcut -ShortcutFilePath "$startMenuDir\$ModName [BrutalDoom].lnk" `
  -TargetPath "$zandronum" -Arguments "$BDpk3 -file $WAD -iwad $iWAD1" `
  -WorkingDirectory "$installLocation"
Install-ChocolateyShortcut -ShortcutFilePath "$startMenuDir\$ModName [FreeDoom].lnk" `
  -TargetPath "$zandronum" -Arguments "-file $WAD -iwad $iWAD1" `
  -WorkingDirectory "$installLocation" `
  -IconLocation "$FDicon"

## StartMenu - Multiplayer
$SMMultiplayerDir = "$startMenuDir\Multiplayer"
Install-ChocolateyShortcut -ShortcutFilePath "$SMMultiplayerDir\$ModName [MP] startServer [LAN].lnk" `
  -TargetPath "$zandronum" -Arguments "$BDpk3 -file $WAD -iwad $iWAD1 -host -port 10666" `
  -WorkingDirectory "$installLocation"
Install-ChocolateyShortcut -ShortcutFilePath "$SMMultiplayerDir\$ModName [MP] joinServer [LAN].lnk" `
  -TargetPath "$zandronum" -Arguments "$BDpk3 -file $WAD -iwad $iWAD1 -connect 127.0.0.1:10666" `
  -WorkingDirectory "$installLocation"

## Desktop
Install-ChocolateyShortcut -ShortcutFilePath "$lnkDesktop" `
  -TargetPath "$zandronum" -Arguments "$BDpk3 -file $WAD -iwad $iWAD1" `
  -WorkingDirectory "$installLocation" `
  -IconLocation "$BDicon"
