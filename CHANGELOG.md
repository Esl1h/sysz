# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.5.0] - 2026-07-24

First release from [Esl1h/sysz](https://github.com/Esl1h/sysz), which picks
up maintenance of [joehillen/sysz](https://github.com/joehillen/sysz). It
includes the two pull requests that were left open there, credited below.

### Added

- An install script, so getting sysz is one command:
  `curl -fsSL https://raw.githubusercontent.com/Esl1h/sysz/master/install.sh | bash`
- `ctrl-v` toggles the `cat` preview instead of only switching to it,
  by [@greyHairChooseLife](https://github.com/greyHairChooseLife) (joehillen/sysz#31)
- The header lists the keys worth knowing rather than only pointing at `?`,
  and is picked to fit the room the layout leaves it
- Typing to filter and `esc` to quit are listed under `?`, which never said so
- A test suite, run on every push against both the oldest and the newest
  supported fzf

### Changed

- The picker opens as soon as the loaded units are ready, 138ms instead of
  1.6s on a host with ~1300 units. Units that have a unit file but are not
  loaded stream in behind them, and the header says so while they do
  (joehillen/sysz#33)
- Units are ordered loaded first and never-loaded after, each group sorted
  as before. There used to be one global ordering, which was only possible
  because nothing appeared until every unit was known
- The preview no longer always takes 70% of the width. It takes 60% below
  160 columns and 50% below 100, so unit names stay readable over a standard
  80 column ssh session
- `--help` writes to stdout instead of stderr, so its output can be piped,
  by [@tkna91](https://github.com/tkna91) (joehillen/sysz#29)
- Requires fzf >= 0.46.0, the first release that exports `$FZF_PROMPT`

### Fixed

- `journalctl` uses `--user-unit` for user session units (joehillen/sysz#34)
- The `r` and `stat` command aliases work, as the help had always claimed
- `mask`, `unmask`, `show`, `journal` and `follow` appear in the help. They
  were accepted all along but only findable by reading the source
- The exit code after a command is reported explicitly. It was right by
  accident, and would have changed silently if a line were added nearby
- The script path is quoted in the `ctrl-v` binding, so an install under a
  path containing spaces keeps a working preview
- Leaving the picker no longer prints broken pipe errors from `sort`

### Performance

- `_sysz_sort` and the state colouring are done in awk rather than in bash
  while-read loops, cutting CPU time roughly threefold

## [1.4.3] - 2021-10-11

### Fixed

- Ensure that fzf uses bash when calling preview by settings SHELL (#15)

## [1.4.1] - 2021-10-08

### Fixed

- Ensure that fzf uses bash when calling preview

## [1.4.0] - 2021-09-21

### Added

- Major Refactor
- Better ctrl-s and ctrl-r handling
- Better handling of fzf exit codes
- Wider preview window on command prompt

### Fixed

- Remove duplicates

### Removed

- `--reverse`. User can set this using `FZF_DEFAULT_OPTS`.

## [1.3.1] - 2021-09-21

### Fixed

- Require fzf >= 0.27.1
- Unbind ctrl-v in state and daemon-reload prompts

## [1.3.0] - 2021-09-20

### Added

- `cat` command
- `mask` command
- `unmask` command
- color results based on state
- `ctrl-s` to filter states
- `ctrl-r` to run daemon-reload
- `?` to show keybindings

### Fixed

- Do not run `status` after `show`

## [1.2.3] - 2021-09-20

### Fixed

- use `#!/usr/bin/env bash`
- `-s` option is for state

### Added

- `--state=` support

## [1.2.2] - 2021-09-17

### Fixed

- root check

## [1.2.1] - 2021-09-17

### Fixed

- Bug in "follow" action

## [1.2.0] - 2021-09-17

### Added

- Version flag `-v`
- "show" action

### Changed

- Verbose flag to `-V`

### Fixed

- "follow" action
- root user doesn't have a --user instance

## [1.1.0] - 2021-09-02

### Added

- Keybinding `CTRL-v` to cat the current unit in preview window
- Support parametrized units: `unit@.service`

### Changed

- Remove `cat` command
- Show `cat` in preview for parametrized units: `unit@.service`

### Fixed

- Show `start` command if unit is "failed"
- Show `enable` command is unit is "static"
