@echo off
echo *******************************************************
echo IMPORTANT: Please backup your current Mods folder before proceeding.
echo The installation will overwrite existing files in your Mods directory.
echo *******************************************************
rem pause

git remote set-url origin https://github.com/lshtech/elbes-Modpack
git pull
git submodule update --remote --recursive --merge
xcopy .\Patches\* .\Mods /E /Y

echo Copying Mods folder to %appdata%\Balatro\Mods
xcopy "Mods" "%appdata%\Balatro\Mods" /w /e /h /i

echo Update complete. Please ensure everything is working correctly.
pause
exit