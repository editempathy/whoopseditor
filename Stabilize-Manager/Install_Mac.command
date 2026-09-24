#!/bin/bash
# whoopseditor - 1-Click Installer for macOS
# Instagram: @whoopseditor | Personal: @i.vkpraveenkumar
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
RESOLVE_EDIT="$HOME/Library/Application Support/Blackmagic Design/DaVinci Resolve/Fusion/Scripts/Edit"
RESOLVE_UTIL="$HOME/Library/Application Support/Blackmagic Design/DaVinci Resolve/Fusion/Scripts/Utility"

echo "=========================================================="
echo "          whoopseditor - DaVinci Resolve Tools            "
echo "        Instagram: @whoopseditor | @i.vkpraveenkumar       "
echo "=========================================================="
echo ""
echo "[*] Note: Please ensure you are connected to the internet"
echo "    so the installer can automatically configure the"
echo "    required Python runtime if not already present."
echo ""

mkdir -p "$RESOLVE_EDIT"
mkdir -p "$RESOLVE_UTIL"

echo "[*] Installing scripts to DaVinci Resolve..."
cp "$DIR/Stabilize_Manager.py" "$RESOLVE_EDIT/Stabilize_Manager.py"
cp "$DIR/Stabilize_Manager.py" "$RESOLVE_UTIL/Stabilize_Manager.py"
cp "$DIR/Stabilize_Clip.py" "$RESOLVE_EDIT/Stabilize_Clip.py"
cp "$DIR/Stabilize_Clip.py" "$RESOLVE_UTIL/Stabilize_Clip.py"

chmod +x "$RESOLVE_EDIT/Stabilize_Manager.py" "$RESOLVE_EDIT/Stabilize_Clip.py" 2>/dev/null
chmod +x "$RESOLVE_UTIL/Stabilize_Manager.py" "$RESOLVE_UTIL/Stabilize_Clip.py" 2>/dev/null

echo "[OK] Scripts copied to Edit & Utility menus."
echo ""

echo "[*] Checking Python 3 runtime for DaVinci Resolve..."

PY_READY=0
if command -v python3 >/dev/null 2>&1; then
    if python3 -c "import tkinter, sys; sys.exit(0 if sys.version_info >= (3,8) else 1)" >/dev/null 2>&1; then
        PY_READY=1
        echo "[OK] Python 3 runtime detected."
    fi
fi

if [ $PY_READY -eq 0 ]; then
    echo "[!] Python 3 (with Tkinter) was not detected on this Mac."
    echo "[*] DaVinci Resolve requires 64-bit Python 3 to run automation scripts."
    echo "[*] Downloading official Python 3.11 for macOS (Universal - Apple Silicon & Intel)..."
    echo "[*] Please wait (~15-30 seconds depending on connection)..."
    
    PKG_PATH="/tmp/python-3.11.8-macos11.pkg"
    curl -L --progress-bar -o "$PKG_PATH" "https://www.python.org/ftp/python/3.11.8/python-3.11.8-macos11.pkg"
    
    if [ -f "$PKG_PATH" ]; then
        echo ""
        echo "[*] Installing Python 3.11 runtime (please enter your Mac password / Touch ID if prompted)..."
        if command -v osascript >/dev/null 2>&1; then
            osascript -e 'do shell script "installer -pkg /tmp/python-3.11.8-macos11.pkg -target /" with administrator privileges' >/dev/null 2>&1
            INSTALL_STATUS=$?
        else
            sudo installer -pkg "$PKG_PATH" -target /
            INSTALL_STATUS=$?
        fi
        rm -f "$PKG_PATH"
        
        if [ $INSTALL_STATUS -eq 0 ]; then
            echo "[OK] Python 3.11 successfully installed and configured for DaVinci Resolve!"
        else
            echo "[WARNING] Installation was cancelled or failed. Please run installer again or install from python.org."
        fi
    else
        echo ""
        echo "[!] ERROR: Failed to download Python runtime."
        echo "[!] An active internet connection is required during installation."
        echo "[!] Please connect to the internet and run Install_Mac.command again."
    fi
fi

echo ""
echo "=========================================================="
echo "[OK] Installation Completed Successfully!"
echo ""
echo "Your tools are ready inside DaVinci Resolve under:"
echo "   Workspace › Scripts › Edit › Stabilize_Manager"
echo "   Workspace › Scripts › Edit › Stabilize_Clip"
echo "=========================================================="

if pgrep -x "Resolve" >/dev/null 2>&1; then
    echo ""
    echo "[IMPORTANT NOTICE]"
    echo "DaVinci Resolve is currently running!"
    echo "Please RESTART DaVinci Resolve now so it detects Python and the new scripts."
    echo "=========================================================="
fi

echo ""
read -p "Press Enter to finish..."
