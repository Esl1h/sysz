# [sysz](https://github.com/Esl1h/sysz)

A [fzf](https://github.com/junegunn/fzf) terminal UI for systemctl

<a href="https://console.dev" title="Visit Console - the best tools for developers"><img src="https://console.dev/img/badges/1.0/svg/console-badge-logo-dark.svg" alt="Console - Developer Tool of the Week" /></a>

# Demo

[![asciicast](https://asciinema.org/a/BLsJz73uF7DdQj7FVGqLPhqCa.svg)](https://asciinema.org/a/BLsJz73uF7DdQj7FVGqLPhqCa)

# Features

VERSION: 1.4.3

- See and filter both system and user units simultaneously.
- Supports all unit types.
- Opens right away: loaded units are shown first and the rest stream in.
- Keys are listed in the header, and the layout adapts to the terminal
  width so nothing is cut off over a narrow ssh session.
- Units ordered by service, timer, socket, and the rest.
- Runs `sudo` automatically and only if necessary.
- Filter units by state using `ctrl-s` or the `--state` option.
- Run `daemon-reload` with `ctrl-r`.
- Has short versions of systemctl commands to reduce typing.
- Runs status after other commands (start, stop, restart, etc).
- Select multiple units, states, and commands using `TAB`.
- Only prompts commands based on current state
  (e.g. show "start" only if the unit is inactive).

# Requirements

- [fzf](https://github.com/junegunn/fzf) >= [0.46.0](https://github.com/junegunn/fzf/blob/master/CHANGELOG.md#0460)
- bash > 4.3 (released 2009)
- awk

# Installation

This is a maintained fork of [joehillen/sysz](https://github.com/joehillen/sysz).
The AUR and nixpkgs packages below are still built from the original
repository and do not carry the changes made here yet. To get this fork,
use the direct download or build from source.

## Arch Linux

```
paru -S sysz
```

## NixOS

```
nix-env -iA nixos.sysz
```

## Using Nix

```
nix-env -iA nixpkgs.sysz
```

## Using [`bin`](https://github.com/marcosnils/bin)

```
bin install https://github.com/Esl1h/sysz
```

## Direct Download

```sh
wget -O ~/.bin/sysz https://raw.githubusercontent.com/Esl1h/sysz/master/sysz
chmod +x ~/.bin/sysz
```

## From Source

```sh
git clone https://github.com/Esl1h/sysz.git
cd sysz
sudo make install # /usr/local/bin/sysz
```

# Usage

```text
A utility for using systemctl interactively via fzf.

Usage: sysz [OPTS...] [CMD] [-- ARGS...]

sudo is invoked automatically, if necessary.

If only one unit is chosen, available commands will be presented
based on the state of the unit (e.g. "start" only shows if unit is "active").

OPTS:
  -u, --user               Only show --user units
  --sys, --system          Only show --system units
  -s STATE, --state STATE  Only show units in STATE (repeatable)
  -V, --verbose            Print the systemctl command
  -v, --version            Print the version
  -h, --help               Print this message

  If no options are given, both system and user units are shown.

CMD:
  start                  systemctl start <unit>
  stop                   systemctl stop <unit>
  r, re, restart         systemctl restart <unit>
  reload                 systemctl reload <unit>
  s, stat, status        systemctl status <unit>
  en, enable             systemctl enable <unit>
  d, dis, disable        systemctl disable <unit>
  mask                   systemctl mask <unit>
  unmask                 systemctl unmask <unit>
  c, cat                 systemctl cat <unit>
  ed, edit               systemctl edit <unit>
  show                   systemctl show <unit>
  j, journal             journalctl -xe --unit <unit>
  f, follow              journalctl -xef --unit <unit>

  If no command is given, one or more can be chosen interactively.

ARGS are passed to the systemctl command for each selected unit.

Keybindings:
  type          Filter the list. Space separates terms.
  TAB           Toggle selection.
  ctrl-v        Toggle 'cat' the unit in the preview window.
  ctrl-s        Select states to match. Selection is reset.
  ctrl-r        Run daemon-reload. Selection is reset.
  ctrl-p        History previous.
  ctrl-n        History next.
  ?             Show keybindings.
  esc, ctrl-c   Quit.

History:
  sysz is stored in $XDG_CACHE_HOME/sysz/history
  This can be changed with the environment variable: SYSZ_HISTORY

Some units are colored based on state:
  green       active
  red         failed
  yellow      not-found

Examples:
  sysz -u                      User units
  sysz --sys -s active          Active system units
  sysz --user --state failed   Failed user units

Examples with commands:
  sysz start                  Start a unit
  sysz --sys s                Get the status of system units
  sysz --user edit            Edit user units
  sysz s -- -n100             Show status with 100 log lines
  sysz --sys -s active stop    Stop an active system unit
  sysz -u --state failed r    Restart failed user units
```

# Acknowledgements

Originally written by [Joe Hillenbrand](https://github.com/joehillen). This
fork picks up maintenance where [joehillen/sysz](https://github.com/joehillen/sysz)
left off.

Inspired by [fuzzy-sys](https://github.com/NullSense/fuzzy-sys) by [NullSense](https://github.com/NullSense/)

Thank you for [ShellCheck](https://github.com/koalaman/shellcheck) without which this would be a buggy mess.
