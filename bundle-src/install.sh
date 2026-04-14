#!/usr/bin/env bash
# moolang Alpha — System-Dependencies installieren (Linux/macOS)
set -e

echo "=== moolang Alpha Installer ==="

detect_os() {
  if [[ "$OSTYPE" == "darwin"* ]]; then echo "macos"
  elif command -v pacman &>/dev/null; then echo "arch"
  elif command -v apt-get &>/dev/null; then echo "debian"
  elif command -v dnf &>/dev/null; then echo "fedora"
  else echo "unknown"; fi
}

OS=$(detect_os)
echo "Erkannt: $OS"

case "$OS" in
  arch)
    sudo pacman -S --needed --noconfirm sdl2 sdl2_image glfw mesa curl sqlite glibc
    ;;
  debian)
    sudo apt-get update
    sudo apt-get install -y libsdl2-2.0-0 libsdl2-image-2.0-0 libglfw3 libgl1 libcurl4 libsqlite3-0
    ;;
  fedora)
    sudo dnf install -y SDL2 SDL2_image glfw mesa-libGL libcurl sqlite
    ;;
  macos)
    if ! command -v brew &>/dev/null; then
      echo "Homebrew fehlt. Installiere: https://brew.sh"; exit 1
    fi
    brew install sdl2 sdl2_image glfw curl sqlite
    ;;
  *)
    echo "Unbekanntes System. Bitte manuell installieren:"
    echo "  SDL2, SDL2_image, GLFW, OpenGL, curl, sqlite"
    exit 1
    ;;
esac

chmod +x "$(dirname "$0")/moo"
echo
echo "✓ Fertig. Starte mit:   ./moo run beispiele/welten.moo"
