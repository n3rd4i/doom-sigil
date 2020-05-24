$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. "$toolsDir\commonEnv.ps1"
. "$toolsDir\dependenciesEnv.ps1"

### Doom/BrutalDoom
$shortcut = "$ModName [BD].lnk"
Install-ChocolateyShortcut "$(Join-Path $startMenuDir $shortcut)" `
  -TargetPath "$zandronum" -Arguments "-iwad $iWAD1 -file $WAD -file $BDpk3" `
  -IconLocation "$BDicon"

## StartMenu - MP
$SMMultiplayerDir = "$(Join-Path $startMenuDir Multiplayer)"
$shortcut = "$ModName [MP] startServer [LAN].lnk"
Install-ChocolateyShortcut "$(Join-Path $SMMultiplayerDir $shortcut)" `
  -TargetPath "$zandronum" -Arguments "-iwad $iWAD1 -file $WAD -file $BDpk3 -host -port 10666"

$shortcut = "$ModName [MP] joinServer [LAN].lnk"
Install-ChocolateyShortcut "$(Join-Path $SMMultiplayerDir $shortcut)" `
  -TargetPath "$zandronum" -Arguments "-iwad $iWAD1 -file $WAD -file $BDpk3 -connect 127.0.0.1:10666"
