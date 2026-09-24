@echo off
title whoopseditor DaVinci Resolve Installer
echo ==========================================================
echo           whoopseditor - DaVinci Resolve Tools           
echo         Instagram: @whoopseditor ^| @i.vkpraveenkumar       
echo ==========================================================
echo.

echo [*] Installing scripts to DaVinci Resolve directories...

:: 1. User AppData (Support variant - standard Resolve location)
if not exist "%APPDATA%\Blackmagic Design\DaVinci Resolve\Support\Fusion\Scripts\Edit" mkdir "%APPDATA%\Blackmagic Design\DaVinci Resolve\Support\Fusion\Scripts\Edit" >nul 2>&1
if not exist "%APPDATA%\Blackmagic Design\DaVinci Resolve\Support\Fusion\Scripts\Utility" mkdir "%APPDATA%\Blackmagic Design\DaVinci Resolve\Support\Fusion\Scripts\Utility" >nul 2>&1
copy /Y "%~dp0Stabilize_Manager.py" "%APPDATA%\Blackmagic Design\DaVinci Resolve\Support\Fusion\Scripts\Edit\Stabilize_Manager.py" >nul 2>&1
copy /Y "%~dp0Stabilize_Manager.py" "%APPDATA%\Blackmagic Design\DaVinci Resolve\Support\Fusion\Scripts\Utility\Stabilize_Manager.py" >nul 2>&1
copy /Y "%~dp0Stabilize_Clip.py" "%APPDATA%\Blackmagic Design\DaVinci Resolve\Support\Fusion\Scripts\Edit\Stabilize_Clip.py" >nul 2>&1
copy /Y "%~dp0Stabilize_Clip.py" "%APPDATA%\Blackmagic Design\DaVinci Resolve\Support\Fusion\Scripts\Utility\Stabilize_Clip.py" >nul 2>&1

:: 2. User AppData (Direct Fusion variant)
if not exist "%APPDATA%\Blackmagic Design\DaVinci Resolve\Fusion\Scripts\Edit" mkdir "%APPDATA%\Blackmagic Design\DaVinci Resolve\Fusion\Scripts\Edit" >nul 2>&1
if not exist "%APPDATA%\Blackmagic Design\DaVinci Resolve\Fusion\Scripts\Utility" mkdir "%APPDATA%\Blackmagic Design\DaVinci Resolve\Fusion\Scripts\Utility" >nul 2>&1
copy /Y "%~dp0Stabilize_Manager.py" "%APPDATA%\Blackmagic Design\DaVinci Resolve\Fusion\Scripts\Edit\Stabilize_Manager.py" >nul 2>&1
copy /Y "%~dp0Stabilize_Manager.py" "%APPDATA%\Blackmagic Design\DaVinci Resolve\Fusion\Scripts\Utility\Stabilize_Manager.py" >nul 2>&1
copy /Y "%~dp0Stabilize_Clip.py" "%APPDATA%\Blackmagic Design\DaVinci Resolve\Fusion\Scripts\Edit\Stabilize_Clip.py" >nul 2>&1
copy /Y "%~dp0Stabilize_Clip.py" "%APPDATA%\Blackmagic Design\DaVinci Resolve\Fusion\Scripts\Utility\Stabilize_Clip.py" >nul 2>&1

:: 3. ProgramData All Users (Direct Fusion variant)
if not exist "%PROGRAMDATA%\Blackmagic Design\DaVinci Resolve\Fusion\Scripts\Edit" mkdir "%PROGRAMDATA%\Blackmagic Design\DaVinci Resolve\Fusion\Scripts\Edit" >nul 2>&1
if not exist "%PROGRAMDATA%\Blackmagic Design\DaVinci Resolve\Fusion\Scripts\Utility" mkdir "%PROGRAMDATA%\Blackmagic Design\DaVinci Resolve\Fusion\Scripts\Utility" >nul 2>&1
copy /Y "%~dp0Stabilize_Manager.py" "%PROGRAMDATA%\Blackmagic Design\DaVinci Resolve\Fusion\Scripts\Edit\Stabilize_Manager.py" >nul 2>&1
copy /Y "%~dp0Stabilize_Manager.py" "%PROGRAMDATA%\Blackmagic Design\DaVinci Resolve\Fusion\Scripts\Utility\Stabilize_Manager.py" >nul 2>&1
copy /Y "%~dp0Stabilize_Clip.py" "%PROGRAMDATA%\Blackmagic Design\DaVinci Resolve\Fusion\Scripts\Edit\Stabilize_Clip.py" >nul 2>&1
copy /Y "%~dp0Stabilize_Clip.py" "%PROGRAMDATA%\Blackmagic Design\DaVinci Resolve\Fusion\Scripts\Utility\Stabilize_Clip.py" >nul 2>&1

:: 4. ProgramData All Users (Support variant)
if not exist "%PROGRAMDATA%\Blackmagic Design\DaVinci Resolve\Support\Fusion\Scripts\Edit" mkdir "%PROGRAMDATA%\Blackmagic Design\DaVinci Resolve\Support\Fusion\Scripts\Edit" >nul 2>&1
if not exist "%PROGRAMDATA%\Blackmagic Design\DaVinci Resolve\Support\Fusion\Scripts\Utility" mkdir "%PROGRAMDATA%\Blackmagic Design\DaVinci Resolve\Support\Fusion\Scripts\Utility" >nul 2>&1
copy /Y "%~dp0Stabilize_Manager.py" "%PROGRAMDATA%\Blackmagic Design\DaVinci Resolve\Support\Fusion\Scripts\Edit\Stabilize_Manager.py" >nul 2>&1
copy /Y "%~dp0Stabilize_Manager.py" "%PROGRAMDATA%\Blackmagic Design\DaVinci Resolve\Support\Fusion\Scripts\Utility\Stabilize_Manager.py" >nul 2>&1
copy /Y "%~dp0Stabilize_Clip.py" "%PROGRAMDATA%\Blackmagic Design\DaVinci Resolve\Support\Fusion\Scripts\Edit\Stabilize_Clip.py" >nul 2>&1
copy /Y "%~dp0Stabilize_Clip.py" "%PROGRAMDATA%\Blackmagic Design\DaVinci Resolve\Support\Fusion\Scripts\Utility\Stabilize_Clip.py" >nul 2>&1

echo [OK] Scripts copied successfully to Edit and Utility menus across all user directories.
echo.

echo [*] Checking Python 3 runtime for DaVinci Resolve...

set "PY_EXE="
set "PY_DIR="

:: 1. Check if standard python command exists (ignoring WindowsApps redirector)
for /f "delims=" %%I in ('where python 2^>nul') do (
    echo %%I | find /i "WindowsApps" >nul
    if errorlevel 1 (
        if not defined PY_EXE (
            set "PY_EXE=%%I"
            set "PY_DIR=%%~dpI"
        )
    )
)

:: 2. Check py launcher if not found
if not defined PY_EXE (
    for /f "delims=" %%I in ('where py 2^>nul') do (
        if not defined PY_EXE (
            set "PY_EXE=%%I"
            set "PY_DIR=%%~dpI"
        )
    )
)

:: 3. Check known standard installation directories
if not defined PY_EXE (
    for %%V in (312 311 310 39 38) do (
        if exist "%LOCALAPPDATA%\Programs\Python\Python%%V\python.exe" (
            if not defined PY_EXE (
                set "PY_EXE=%LOCALAPPDATA%\Programs\Python\Python%%V\python.exe"
                set "PY_DIR=%LOCALAPPDATA%\Programs\Python\Python%%V\"
            )
        )
        if exist "C:\Program Files\Python%%V\python.exe" (
            if not defined PY_EXE (
                set "PY_EXE=C:\Program Files\Python%%V\python.exe"
                set "PY_DIR=C:\Program Files\Python%%V\"
            )
        )
    )
)

:: 4. If Python was found, ensure PYTHONHOME is configured for DaVinci Resolve
if defined PY_EXE (
    echo [OK] Python runtime detected: %PY_EXE%
    if defined PY_DIR (
        set "CLEAN_DIR=%PY_DIR:~0,-1%"
        setx PYTHONHOME "%CLEAN_DIR%" >nul 2>&1
        echo [OK] Configured PYTHONHOME for DaVinci Resolve.
    )
    goto :check_resolve
)

:: 5. Python NOT found: Run included offline Python installer or download
echo [!] Python 3 was not detected on this PC.
echo [*] DaVinci Resolve requires 64-bit Python 3 to run automation scripts.

if exist "%~dp0python-3.11-installer.exe" (
    echo [*] Running included Python 3.11 installer (zero download needed)...
    start /wait "" "%~dp0python-3.11-installer.exe" /passive PrependPath=1 Include_tcltk=1
) else (
    echo [*] Downloading and installing official Python 3.11 automatically...
    echo [*] (Please wait 15-20 seconds)...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object System.Net.WebClient).DownloadFile('https://www.python.org/ftp/python/3.11.8/python-3.11.8-amd64.exe', $env:TEMP + '\python-3.11.8-amd64.exe')"
    if exist "%TEMP%\python-3.11.8-amd64.exe" (
        start /wait "" "%TEMP%\python-3.11.8-amd64.exe" /passive PrependPath=1 Include_tcltk=1
        del "%TEMP%\python-3.11.8-amd64.exe" >nul 2>&1
    )
)

:: Configure PYTHONHOME for DaVinci Resolve
set "NEW_PY="
if exist "%LOCALAPPDATA%\Programs\Python\Python311\python.exe" set "NEW_PY=%LOCALAPPDATA%\Programs\Python\Python311"
if exist "C:\Program Files\Python311\python.exe" set "NEW_PY=C:\Program Files\Python311"

if defined NEW_PY (
    setx PYTHONHOME "%NEW_PY%" >nul 2>&1
    echo [OK] Python 3.11 installed successfully and configured for DaVinci Resolve.
) else (
    for /f "delims=" %%I in ('where python 2^>nul') do (
        echo %%I | find /i "WindowsApps" >nul
        if errorlevel 1 (
            if not defined NEW_PY set "NEW_PY=%%~dpI"
        )
    )
    if defined NEW_PY (
        set "CLEAN_NEW=%NEW_PY:~0,-1%"
        setx PYTHONHOME "%CLEAN_NEW%" >nul 2>&1
        echo [OK] Python configured for DaVinci Resolve.
    ) else (
        echo [NOTE] Python installation finished. If Resolve asks for Python, restart your PC once.
    )
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
