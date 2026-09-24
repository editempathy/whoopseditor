@echo off
title whoopseditor DaVinci Resolve Installer
echo ==========================================================
echo           whoopseditor - DaVinci Resolve Tools           
echo         Instagram: @whoopseditor ^| @i.vkpraveenkumar       
echo ==========================================================
set RESOLVE_EDIT=%APPDATA%\Blackmagic Design\DaVinci Resolve\Support\Fusion\Scripts\Edit
set RESOLVE_UTIL=%APPDATA%\Blackmagic Design\DaVinci Resolve\Support\Fusion\Scripts\Utility

if not exist "%RESOLVE_EDIT%" mkdir "%RESOLVE_EDIT%"
if not exist "%RESOLVE_UTIL%" mkdir "%RESOLVE_UTIL%"

copy /Y "%~dp0Stabilize_Manager.py" "%RESOLVE_EDIT%\Stabilize_Manager.py"
copy /Y "%~dp0Stabilize_Manager.py" "%RESOLVE_UTIL%\Stabilize_Manager.py"
copy /Y "%~dp0Stabilize_Clip.py" "%RESOLVE_EDIT%\Stabilize_Clip.py"
copy /Y "%~dp0Stabilize_Clip.py" "%RESOLVE_UTIL%\Stabilize_Clip.py"

echo [OK] Installation successful!
echo.
echo Open DaVinci Resolve and find your tools under:
echo    Workspace ^> Scripts ^> Edit ^> Stabilize_Manager
echo    Workspace ^> Scripts ^> Edit ^> Stabilize_Clip
echo ==========================================================
pause
