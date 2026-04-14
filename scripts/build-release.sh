#!/usr/bin/env bash
# Baut ein Linux-Release-Bundle fuer moolang Alpha.
# Nutzung: scripts/build-release.sh [version]
#
# Erwartet: moo-Quellcode in $MOO_SRC (Standard: ../moo relativ zum Repo)
set -euo pipefail

VERSION="${1:-0.1.0-alpha}"
REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
MOO_SRC="${MOO_SRC:-$HOME/dev/moo}"
BUNDLE_SRC="$REPO_DIR/bundle-src"
DIST="$REPO_DIR/dist"
NAME="moolang-$VERSION-linux-x64"
STAGE="$DIST/$NAME"

echo "=== Build moolang Alpha v$VERSION ==="
echo "Quellcode: $MOO_SRC"

[[ -d "$MOO_SRC/compiler" ]] || { echo "FEHLER: $MOO_SRC/compiler nicht gefunden"; exit 1; }

# 1. Compiler bauen (gl33 Default)
echo ">>> Compiler bauen (release, gl33)..."
(cd "$MOO_SRC/compiler" && cargo build --release --features gl33)

BIN="$MOO_SRC/compiler/target/release/moo-compiler"
[[ -x "$BIN" ]] || { echo "FEHLER: Binary nicht gebaut: $BIN"; exit 1; }

# 2. Staging
echo ">>> Bundle stagen..."
rm -rf "$STAGE"
mkdir -p "$STAGE/beispiele" "$STAGE/stdlib"

cp "$BIN" "$STAGE/moo"
chmod +x "$STAGE/moo"

# Stdlib (wird von moo automatisch relativ zum Binary gesucht)
cp "$MOO_SRC"/stdlib/*.moo "$STAGE/stdlib/" 2>/dev/null || true

# Nur das 3D-Welt-Beispiel (andere noch nicht alpha-verifiziert)
cp "$MOO_SRC/beispiele/welten.moo" "$STAGE/beispiele/welten.moo"

# Bundle-Extras
cp "$BUNDLE_SRC/START_HIER.txt" "$STAGE/"
cp "$BUNDLE_SRC/install.sh" "$STAGE/"
chmod +x "$STAGE/install.sh"
cp "$REPO_DIR/README.md" "$STAGE/README.md"

# 3. Archiv
echo ">>> Archiv erzeugen..."
(cd "$DIST" && tar -czf "$NAME.tar.gz" "$NAME")
(cd "$DIST" && sha256sum "$NAME.tar.gz" > "$NAME.tar.gz.sha256")

echo
echo "✓ Fertig: $DIST/$NAME.tar.gz"
ls -lh "$DIST/$NAME.tar.gz"
cat "$DIST/$NAME.tar.gz.sha256"
