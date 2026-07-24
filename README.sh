#!/bin/bash
BLOCK='```'

# $XDG_CACHE_HOME is meant to reach the README as those literal
# characters, so the home directory of whoever generated it does not.
# shellcheck disable=SC2016
USAGE=$(./sysz -h | sed -e 's:/home/[a-z]\+/.cache:$XDG_CACHE_HOME:')

cat <<EOF >README.md
# [sysz](https://github.com/Esl1h/sysz)

A [fzf](https://github.com/junegunn/fzf) terminal UI for systemctl

<a href="https://console.dev" title="Visit Console - the best tools for developers"><img src="https://console.dev/img/badges/1.0/svg/console-badge-logo-dark.svg" alt="Console - Developer Tool of the Week" /></a>

# Demo

[![asciicast](https://asciinema.org/a/BLsJz73uF7DdQj7FVGqLPhqCa.svg)](https://asciinema.org/a/BLsJz73uF7DdQj7FVGqLPhqCa)

# Features

VERSION: $(cat VERSION)

- See and filter both system and user units simultaneously.
- Supports all unit types.
- Opens right away: loaded units are shown first and the rest stream in.
- Keys are listed in the header, and the layout adapts to the terminal
  width so nothing is cut off over a narrow ssh session.
- Units ordered by service, timer, socket, and the rest.
- Runs \`sudo\` automatically and only if necessary.
- Filter units by state using \`ctrl-s\` or the \`--state\` option.
- Run \`daemon-reload\` with \`ctrl-r\`.
- Has short versions of systemctl commands to reduce typing.
- Runs status after other commands (start, stop, restart, etc).
- Select multiple units, states, and commands using \`TAB\`.
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
use the install script, the direct download, or build from source.

## Install script

${BLOCK}sh
curl -fsSL https://raw.githubusercontent.com/Esl1h/sysz/master/install.sh | bash
${BLOCK}

Installs to \`~/.local/bin\` and tells you if that is not on your \`PATH\`.
It checks bash, awk and fzf first, and refuses rather than installing
something that cannot run.

${BLOCK}sh
# somewhere else, needs write access to the directory
SYSZ_INSTALL_DIR=/usr/local/bin curl -fsSL .../install.sh | sudo -E bash

# a specific tag or branch
SYSZ_REF=1.4.3 curl -fsSL .../install.sh | bash
${BLOCK}

If you would rather read it before running it, it is
[install.sh](install.sh) in this repository.

## Arch Linux

${BLOCK}
paru -S sysz
${BLOCK}

## NixOS

${BLOCK}
nix-env -iA nixos.sysz
${BLOCK}

## Using Nix

${BLOCK}
nix-env -iA nixpkgs.sysz
${BLOCK}

## Using [\`bin\`](https://github.com/marcosnils/bin)

${BLOCK}
bin install https://github.com/Esl1h/sysz
${BLOCK}

## Direct Download

${BLOCK}sh
wget -O ~/.bin/sysz https://raw.githubusercontent.com/Esl1h/sysz/master/sysz
chmod +x ~/.bin/sysz
${BLOCK}

## From Source

${BLOCK}sh
git clone https://github.com/Esl1h/sysz.git
cd sysz
sudo make install # /usr/local/bin/sysz
${BLOCK}

# Usage

${BLOCK}text
$USAGE
${BLOCK}

# Acknowledgements

Originally written by [Joe Hillenbrand](https://github.com/joehillen). This
fork picks up maintenance where [joehillen/sysz](https://github.com/joehillen/sysz)
left off.

Inspired by [fuzzy-sys](https://github.com/NullSense/fuzzy-sys) by [NullSense](https://github.com/NullSense/)

Thank you for [ShellCheck](https://github.com/koalaman/shellcheck) without which this would be a buggy mess.
EOF
