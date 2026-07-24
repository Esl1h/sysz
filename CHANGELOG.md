# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

Maintenance of this project continues in [Esl1h/sysz](https://github.com/Esl1h/sysz).

### Added

- `ctrl-v` toggles the `cat` preview instead of only switching to it,
  by [@greyHairChooseLife](https://github.com/greyHairChooseLife) (joehillen/sysz#31)

### Changed

- `--help` writes to stdout instead of stderr, so its output can be piped,
  by [@tkna91](https://github.com/tkna91) (joehillen/sysz#29)
- Require fzf >= 0.46.0, the first release that exports `$FZF_PROMPT`

### Performance

- The picker opens as soon as the loaded units are ready, in 138ms instead
  of 1.6s on a host with ~1300 units. Units that have a unit file but are
  not loaded stream in afterwards, and the header says so while they do
  (joehillen/sysz#33)
- `_sysz_sort` and the state colouring are done in awk rather than in bash
  while-read loops, cutting CPU time roughly threefold

### Changed

- Units are ordered loaded first and never-loaded after, each group sorted
  as before. Previously there was a single global ordering, which was only
  possible because nothing was shown until every unit was known.

### Fixed

- `journalctl` uses `--user-unit` for user session units (joehillen/sysz#34)
- Closing the picker no longer prints broken pipe errors from `sort`
- `r` and `stat` command aliases now work as the help always claimed
- `mask`, `unmask`, `show`, `journal` and `follow` are documented in the help
- Quote the script path in the `ctrl-v` binding so installs under a path
  with spaces keep a working preview
- Keep the Console badge in the README generator so it survives regeneration

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
