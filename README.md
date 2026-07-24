# [sysz](https://github.com/Esl1h/sysz)

A [fzf](https://github.com/junegunn/fzf) terminal UI for systemctl

VERSION: 1.5.0

# Features

- System and user units in one list, searchable together.
- Opens without waiting: the loaded units appear first and the rest stream
  in behind them.
- The keys that matter are in the header, and the split between the list
  and the preview follows the terminal width, so a narrow ssh session is
  not left with unreadable unit names.
- Units are coloured by state and ordered by type: services, then timers,
  then sockets, then the rest.
- Only offers the commands that make sense for the unit in front of you,
  so `start` does not show for something already running.
- Runs `status` after anything that changes a unit, so you see the result.
- Preview shows `status`, or `cat` the unit file with `ctrl-v`.
- Reads the journal for a unit, following it if you want.
- Filters by state with `ctrl-s` or `--state`, and runs `daemon-reload`
  with `ctrl-r`.
- Takes several units, states or commands at once with `TAB`.
- Calls `sudo` only when the unit actually requires it.
- Short aliases for the systemctl commands, to type less.

# Requirements

- systemd, for `systemctl` and `journalctl`
- [fzf](https://github.com/junegunn/fzf) >= [0.46.0](https://github.com/junegunn/fzf/blob/master/CHANGELOG.md#0460)
- bash >= 4.3
- awk, plus the usual `sed`, `sort`, `grep`, `cut` and `stty`

# Installation

sysz is a single bash script, so installing it means putting one file
somewhere on your `PATH`.

There is no distribution package for this fork. The `sysz` in the AUR and
in nixpkgs is built from [joehillen/sysz](https://github.com/joehillen/sysz),
which this forked from and which has not changed since 2022, so those
packages do not carry anything described here.

## Install script

```sh
curl -fsSL https://raw.githubusercontent.com/Esl1h/sysz/main/install.sh | bash
```

Installs to `~/.local/bin`, so it needs no privileges, and says so if that
directory is not on your `PATH`. It checks bash, awk and fzf first and
refuses rather than leaving you with something that will not start.

It reads a few variables:

```sh
# install somewhere else
SYSZ_INSTALL_DIR=/usr/local/bin curl -fsSL .../install.sh | sudo -E bash

# install a particular tag or branch
SYSZ_REF=1.4.3 curl -fsSL .../install.sh | bash
```

Piping a script into a shell is worth being careful about. This one is
[install.sh](install.sh) in this repository if you want to read it first.

## Direct download

```sh
mkdir -p ~/.local/bin
curl -fsSL -o ~/.local/bin/sysz https://raw.githubusercontent.com/Esl1h/sysz/main/sysz
chmod +x ~/.local/bin/sysz
```

## From source

```sh
git clone https://github.com/Esl1h/sysz.git
cd sysz
sudo make install # /usr/local/bin/sysz
```

Running the tests needs [bats](https://github.com/bats-core/bats-core):

```sh
make test
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
