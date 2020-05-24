# Zandronum
$zandronumLocation = [IO.Path]::Combine($ENV:LocalAppData, 'Programs', 'Zandronum')
$zandronum = "$(Join-Path $zandronumLocation 'zandronum.exe')"

# FreeDoom
$freeDoomTools = [IO.Path]::Combine($ENV:ChocolateyInstall, 'lib', 'freedoom', 'tools')
$iWAD1 = "freedoom1.wad"
$iWAD2 = "freedoom2.wad"

# BrutalDoom
$brutalDoomLocation = [IO.Path]::Combine($ENV:LocalAppData, 'Programs', 'BrutalDoom')
$brutalDoomTools = [IO.Path]::Combine($ENV:ChocolateyInstall, 'lib', 'brutaldoom', 'tools')
$BDicon = [IO.Path]::Combine($brutalDoomTools, 'assets', 'brutal_doom.ico')
$BDpk3 = "$(Join-Path $brutalDoomLocation 'brutalv21.pk3')"

# Sigil
$sigilLocation = [IO.Path]::Combine($ENV:ChocolateyInstall, 'lib', 'doom1-maps-sigil', 'tools', 'wad')
$WAD = "$(Join-Path $sigilLocation SIGIL_v1_21.wad)"
