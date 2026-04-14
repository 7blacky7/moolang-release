# moolang — Alpha

> ⚠️ **Alpha-Version** — Die Sprache funktioniert, aber Name und Dateiendung sind **nicht final**.
> Das Projekt heißt aktuell `moolang` als Platzhalter (die Endung bleibt `.moo`).
> Da bereits eine MUD-Sprache namens „MOO" existiert, wird der finale Name noch geändert.
> Rechne mit Breaking Changes bis v1.0.

## Was ist das?

Eine Programmiersprache auf Deutsch (mit Englisch-Aliases), die direkt zu nativen Binaries kompiliert wird — via LLVM. Mit eingebauter 2D/3D-Grafik, Netzwerk-, Datei- und Datenbank-Runtime.

## Download & Start (Alpha)

1. Lade das Archiv für dein System von **[Releases](../../releases)** herunter:
   - Linux: `moolang-alpha-linux-x64.tar.gz`
   - Windows: `moolang-alpha-windows-x64.zip`
   - macOS: `moolang-alpha-macos.tar.gz`
2. Entpacken
3. `./install.sh` ausführen (Linux/macOS) bzw. `install.bat` (Windows) — installiert nötige System-Libs
4. Starte das 3D-Welt-Beispiel:
   ```sh
   ./moo run beispiele/welten.moo
   ```

## Das 3D-Welt-Beispiel

`beispiele/welten.moo` — prozedural generierte 3D-Welt mit Perlin-Noise-Terrain, 6 Biomen (Ozean, Strand, Wiese, Wald, Berg, Schnee), Flüssen und First-Person-Kamera. ~400 Zeilen moolang-Code.

**Steuerung**: `WASD` bewegen, Maus umsehen, `Leertaste` springen, `Escape` beenden.

## Eigenen Code schreiben

```moo
# hallo.moo
zeige "Hallo, Welt!"
```

```sh
./moo run hallo.moo       # direkt ausführen
./moo compile hallo.moo   # native Binary erzeugen
./moo repl                # interaktiver Modus
```

## Status

Verifizierter Beispielumfang in diesem Alpha-Bundle: **nur `welten.moo`**.
Weitere Beispiele (Pong, Snake, Zelda, Breakout, Tetris …) folgen in späteren Releases, sobald sie auf allen Plattformen verifiziert sind.

## Lizenz

Open Source — Lizenz wird vor v1.0 festgelegt.
