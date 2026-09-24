@echo off
title whoopseditor DaVinci Resolve Installer
echo ==========================================================
echo           whoopseditor - DaVinci Resolve Tools           
echo         Instagram: @whoopseditor ^| @i.vkpraveenkumar       
echo ==========================================================
echo.

echo [1/3] Installing scripts to DaVinci Resolve directories...

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

echo [OK] Script files successfully copied to DaVinci Resolve menus!
echo.

echo [2/3] Checking Python 3 runtime for DaVinci Resolve...

set "PY_EXE="
set "PY_HOME="

:: Check 1: Python 3.11 64-bit in User AppData
if exist "%LOCALAPPDATA%\Programs\Python\Python311\python.exe" (
    if exist "%LOCALAPPDATA%\Programs\Python\Python311\python311.dll" (
        set "PY_EXE=%LOCALAPPDATA%\Programs\Python\Python311\python.exe"
        set "PY_HOME=%LOCALAPPDATA%\Programs\Python\Python311"
    )
)

:: Check 2: Python 3.11 64-bit in Program Files
if not defined PY_EXE (
    if exist "C:\Program Files\Python311\python.exe" (
        if exist "C:\Program Files\Python311\python311.dll" (
            set "PY_EXE=C:\Program Files\Python311\python.exe"
            set "PY_HOME=C:\Program Files\Python311"
        )
    )
)

:: Check 3: Python 3.10 64-bit in User AppData
if not defined PY_EXE (
    if exist "%LOCALAPPDATA%\Programs\Python\Python310\python.exe" (
        if exist "%LOCALAPPDATA%\Programs\Python\Python310\python310.dll" (
            set "PY_EXE=%LOCALAPPDATA%\Programs\Python\Python310\python.exe"
            set "PY_HOME=%LOCALAPPDATA%\Programs\Python\Python310"
        )
    )
)

:: Check 4: Python 3.10 64-bit in Program Files
if not defined PY_EXE (
    if exist "C:\Program Files\Python310\python.exe" (
        if exist "C:\Program Files\Python310\python310.dll" (
            set "PY_EXE=C:\Program Files\Python310\python.exe"
            set "PY_HOME=C:\Program Files\Python310"
        )
    )
)

:: Validate existing installation
if defined PY_EXE (
    "%PY_EXE%" -c "import tkinter" >nul 2>&1
    if errorlevel 1 (
        echo [!] Existing Python at %PY_HOME% is missing Tkinter UI support.
        set "PY_EXE="
        set "PY_HOME="
    )
)

if defined PY_EXE (
    echo [OK] Compatible Python runtime detected: %PY_EXE%
    goto :setup_env
)

echo [!] Compatible 64-bit Python (3.11 or 3.10) not detected for DaVinci Resolve.
echo.
echo [3/3] Installing Python 3.11 Runtime...

if exist "%~dp0python-3.11-installer.exe" (
    echo [*] Found bundled installer: python-3.11-installer.exe
    echo [*] Starting automated Python 3.11 setup (with Tkinter and PATH)...
    echo [*] A progress bar will appear. Please wait 15-30 seconds...
    start /wait "" "%~dp0python-3.11-installer.exe" /passive InstallAllUsers=0 PrependPath=1 Include_tcltk=1
) else (
    echo [!] Bundled installer not found in folder.
    echo [*] Downloading official Python 3.11 installer (25 MB)...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object System.Net.WebClient).DownloadFile('https://www.python.org/ftp/python/3.11.8/python-3.11.8-amd64.exe', $env:TEMP + '\python-3.11-installer.exe')"
    if exist "%TEMP%\python-3.11-installer.exe" (
        echo [*] Running downloaded Python 3.11 installer...
        start /wait "" "%TEMP%\python-3.11-installer.exe" /passive InstallAllUsers=0 PrependPath=1 Include_tcltk=1
        del "%TEMP%\python-3.11-installer.exe" >nul 2>&1
    )
)

:: Re-verify installation after installer finishes
if exist "%LOCALAPPDATA%\Programs\Python\Python311\python.exe" (
    set "PY_EXE=%LOCALAPPDATA%\Programs\Python\Python311\python.exe"
    set "PY_HOME=%LOCALAPPDATA%\Programs\Python\Python311"
    echo [OK] Python 3.11 successfully installed!
) else if exist "C:\Program Files\Python311\python.exe" (
    set "PY_EXE=C:\Program Files\Python311\python.exe"
    set "PY_HOME=C:\Program Files\Python311"
    echo [OK] Python 3.11 successfully installed!
) else (
    echo.
    echo [!] Automated installation didn't finish. Launching setup window...
    echo [*] In the setup window:
    echo     1. Check the box "Add python.exe to PATH" at the bottom!
    echo     2. Click "Install Now".
    echo.
    start /wait "" "%~dp0python-3.11-installer.exe" PrependPath=1 Include_tcltk=1
    if exist "%LOCALAPPDATA%\Programs\Python\Python311\python.exe" (
        set "PY_EXE=%LOCALAPPDATA%\Programs\Python\Python311\python.exe"
        set "PY_HOME=%LOCALAPPDATA%\Programs\Python\Python311"
    ) else if exist "C:\Program Files\Python311\python.exe" (
        set "PY_EXE=C:\Program Files\Python311\python.exe"
        set "PY_HOME=C:\Program Files\Python311"
    )
)

:setup_env
if defined PY_HOME (
    setx PYTHONHOME "%PY_HOME%" >nul 2>&1
    echo [OK] Configured PYTHONHOME for DaVinci Resolve: "%PY_HOME%"
) else (
    echo [WARNING] Could not verify Python installation path.
    echo If DaVinci Resolve says Python not found, run python-3.11-installer.exe manually.
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

echo.
pause
