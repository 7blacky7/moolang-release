# moolang — Alpha

> ⚠️ **Alpha-Version** — Die Sprache funktioniert, aber **Name und Dateiendung sind nicht final**.
> Das Projekt heißt aktuell `moolang` als Platzhalter (Dateiendung: `.moo`).
> Da bereits eine MUD-Sprache namens „MOO" existiert, wird der finale Name vor v1.0 geändert.
> Rechne mit Breaking Changes bis zur stabilen Version.

---

## Was ist moolang?

Eine **Programmiersprache auf Deutsch** (mit Englisch-Aliases), die direkt zu **nativen Binaries** kompiliert wird — via LLVM. Inklusive eingebauter Runtime für:

- **2D-Grafik & Sprites** (SDL2)
- **3D-Rendering** (OpenGL 3.3)
- **Netzwerk** (HTTP, WebSocket, Sockets)
- **Dateisystem, Datenbank** (SQLite), **Kryptografie**
- **REPL, Module, Pakete, Threads, Regex, JSON**

Ein Programm:

```moo
zeige "Hallo, Welt!"

funktion fakultät(n):
    wenn n <= 1:
        gib_zurück 1
    gib_zurück n * fakultät(n - 1)

zeige fakultät(10)
```

---

## Download & Start

1. Lade das Archiv für dein System von **[Releases](../../releases)** herunter:
   - Linux x64: `moolang-alpha-linux-x64.tar.gz`
   - Windows x64: `moolang-alpha-windows-x64.zip`
   - macOS: `moolang-alpha-macos.tar.gz`

2. **Entpacken** in ein Verzeichnis deiner Wahl.

3. **Einmalig System-Libs installieren** (Linux/macOS):
   ```sh
   ./install.sh
   ```
   Windows: DLLs sind im `lib/`-Ordner gebündelt, keine Installation nötig.

4. **3D-Welt-Beispiel starten**:
   ```sh
   ./moo run beispiele/welten.moo
   ```

---

## Das 3D-Welt-Beispiel

`beispiele/welten.moo` — prozedural generierte 3D-Welt (~400 Zeilen moolang):

- Perlin-Noise-Terrain
- 6 Biome: Ozean, Strand, Wiese, Wald, Berg, Schnee
- Flüsse, Bäume, Tag-Nacht-Zyklus
- First-Person-Kamera mit Gravitation

**Steuerung**: `WASD` bewegen · Maus umsehen · `Leertaste` springen · `Escape` beenden.

---

## Eigenen Code schreiben

```sh
./moo run hallo.moo       # direkt ausführen
./moo compile hallo.moo   # native Binary erzeugen
./moo repl                # interaktiver Modus
./moo paket install NAME  # Paket von github.com/moo-packages installieren
```

Die Sprache ist **zweisprachig**:

| Deutsch | Englisch |
|--------|----------|
| `setze x auf 5` | `set x to 5` |
| `wenn x > 3:` | `if x > 3:` |
| `solange x < 10:` | `while x < 10:` |
| `für i in liste:` | `for i in liste:` |
| `funktion f(x):` | `func f(x):` |
| `gib_zurück wert` | `return wert` |
| `zeige "Hallo"` | `show "Hallo"` |

---

## VS Code Integration

Für **Syntax-Highlighting** und einen einfachen **Language Server** (Diagnostics, Keyword-Completion) gibt es eine VS-Code-Extension im Quell-Repo.

### Installation (manuell — noch nicht im Marketplace)

1. Quell-Repo klonen:
   ```sh
   git clone https://github.com/7blacky7/moo.git ~/dev/moo
   ```
2. Extension-Ordner nach VS Code kopieren:
   ```sh
   # Linux / macOS
   cp -r ~/dev/moo/editors/vscode/moo ~/.vscode/extensions/moo-lang-0.2.0
   ```
   ```powershell
   # Windows
   xcopy /E moo\editors\vscode\moo %USERPROFILE%\.vscode\extensions\moo-lang-0.2.0\
   ```
3. VS Code neu starten → `.moo`-Dateien haben Syntax-Highlighting.

### Language Server (optional — braucht Python + uv)

Der LSP-Server ist in Python und liefert Fehler-Diagnostics und Keyword-Completion. Nur nötig wenn du mehr als reines Highlighting willst.

```sh
# uv installieren: https://github.com/astral-sh/uv
cd ~/dev/moo
uv sync
```

Die VS-Code-Extension startet den LSP dann automatisch (`uv run moo lsp`).

---

## Beispiel-Umfang dieses Alpha-Bundles

**Verifiziert**: `beispiele/welten.moo` (3D-Welt)

Im Quell-Repo (https://github.com/7blacky7/moo) findest du **126+ weitere Beispiele** — darunter Pong, Snake, Tetris, Zelda, Breakout, Asteroids, Bomberman, Pacman, Platformer, Tower Defense, Sudoku, Chess, RPG-World, Bubble Shooter, Fruit Ninja, Mini-SQL, Mini-Redis, Blog-Engine, Websocket-Server, Raytracer, Neural Net, X86-Disassembler, Regex-Engine und viele mehr.

Diese werden in kommenden Alpha-Releases schrittweise mitgebündelt, sobald sie auf allen drei Plattformen verifiziert sind.

Du kannst sie aber schon jetzt selbst bauen:

```sh
git clone https://github.com/7blacky7/moo.git
cd moo/beispiele
~/pfad/zu/moo run pong.moo
```

---

## Lernen

Vollständiges Sprach-Tutorial: [`docs/lernen.md`](https://github.com/7blacky7/moo/blob/master/docs/lernen.md) im Quell-Repo.

Inhalte: Variablen, Typen, Bedingungen, Schleifen, Listen, Funktionen, Lambdas, Module, Klassen/OOP, JSON, HTTP, Krypto, Datei-I/O, Regex, Stdlib, 2D/3D-Grafik, Threads.

---

## Systemvoraussetzungen

**Runtime-Bibliotheken** (werden von `install.sh` automatisch installiert):

- SDL2 + SDL2_image (2D-Grafik)
- GLFW (3D-Fenster)
- OpenGL 3.3+
- curl (HTTP)
- sqlite3 (Datenbank)

**Für eigene Compile-Builds** (nicht nötig zum Ausführen):
- Rust 1.85+ (Edition 2024)
- LLVM 18
- cc / gcc

---

## Status & Bekannte Einschränkungen

Dies ist eine **Alpha**. Bekannte offene Punkte:

- Name und Dateiendung werden noch geändert
- Bisher nur ein verifiziertes Beispiel im Bundle
- Windows: ausführliche Tests stehen noch aus
- macOS: Apple Silicon + Intel werden gebaut, aber keine Notarisierung (Gatekeeper-Warnung beim ersten Start → „Öffnen trotzdem")
- LSP nur rudimentär (Syntax-Level, kein Typsystem)
- Kein Paket-Registry — Pakete gehen aktuell nur über `github.com/moo-packages/<name>`

---

## Lizenz

Open Source — finale Lizenzwahl vor v1.0. Quellcode: https://github.com/7blacky7/moo

---

## Bugs & Feedback

Bitte unter **[Issues](../../issues)** melden.
Bei einem Absturz bitte dazuschreiben:

- Betriebssystem + Version
- Ausgabe von `./moo --help`
- Der `.moo`-Code (oder ein Minimalbeispiel, das den Fehler auslöst)
