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

mkdir -p "$RESOLVE_EDIT"
mkdir -p "$RESOLVE_UTIL"

cp "$DIR/Stabilize_Manager.py" "$RESOLVE_EDIT/Stabilize_Manager.py"
cp "$DIR/Stabilize_Manager.py" "$RESOLVE_UTIL/Stabilize_Manager.py"
cp "$DIR/Stabilize_Clip.py" "$RESOLVE_EDIT/Stabilize_Clip.py"
cp "$DIR/Stabilize_Clip.py" "$RESOLVE_UTIL/Stabilize_Clip.py"

chmod +x "$RESOLVE_EDIT/Stabilize_Manager.py" "$RESOLVE_EDIT/Stabilize_Clip.py"
chmod +x "$RESOLVE_UTIL/Stabilize_Manager.py" "$RESOLVE_UTIL/Stabilize_Clip.py"

echo "[✓] Installation successful!"
echo ""
echo "Open DaVinci Resolve and find your tools under:"
echo "   Workspace › Scripts › Edit › Stabilize_Manager"
echo "   Workspace › Scripts › Edit › Stabilize_Clip"
echo "=========================================================="
read -p "Press Enter to finish..."
