# AGENTS.md

## Repo purpose

This repository is the seed/bootstrap for the owner's Linux system.

It serves two main jobs:

1. install the base tools and runtimes needed on a fresh machine
2. manage personal configuration files from the repo, then symlink them into the home directory

This is a personal dotfiles repo, not a general-purpose library or app.

## Primary goals

- make a new machine usable quickly
- keep setup reproducible and easy to re-run
- keep repo-managed config files in version control
- link those configs into `~` / `~/.config` instead of copying them around
- keep machine-specific state, secrets, auth, and session data out of git

## Main workflows

### Fresh machine bootstrap

Preferred path:

- run `scripts/bootstrap.sh`
- that script prepares git/SSH, creates `~/repos`, clones this repo, and can run setup

### After cloning the repo

Common entry points:

- `./scripts/install.sh` — install package managers, runtimes, and tools
- `./scripts/setup.sh` — link repo-managed configs into the home directory and optionally set up Pi
- `./scripts/systemInit.sh` — run install + setup together

Legacy compatibility wrappers still exist:

- `./scripts/seedInstall.sh`
- `./scripts/seedSetup.sh`

## Repo shape

- `scripts/`
  - machine bootstrap, install, setup, and utility scripts
- `scripts/install/`
  - smaller install/linking helpers used by the top-level scripts
- `configs/`
  - repo-managed config files and directories that are linked into the home directory
- `assets/`
  - optional assets such as wallpapers/fonts that may also be linked onto the system
- `configs/pi/`
  - Pi-specific configuration, themes, extensions, skills, and its own scoped agent instructions

## Important implementation assumptions

- this repo is **symlink-first**: the repo remains the source of truth, and files are linked into the home directory
- setup scripts should stay safe to re-run where practical
- bootstrap/install/setup scripts are part of the core product of this repo; changes to them should preserve the new-machine workflow
- compatibility wrappers should not be removed casually unless the calling workflow is updated everywhere

## Agent guardrails

When making changes in this repo:

- preserve the fresh-machine bootstrap flow unless the change is explicitly meant to redesign it
- prefer small, practical changes over broad restructuring
- avoid introducing machine-specific absolute paths unless they are intentionally part of the owner's environment
- do not commit secrets, SSH keys, tokens, session files, or other local state
- treat `configs/pi/sessions/`, auth artifacts, caches, and generated local state as untracked/local unless the owner explicitly asks otherwise
- be cautious with destructive behavior in install/setup scripts; idempotent or backup-friendly behavior is preferred
- if editing something under `configs/pi/`, check for more specific instructions in `configs/pi/AGENTS.md`

## Validation expectations

After changing scripts or config-linking behavior, prefer to validate with the smallest relevant check, for example:

- `./scripts/install.sh --help`
- `./scripts/setup.sh --help`
- `./scripts/systemInit.sh --help`
- `./scripts/install/link-configs.sh --dry-run`

## Source-of-truth docs

- `README.md` is the human-facing overview
- this `AGENTS.md` is the repo-wide agent context file
- nested `AGENTS.md` files may add more specific instructions for subtrees
