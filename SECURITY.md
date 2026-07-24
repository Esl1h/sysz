# Security policy

## Reporting a vulnerability

Report privately through
[GitHub Security Advisories](https://github.com/Esl1h/sysz/security/advisories/new).
That opens a report only the maintainer can see, and gives us a private
place to work on a fix before it is public.

Please do not open a public issue for a vulnerability.

What helps: the version (`sysz --version`), the fzf version, and the
smallest sequence of steps that shows the problem. A unit name or an
argument that triggers it is worth more than a description of it.

This is maintained by one person in their own time. You should expect a
first reply within a week. If a fix is warranted it goes out as a release,
and the advisory is published once it is available.

## Supported versions

Only the latest release. This is a single script with no branches to
backport to, so a fix means a new release.

| Version | Supported |
| ------- | --------- |
| 1.5.x   | yes       |
| < 1.5   | no        |

Versions before 1.5.0 came from
[joehillen/sysz](https://github.com/joehillen/sysz), which has not been
updated since 2021 and is not maintained here.

## What is worth reporting

sysz builds `systemctl` and `journalctl` command lines out of unit names
and options, and calls `sudo` when a system unit needs it. It also hands
commands to `fzf` to run for the preview. So the interesting failures are:

- A unit name, state or argument that escapes its quoting and ends up
  executed as something else. Unit names come from `systemctl` output, but
  they are attacker-influenced on a host where an unprivileged user can
  create user units.
- Anything that makes `sudo` run a command the user did not choose, or run
  it for a unit that would not have required it.
- The install script fetching or installing something other than what it
  verified.
- A file written outside the intended path, including through
  `SYSZ_HISTORY` or `SYSZ_INSTALL_DIR`.

## What is not a vulnerability here

- sysz runs the systemctl command you chose, with sudo when the unit needs
  it. Stopping a unit you had permission to stop is the tool working.
- Requiring sudo for system units. That is systemd's boundary, not ours.
- Anything that needs write access to the sysz script itself, or to the
  unit files it displays. Someone who has that already has more than sysz
  can give them.
- The install script running code from the network. That is what
  `curl | bash` is; the script is in this repository to be read first, and
  `SYSZ_REF` pins it to a tag.

## How this project reduces its own risk

- No dependencies to be compromised: one bash script, plus fzf and the
  systemd tools already on the machine.
- Every GitHub Action is pinned to a commit hash rather than a tag, so a
  moved tag cannot change what runs in CI. Dependabot proposes the updates.
- The test suite runs on every push, against the oldest and newest
  supported fzf.
- The install script checks what it downloaded before installing it, and
  is written so that a truncated download runs nothing at all.
- Releases are built by a workflow from a tag, and the workflow refuses to
  publish if the tag, `VERSION` and `SYSZ_VERSION` disagree.
