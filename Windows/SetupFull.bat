@echo off
echo *******************************************************
echo IMPORTANT: Please backup your current Mods folder before proceeding.
echo The installation will overwrite existing files in your Mods directory.
echo *******************************************************
pause

git clone --recurse-submodules --remote-submodules https://github.com/lshtech/elbes-Modpack
xcopy .\elbes-Modpack\Submodules\Fortlatro\Fortlatro\* .\elbes-Modpack\Mods\Fortlatro\ /E /Y
xcopy .\elbes-Modpack\Patches\* .\elbes-Modpack\Mods /E /Y

rem echo Copying Mods folder to %appdata%\Balatro\Mods
rem xcopy "elbes-Modpack\Mods" "%appdata%\Balatro\Mods" /w /e /h /i

echo Installation complete. Please ensure everything is working correctly.
pause
