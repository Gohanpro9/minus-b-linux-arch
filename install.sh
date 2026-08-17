#!/bin/bash

GAME_DIR="$HOME/games/MinusBlinustorvalds"
APP_DIR="$HOME/.local/share/applications"
ICON_DIR="$HOME/.local/share/icons"
ARCHIVE="$(dirname "$0")/-B-linux.7z"
TEMP_DIR="$(mktemp -d)"

if [ ! -f "$ARCHIVE" ]; then
    echo "No se encontró -B-linux.7z."
    echo "Coloca install.sh y -B-linux.7z en la misma carpeta."
    exit 1
fi

mkdir -p "$GAME_DIR"
mkdir -p "$APP_DIR"
mkdir -p "$ICON_DIR"

7z x "$ARCHIVE" -o"$TEMP_DIR" >/dev/null || {
    echo "Error al extraer -B-linux.7z."
    rm -rf "$TEMP_DIR"
    exit 1
}

cp -r "$TEMP_DIR/"* "$GAME_DIR/"

chmod +x "$GAME_DIR/-b linux.x86_64"

cp "$GAME_DIR/-B.png" "$ICON_DIR/-B.png"

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
