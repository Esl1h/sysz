#!/bin/bash
BLOCK='```'

# $XDG_CACHE_HOME is meant to reach the README as those literal
# characters, so the home directory of whoever generated it does not.
# shellcheck disable=SC2016
USAGE=$(./sysz -h | sed -e 's:/home/[a-z]\+/.cache:$XDG_CACHE_HOME:')

cat <<EOF >README.md
# [sysz](https://github.com/Esl1h/sysz)

A [fzf](https://github.com/junegunn/fzf) terminal UI for systemctl

VERSION: $(cat VERSION)

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
  so \`start\` does not show for something already running.
- Runs \`status\` after anything that changes a unit, so you see the result.
- Preview shows \`status\`, or \`cat\` the unit file with \`ctrl-v\`.
- Reads the journal for a unit, following it if you want.
- Filters by state with \`ctrl-s\` or \`--state\`, and runs \`daemon-reload\`
  with \`ctrl-r\`.
- Takes several units, states or commands at once with \`TAB\`.
- Calls \`sudo\` only when the unit actually requires it.
- Short aliases for the systemctl commands, to type less.

# Requirements

- systemd, for \`systemctl\` and \`journalctl\`
- [fzf](https://github.com/junegunn/fzf) >= [0.46.0](https://github.com/junegunn/fzf/blob/master/CHANGELOG.md#0460)
- bash >= 4.3
- awk, plus the usual \`sed\`, \`sort\`, \`grep\`, \`cut\` and \`stty\`

# Installation

sysz is a single bash script, so installing it means putting one file
somewhere on your \`PATH\`.

There is no distribution package for this fork. The \`sysz\` in the AUR and
in nixpkgs is built from [joehillen/sysz](https://github.com/joehillen/sysz),
which this forked from and which has not changed since 2022, so those
packages do not carry anything described here.

## Install script

${BLOCK}sh
curl -fsSL https://raw.githubusercontent.com/Esl1h/sysz/main/install.sh | bash
${BLOCK}

Installs to \`~/.local/bin\`, so it needs no privileges, and says so if that
directory is not on your \`PATH\`. It checks bash, awk and fzf first and
refuses rather than leaving you with something that will not start.

It reads a few variables:

${BLOCK}sh
# install somewhere else
SYSZ_INSTALL_DIR=/usr/local/bin curl -fsSL .../install.sh | sudo -E bash

# install a particular tag or branch
SYSZ_REF=1.4.3 curl -fsSL .../install.sh | bash
${BLOCK}

Piping a script into a shell is worth being careful about. This one is
[install.sh](install.sh) in this repository if you want to read it first.

## Direct download

${BLOCK}sh
mkdir -p ~/.local/bin
curl -fsSL -o ~/.local/bin/sysz https://raw.githubusercontent.com/Esl1h/sysz/main/sysz
chmod +x ~/.local/bin/sysz
${BLOCK}

## From source

${BLOCK}sh
git clone https://github.com/Esl1h/sysz.git
cd sysz
sudo make install # /usr/local/bin/sysz
${BLOCK}

Running the tests needs [bats](https://github.com/bats-core/bats-core):

${BLOCK}sh
make test
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
