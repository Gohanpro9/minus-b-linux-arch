#!/bin/bash

GAME_DIR="$HOME/games/MinusBlinustorvalds"
APP_DIR="$HOME/.local/share/applications"
ICON_DIR="$HOME/.local/share/icons"
SCRIPT_DIR="$(dirname "$0")"
ARCHIVE="$SCRIPT_DIR/MinusBlinustorvalds.7z"
ICON="$SCRIPT_DIR/-B.png"
TEMP_DIR="$(mktemp -d)"

if [ ! -f "$ARCHIVE" ]; then
    echo "No se encontró MinusBlinustorvalds.7z."
    echo "Coloca MinusBlinustorvalds.7z, -B.png e install.sh en la misma carpeta."
    exit 1
fi

if [ ! -f "$ICON" ]; then
    echo "No se encontró -B.png."
    echo "Coloca MinusBlinustorvalds.7z, -B.png e install.sh en la misma carpeta."
    exit 1
fi

mkdir -p "$GAME_DIR"
mkdir -p "$APP_DIR"
mkdir -p "$ICON_DIR"

7z x "$ARCHIVE" -o"$TEMP_DIR" >/dev/null || {
    echo "Error al extraer MinusBlinustorvalds.7z."
    rm -rf "$TEMP_DIR"
    exit 1
}

cp -r "$TEMP_DIR/MinusBlinustorvalds/"* "$GAME_DIR/"

chmod +x "$GAME_DIR/-b linux.x86_64"

cp "$ICON" "$ICON_DIR/-B.png"

cat > "$APP_DIR/-b.desktop" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=-B
Comment=MINUS B!
Exec="$GAME_DIR/-b linux.x86_64"
Icon=$ICON_DIR/-B.png
Terminal=false
Categories=Game;
EOF

chmod +x "$APP_DIR/-b.desktop"

rm -rf "$TEMP_DIR"

echo "-B instalado correctamente."

rm -rf "$TEMP_DIR"

echo "-B instalado correctamente."
