@echo off
echo *******************************************************
echo IMPORTANT: Please backup your current Mods folder before proceeding.
echo The installation will overwrite existing files in your Mods directory.
echo *******************************************************
pause

git remote set-url origin https://github.com/lshtech/elbes-Modpack
git pull
git submodule update --remote --recursive --merge

rem echo Copying Mods folder to %appdata%\Balatro\Mods
rem xcopy "Mods" "%appdata%\Balatro\Mods" /w /e /h /i

echo Update complete. Please ensure everything is working correctly.
pause