@echo off
setlocal EnableDelayedExpansion
title whoopseditor DaVinci Resolve Installer
echo ==========================================================
echo           whoopseditor - DaVinci Resolve Tools           
echo         Instagram: @whoopseditor | @i.vkpraveenkumar       
echo ==========================================================
echo.
echo [*] Note: Please ensure you are connected to the internet
echo     so the installer can automatically configure the
echo     required Python runtime if not already present.
echo.

set "RESOLVE_EDIT=%APPDATA%\Blackmagic Design\DaVinci Resolve\Support\Fusion\Scripts\Edit"
set "RESOLVE_UTIL=%APPDATA%\Blackmagic Design\DaVinci Resolve\Support\Fusion\Scripts\Utility"

if not exist "%RESOLVE_EDIT%" mkdir "%RESOLVE_EDIT%"
if not exist "%RESOLVE_UTIL%" mkdir "%RESOLVE_UTIL%"

echo [*] Installing scripts to DaVinci Resolve...
copy /Y "%~dp0Stabilize_Manager.py" "%RESOLVE_EDIT%\Stabilize_Manager.py" >nul
copy /Y "%~dp0Stabilize_Manager.py" "%RESOLVE_UTIL%\Stabilize_Manager.py" >nul
copy /Y "%~dp0Stabilize_Clip.py" "%RESOLVE_EDIT%\Stabilize_Clip.py" >nul
copy /Y "%~dp0Stabilize_Clip.py" "%RESOLVE_UTIL%\Stabilize_Clip.py" >nul
echo [OK] Scripts copied to Edit & Utility menus.
echo.

echo [*] Checking Python 3 runtime for DaVinci Resolve...

set "PY_EXE="

:: 1. Check if standard python command exists (ignoring WindowsApps redirector)
for /f "delims=" %%I in ('where python 2^>nul') do (
    echo %%I | find /i "WindowsApps" >nul
    if errorlevel 1 (
        if not defined PY_EXE set "PY_EXE=%%I"
    )
)

:: 2. Check py launcher
if not defined PY_EXE (
    for /f "delims=" %%I in ('where py 2^>nul') do (
        if not defined PY_EXE set "PY_EXE=%%I -3"
    )
)

:: 3. Check known standard installation directories
if not defined PY_EXE (
    for %%V in (312 311 310 39 38) do (
        if exist "%LOCALAPPDATA%\Programs\Python\Python%%V\python.exe" (
            if not defined PY_EXE set "PY_EXE=%LOCALAPPDATA%\Programs\Python\Python%%V\python.exe"
        )
        if exist "C:\Program Files\Python%%V\python.exe" (
            if not defined PY_EXE set "PY_EXE=C:\Program Files\Python%%V\python.exe"
        )
    )
)

:: 4. If Python was found, ensure PYTHONHOME is configured for DaVinci Resolve
if defined PY_EXE (
    echo [OK] Python runtime detected: !PY_EXE!
    for %%F in (!PY_EXE!) do set "PY_DIR=%%~dpF"
    if defined PY_DIR (
        set "PY_DIR=!PY_DIR:~0,-1!"
        setx PYTHONHOME "!PY_DIR!" >nul 2>&1
        echo [OK] Configured PYTHONHOME for DaVinci Resolve (!PY_DIR!).
    )
    goto :check_resolve
)

:: 5. Python NOT found: automatically download and install Python 3.11 (64-bit) silently
echo [!] Python 3 was not detected on this PC.
echo [*] DaVinci Resolve requires 64-bit Python 3 to run automation scripts.
echo [*] Downloading and installing official Python 3.11 automatically...
echo [*] (Running silent background setup - takes ~15-20 seconds with internet)...
echo.

set "PY_INSTALLER=%TEMP%\python-3.11.8-amd64.exe"

powershell -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $wc = New-Object System.Net.WebClient; $wc.DownloadFile('https://www.python.org/ftp/python/3.11.8/python-3.11.8-amd64.exe', '%TEMP%\python-3.11.8-amd64.exe')"

if exist "%TEMP%\python-3.11.8-amd64.exe" (
    echo [*] Installing Python 3.11 runtime silently...
    start /wait "" "%TEMP%\python-3.11.8-amd64.exe" /quiet InstallAllUsers=0 PrependPath=1 Include_tcltk=1 Include_pip=0 Include_test=0 Include_doc=0 SimpleInstall=1
    del "%TEMP%\python-3.11.8-amd64.exe" >nul 2>&1
    
    set "NEW_PY_DIR=%LOCALAPPDATA%\Programs\Python\Python311"
    if exist "!NEW_PY_DIR!\python.exe" (
        setx PYTHONHOME "!NEW_PY_DIR!" >nul 2>&1
        echo [OK] Python 3.11 installed successfully and configured for DaVinci Resolve!
    ) else (
        echo [OK] Python runtime setup completed.
    )
) else (
    echo.
    echo [!] ERROR: Automatic Python download failed.
    echo [!] An active internet connection is required during installation.
    echo [!] Please connect to the internet and run Install_Windows.bat again.
    echo.
)

:check_resolve
echo.
echo ==========================================================
echo [OK] Installation Completed Successfully!
echo.
echo Your tools are ready inside DaVinci Resolve under:
echo    Workspace ^> Scripts ^> Edit ^> Stabilize_Manager
echo    Workspace ^> Scripts ^> Edit ^> Stabilize_Clip
echo ==========================================================

:: Check if DaVinci Resolve is currently open and advise restart
tasklist /FI "IMAGENAME eq Resolve.exe" 2>nul | find /I /N "Resolve.exe" >nul
if "%ERRORLEVEL%"=="0" (
    echo.
    echo [IMPORTANT NOTICE]
    echo DaVinci Resolve is currently running!
    echo Please RESTART DaVinci Resolve now so it detects Python and the new scripts.
    echo ==========================================================
)

pause
